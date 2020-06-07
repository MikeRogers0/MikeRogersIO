---
layout: post
title: How to use interpolatable Templates in Stimulus
categories:
 – blog
published: true
meta:
  description: Use Lodash, it has a great template helper which saved manually coding a templating system.
  index: true
---

https://lodash.com/

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
    this.itemData = {
      title: 'Sample Title',
      description: 'Sample Description'
    };

    // Pass the data to our lodash template, and it'll return a string of HTML.
    this.listTarget.innerHTML = this.resourceTemplate(this.itemData);
  }
}
```
