---
layout: page
title: Posts
permalink: /posts/
pagination:
  enabled: true
---

<ul>
  {% for post in paginator.documents %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>

{% if paginator.total_pages > 1 %}
  <ul class="pagination">
    {% if paginator.previous_page %}
    <li>
      <a href="{{ paginator.previous_page_path }}">Previous Page</a>
    </li>
    {% endif %}
    {% if paginator.next_page %}
    <li>
      <a href="{{ paginator.next_page_path }}">Next Page</a>
    </li>
    {% endif %}
  </ul>
{% endif %}

<nav class="border-t border-gray-200 px-4 flex items-center justify-between sm:px-0 mt-6">
  <div class="w-0 flex-1 flex">
    <a href="{{ paginator.previous_page_path }}" class="-mt-px border-t border-transparent pt-4 pr-1 inline-flex items-center text-sm hover:border-gray-300 focus:border-gray-400">
      Previous Page
    </a>
  </div>

  <div class="hidden md:flex">
    <div class="pt-4 px-4 inline-flex items-center text-sm ">
     Page {{ paginator.page }} of {{ paginator.total_pages }}
    </div>
  </div>
  <div class="w-0 flex-1 flex justify-end">
    <a href="{{ paginator.next_page_path }}" class="-mt-px border-t border-transparent pt-4 pl-1 inline-flex items-center text-sm hover:border-gray-300 focus:border-gray-400">
      Next Page
    </a>
  </div>
</nav>
