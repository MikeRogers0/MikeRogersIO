---
layout: post
title: Listening to Bootstrap Events in Stimulus
categories:
 – blog
published: true
meta:
  description: Bootstrap fires events via jQuery, which doesn't play to nicely with Stimulus. Here is how to make them play nicely.
  index: true
---

I love [Bootstrap 4](https://getbootstrap.com) & [Stimulus](https://stimulusjs.org), both are fantastic libraries that allow me to focus on spending the majority of my time writing ruby. However they required a bit of setup to help them play nicely together.

If you want to skip ahead and see the working final solution, I've posted [the code to GitHub](https://github.com/MikeRogers0/BootstrapAndStimulusExample) & you can deploy it to Heroku to see it working.

## The Approach

Bootstrap's events (like `show.bs.modal` & `hide.bs.modal`) are triggered via the jQuery `trigger()` method, which unfortunately [doesn't create an event that we can listen for with `addEventListener`](https://stackoverflow.com/a/24212373), which means I can't bind the events to `data-action` like stimulus likes.

I'm going to explicitly bind the events in the Stimulus controller using the jQuery `on()` method to get around this.

### The HTML

I took this from the [Bootstrap Modal Docs](https://getbootstrap.com/docs/4.3/components/modal/), and then sprinkled in the `data-controller="open-counter"` & `data-target="open-counter.openCountOutput"` attributes.

```html
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div
  class="modal fade"
  id="exampleModal"
  tabindex="-1"
  role="dialog"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
  data-controller="open-counter"
  >
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>You've opened this modal <span data-target="open-counter.openCountOutput">0</span> times</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
```

### The Stimulus Controller

```javascript
// app/javascript/controllers/open_counter_controller.js
// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "openCountOutput" ]

  connect() {
    let openCounterController = this;
    this.openCount = 0;

    // The listner for the Bootstrap event via jQuery
    $(this.element).on('show.bs.modal', (event) => {
      openCounterController.incrementCount();
    })
  }

  incrementCount() {
    this.openCount++;
    this.openCountOutputTarget.textContent = this.openCount;
  }
}
```

### Making jQuery available in Webpacker

One of the big "gotchas" of the modern approach to JS is everything should be broken up into modules, where a module specifies what libraries it requires. This helps Webpacker optimise your code when you compile it for production, but can be a little annoying when working with old jQuery plugins.

But don't worry, if you modify your `config/webpack/environment.js` file you can use jQuery like before:

```
// config/webpack/environment.js
const { environment } = require('@rails/webpacker')

// Add the following section to make jQuery play nicely with Webpacker.
// From: http://blog.blackninjadojo.com/ruby/rails/2019/03/01/webpack-webpacker-and-modules-oh-my-how-to-add-javascript-to-ruby-on-rails.html
const webpack = require("webpack");
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery"
  })
)


module.exports = environment
```
