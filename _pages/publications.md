---
layout: archive
title: "Recent Publications and Talks"
permalink: /publications/
author_profile: true
---

{% if author.googlescholare %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single3.html %}
{% endfor %}
