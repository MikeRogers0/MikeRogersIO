---
layout: post
title: Using ActionCable & Stimulus to remotely update partials in Rails 6
description: How to provide real-time updates to a user in Rails 6, without having to reload the page.
---

Displaying the most up-to-date information to users is one of the main challenges facing modern web applications. A common use case would be a change to the contents of the page, which could change the actions the user can perform.

There are many ways to solve this and in this post I'm going to cover an approach that'll push an updated partial to the user, without adding too much extra to the vanilla Ruby On Rails stack.

If you want to skip ahead and see the working final solution, I've posted [the code to GitHub](https://github.com/MikeRogers0/RealtimePartialUpdateApp), which you can deploy to Heroku to see it working.

## The Approach

When a user loads the page, we're going to connect them to a Web Socket using [ActionCable](https://guides.rubyonrails.org/action_cable_overview.html). When the contents of the objects they're looking at change, we'll update their HTML by pushing updated partials to their browser.

I'm also going to use [Stimulus](https://stimulusjs.org/) to handle connecting to the Web Socket and updating HTML, as it's very lightweight & it plays very nicely with Turbolinks.

## Let's get coding!

### The ActionCable Channel

This is the object that'll help us organise our data, a bit like a TV channel (where the element is watching this channel, waiting for data to come through).

When the user connects, they'll pass a `key` parameter, which is a friendly name for us to send only the HTML the user is awaiting changes for.

```ruby
# app/channels/realtime_partial_channel.rb
class RealtimePartialChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:key]
  end
end
```

### The ActiveJob

Generating a new partial may take a moment, so we'll want to have that handled in an ActiveJob. This will improve the response time for the user who triggers the initial partial update.

```ruby
# app/jobs/partials/comments/list_job.rb
class Partials::Comments::ListJob < ApplicationJob
  queue_as :default

  # This will push the updated partial to the user via ActionCable.
  def perform
    # 'comments/list' is the key we defined in the view, and is passed to the RealtimePartialChannel via stimulus.
    # `render(Comment.all)` is a little bit of rails magic, that will return the same HTML as running
    # <%= render(Comment.all) %> in our erb view.
    RealtimePartialChannel.broadcast_to('comments/list', {
      body: ApplicationController.render(Comment.all, layout: false)
    })
  end
end
```

### The Stimulus Controller

To say "this bit of HTML is a stimulus controller", we just wrap it in an element using the `data-controller` attribute referencing our stimulus controllers name.

```erb
<!-- app/views/comments/index.html.erb -->
<!-- This will render a collection Comments using the app/views/comments/_comment.html.erb partial -->
<tbody data-controller="realtime-partial" data-realtime-partial-key="comments/list">
  <%= render @comments %>
</tbody>
```

Then we can write a stimulus controller that'll connect to the web socket when the above HTML is connected to our webpage.

```javascript
// app/javascript/controllers/realtime_partial_controller.js
// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This realtime-partial controller will update partials via ActionCable.
//
// <div data-controller="realtime-partial" data-realtime-partial-key="A friendly name for your partial">
//   <p>Any HTML here</p>
// </div>

import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  initialize () {
    // Is run first. In this case we don't need to worry about anything.
  }

  connect() {
    let realtimePartialController = this;

    this.subscription = consumer.subscriptions.create(
      {
        channel: "RealtimePartialChannel",
        key: this.data.get("key")
      },
      {
        connected() {
          // Called when the subscription is ready for use on the server
        },
        disconnected() {
          // Called when the subscription has been terminated by the server
        },
        received(data) {
          realtimePartialController.renderPartial(data);
        }
      }
    );
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  renderPartial(data) {
    let newBody = this._parseHTMLResponse(data['body']);

    // Replace all data-turbolinks-permanent elements in the body with what was there
    // previously. This is useful for elements the user might interact with, such
    // as forms or dropdowns.
    let permanentNodes = this.element.querySelectorAll("[id][data-turbolinks-permanent]");
    permanentNodes.forEach(function(element){
      var oldElement = newBody.querySelector(`#${element.id}[data-turbolinks-permanent]`)
      oldElement.parentNode.replaceChild(element, oldElement);
    });

    // Remove all the current nodes from our element.
    while( this.element.firstChild ) { this.element.removeChild( this.element.firstChild ); }

    // When we're sending a new partial, which is a full replacement of our
    // element & not just a group of children.
    if( newBody.childElementCount === 1 && newBody.firstElementChild.dataset.realtimePartialKey === this.data.get("key") ){
      while( newBody.firstElementChild.firstChild ) { this.element.appendChild( newBody.firstElementChild.firstChild ); }
    } else {
      // Append the new nodes.
      while( newBody.firstChild ) { this.element.appendChild( newBody.firstChild ); }
    }
  }

  // From: https://stackoverflow.com/a/42658543/445724
  // using .innerHTML= is risky. Instead we need to convert the HTML received
  // into elements, then append them.
  // It's wrapped in a <template> tag to avoid invalid (e.g. a block starting with <tr>)
  // being mutated inappropriately.
  _parseHTMLResponse(responseHTML){
    let parser = new DOMParser();
    let responseDocument = parser.parseFromString( `<template>${responseHTML}</template>` , 'text/html');
    let parsedHTML = responseDocument.head.firstElementChild.content;
    return parsedHTML;
  }
}
```

### Pushing the updated partial

Whenever a new comment is created, we'll queue up the job to send the new partial to the connected users via ActiveJob.

```ruby
# app/controllers/comments_controller.rb

class CommentsController < ApplicationController
  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      # Queue up the ActiveJob job to update the partial.
      Partials::Comments::ListJob.perform_later
      redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end
end
```

## That's it!

Now whenever a new comment is posted, a user looking at the index will have their view updated with the latest content. Awesome!
