---
title: Test Page
permalink: test
---

{% assign menu = page.menu.test-page %}
<ul class="{{ menu.class }}">
{% for item in menu.items %}
  <li class="{{ item.class }}">
    <a href="{{ item.link }}" class="{{ item.link_class }}">{{ item.title }}</a>
    {% if item.menu %}
      {% assign menu = item.menu %}
      <ul class="{{ menu.class }}">
      {% for item in menu.items %}
        <li class="{{ item.class }}">
          <a href="{{ item.link }}" class="{{ item.link_class }}">{{ item.title }}</a>
        </li>
      {% endfor %}
      </ul>
    {% endif %}
  </li>
{% endfor %}
</ul>
