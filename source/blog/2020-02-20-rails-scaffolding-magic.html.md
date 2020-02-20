---
layout: post
title: How to override the Rails default Scaffolding
categories:
 – blog
published: true
meta:
  description: How to stop doing the same darn thing.
  index: true
---

One under documented aspects of Ruby on Rails is how to improve your development process by overriding the scaffolding templates.

Doing this allows you to have greater control over the files that are created when you run `rails generate scaffold`, which is helpful for if you're regularly adding the same changes to a new module or you'd add some extra boilerplate to an app.

## Why would you want to override the templates?

The base scaffolding is great, but you may want to enforce a more bespoke aspect of your layout which requires some extra code to be present by default. For example wrapping things in an extra div, or a different way of displaying validation errors.

## A different index page

The template for the [index.html.erb](https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators/erb/scaffold/templates/index.html.erb.tt) is a file I often want to have reorganised to show the action buttons above the table.

To do this, create a file in within your app in the location `lib/templates/erb/controller/view.html.erb.tt`, with the contents:

```erb
<h1><%= plural_table_name.titleize %></h1>

<div class="actions">
  <%%= link_to 'New <%= singular_table_name.titleize %>', new_<%= singular_route_name %>_path %>
</div>

<table class="table">
  <thead>
    <tr>
<% attributes.reject(&:password_digest?).each do |attribute| -%>
      <th><%= attribute.human_name %></th>
<% end -%>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <%% @<%= plural_table_name %>.each do |<%= singular_table_name %>| %>
      <tr>
<% attributes.reject(&:password_digest?).each do |attribute| -%>
        <td><%%= <%= singular_table_name %>.<%= attribute.name %> %></td>
<% end -%>
        <td><%%= link_to 'Show', <%= model_resource_name %> %></td>
        <td><%%= link_to 'Edit', edit_<%= singular_route_name %>_path(<%= singular_table_name %>) %></td>
        <td><%%= link_to 'Destroy', <%= model_resource_name %>, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <%% end %>
  </tbody>
</table>
```

## Creating a better form



## A different model

https://github.com/rails/rails/blob/98a57aa5f610bc66af31af409c72173cdeeb3c9e/activerecord/lib/rails/generators/active_record/model/templates/model.rb.tt

## Where are things from

One of the less documented aspects of Ruby on Rails is how to speed up your development process by overriding the scaffolding templates. By this I mean the files which are created when you run `rails generate scaffold`.



```
lib/templates/erb/controller/view.html.erb.tt
lib/templates/erb/scaffold/_form.html.erb
```

## References

https://github.com/rails/rails/tree/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators - Where all the generators live
