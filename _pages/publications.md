---
layout: archive
title: "Publications and Talks"
permalink: /publications/
author_profile: true
---

Research
------
- In my past work, I have been interested in classical statistics in general and more specifically in geostatistics and biostatistics.
Currently I am interested in ML and specifically in unsupervised learning. I am also interested in NLP.

- My thesis focuses on clustering of longitudinal data and sequence analysis. With applications in health (life course, health course, care course, treatment sequences, ...)

- I am open to discuss with you

Peer-reviewed publications
======

{% if author.googlescholare %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single3.html %}
{% endfor %}
