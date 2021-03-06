# jekyll-menu [![Build Status](https://travis-ci.org/helpscout/jekyll-menu.svg?branch=master)](https://travis-ci.org/helpscout/jekyll-menu) [![Gem Version](https://badge.fury.io/rb/jekyll-menu.svg)](https://badge.fury.io/rb/jekyll-menu)

Easy menu creation with YAML data

## Work in progress! Stay tuned. 🤓

## Usage

**Example menu.yml file**
`_data/menus/example.yml`

```yaml
- title: Home
  link: "/"
- title: Blog
- title: Seed
  link: "http://developer.helpscout.net/seed/"
- title: Contact
```

**Example markup in your `.html` or `.md` file**
```html
{% assign menu = page.menu.example %}
<ul class="{{ menu.class }}">
{% for item in menu.items %}
  <li class="{{ item.class }}">
    <a href="{{ item.link }}" class="{{ item.link_class }}">{{ item.title }}</a>
  </li>
{% endfor %}
</ul>
```

**Compiles to…**
```html
<ul class="c-menu">
  <li class="c-menu__item is-active">
    <a href="/" class="c-menu__link is-acitve">Home</a>
  </li>
  <li class="c-menu__item">
    <a href="/blog" class="c-menu__link">Blog</a>
  </li>
  <li class="c-menu__item">
    <a href="http://developer.helpscout.net/seed/" class="c-menu__link">Seed</a>
  </li>
  <li class="c-menu__item">
    <a href="/contact" class="c-menu__link">Contact</a>
  </li>
</ul>
```

🙌
