---
layout: post
title: How to override the Ruby on Rails default scaffolding
categories:
 – blog
published: true
meta:
  description: How to stop doing the same darn thing.
  index: true
---

One under documented aspects of Ruby on Rails is how to improve your development process by overriding the scaffolding templates.

Doing this allows you to have greater control over the files that are created when you run `rails generate scaffold`. While this is fairly unusual to see this in a project, it's an interesting approach for if you have a design which requires views to include extra markup to look consistent.

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

Now when you run `rails generate scaffold` it'll use the above file for the template for the `index.html.erb` file.

## Other file template you can override

There a bunch of other files you can override, here is a list of where to find them in the rails core:

 - Forms - https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators/erb/scaffold/templates/_form.html.erb.tt
 - Show pages - https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators/erb/scaffold/templates/show.html.erb.tt
 - Controllers - https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators/rails/controller/templates/controller.rb.tt
 - Models - https://github.com/rails/rails/blob/98a57aa5f610bc66af31af409c72173cdeeb3c9e/activerecord/lib/rails/generators/active_record/model/templates/model.rb.tt
 - ActiveJob Tests - https://github.com/rails/rails/blob/b2eb1d1c55a59fee1e6c4cba7030d8ceb524267c/railties/lib/rails/generators/test_unit/job/templates/unit_test.rb.tt
