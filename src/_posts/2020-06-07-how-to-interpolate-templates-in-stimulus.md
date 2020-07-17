---
layout: post
title: How To Interpolate Templates in Stimulus
description: 'TL;DR: Use Lodash, it has a great template function that saved me manually coding a templating system.'
---

I needed to display a set of JSON search results as HTML within a Stimulus project recently. Stimulus doesn't offer much guidance on how to solve this out the box, so I had a little dive.

I ended up finding that lodash had a built in [`template`](https://lodash.com/docs/4.17.15#template) function which supported interpolation. Here is the code I ended up with:

```html
<div data-controller="search">
  <template data-target="search.resourceTemplate">
    <div class="resource">
      <h2>${title}</h2>
      <p>${description}</p>
    </div>
  </template>

  <div data-target="search.list">
    <!-- This will be replaced with the interpolated template  -->
  </div>
</div>
```

```javascript
// controllers/search_controller.js
import { Controller } from "stimulus"
import { template } from "lodash"

export default class extends Controller {
  static get targets() {
    return [ "resourceTemplate", "list" ]
  }

  connect() {
    // https://lodash.com/docs/4.17.15#template
    // Convert the contents of the template tag, into a lodash template:
    this.resourceTemplate = template(this.resourceTemplateTarget.innerHTML);

    this._renderResults();
  }

  _renderResults() {
    // Setup some sample data to interpolate into the template.
    // In my real app, this was loaded via AJAX.
    this.itemData = {
      title: 'Sample Title',
      description: 'Sample Description'
    };

    // Pass the data to our lodash template, and it'll return a string of HTML.
    this.listTarget.innerHTML = this.resourceTemplate(this.itemData);
  }
}
```
