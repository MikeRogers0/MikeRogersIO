---
layout: post
title: How to use Templates in Stimulus
categories:
 – blog
published: true
meta:
  description: Use Lodash, it has a great template helper!
  index: true
---

https://lodash.com/

```html
<div data-controller="search">
  <template data-target="search.resourceTemplate">
    <div class="resource">
      <h2>%{title}</h2>
      <p>%{description}</p>
    </div>
  </template>

  <div data-target="search.list">
  </div>
</div>
```

```javascript
import { Controller } from "stimulus"
import { template, find } from "lodash"

export default class extends Controller {
  static get targets() {
    return [ "resourceTemplate", "list" ]
  }

  initialize() {
    this.itemData = {title: 'Sample Title', description: 'Sample Description'};
  }

  connect() {
    this.resourceTemplate = template(this.resourceTemplateTarget.innerHTML);

    this._renderResults();
  }

  _renderResults() {
    this.listTarget.innerHTML = this.resourceTemplate(this.itemData);
  }
}
```
