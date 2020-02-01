---
layout: post
title: How to use Rails.ajax in Stimulus Controllers
categories:
 – blog
published: true
meta:
  description: Make AJAX calls using Rails.ajax by including UJS into your Stimulus controller files.
  index: true
---

I'm a big fan of using [Rails UJS](https://guides.rubyonrails.org/working_with_javascript_in_rails.html#unobtrusive-javascript), it's a really nice way to handle 90% of the things I need to do by sprinkling a little bit of extra markup into my HTML.

I recently needed to make an AJAX call within a stimulus controller. Initially I looked at using [the Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API), however I needed to support IE & wanted an easy way to include CSRF Protection.

In the past I've been able to use [`Rails.ajax`](https://github.com/rails/rails/blob/cb3b37b37975ceb1d38bec9f02305ff5c14ba8e9/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L15) for this. It handles CSRF Protection out of the box & is pretty straight forward to use. However when I added it to my Stimulus controller I received a "Rails is undefined" error (As modern JS requires you to declare which libraries each JavaScript file is using).

Here is the code I ended up with to get it working:

```javascript
// app/javascript/controllers/ajax_request_controller.js
import { Controller } from "stimulus"

// Import UJS so we can access the Rails.ajax method
import Rails from "@rails/ujs";

/*
 *
 * Usage:
 * <form data-controller="ajax-request" data-ajax-request-url="/sample-path">
 *   <button data-action="click->ajax-request#makeRequest">Make Request</button>
 * </form>
 *
 */
export default class extends Controller {

  /*
   * https://github.com/rails/rails/blob/cb3b37b37975ceb1d38bec9f02305ff5c14ba8e9/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L15
   * UJS has a nice Rails.ajax method, which worked in older version of IE & is a lot like jQuery's $.ajax
   */
  makeRequest() {
    Rails.ajax({
      type: "post",
      url: this.data.get('url'),
      data: new FormData(this.element)
    })
  }
}
```
