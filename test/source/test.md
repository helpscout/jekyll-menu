---
title: Test Page
permalink: test
---

<ul class="c-menu">
{% for item in page.menu.test-page %}
  <li class="{{ item.class }}">
    <a href="{{ item.link }}">{{ item.title }}</a>
    {% if item.items %}
      <ul class="{{ item.class }}">
      {% for item in item.items %}
        <li class="{{ item.class }}">
          <a href="{{ item.link }}">{{ item.title }}</a>
        </li>
      {% endfor %}
      </ul>
    {% endif %}
  </li>
{% endfor %}
</ul>
