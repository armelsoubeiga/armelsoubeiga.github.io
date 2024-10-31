---
title: 'Installation de Tensorflow sur winpython'
date: 2019-12-19
permalink: /posts/2019/12/installation-de-tensorflow-sur-winpython
tags:
  - installation
  - tensorflow
  - winpython
author_profile: false
toc: true
---

{% include toc %}

<h2>Introduction</h2>

<h2><span style="font-size:16px">Si vous &ecirc;tes entrain&nbsp;de lire ce poste, cela voudrait dire que vous aussi, vous avez pass&eacute; une semaine (ou voir plus que &ccedil;a) &agrave; essayer d&#39;installer tensorflow sur votre windows 10 sans une carte graphique GPU, ni un pocesseur NVIDA et sans ANACONDA.</span></h2>

<p><span style="font-size:16px">Tensorflow, le framework d&rsquo;intelligence artificielle de Google, se d&eacute;cline en deux versions : la premi&egrave;re utilise votre&nbsp;processeur&nbsp;pour faire les calculs (c&rsquo;est la version de base), tandis que la seconde s&rsquo;appuie sur votre&nbsp;carte graphique&nbsp;(c&rsquo;est la version GPU).</span></p>

<p><span style="font-size:16px">Dans ce poste je vais vous montrer&nbsp;comment installer&nbsp;<a href="https://www.tensorflow.org/">Tensorflow</a>&nbsp; cpu sur windows.&nbsp;</span></p>

<p>&nbsp;</p>

<p><span style="font-size:20px">Quelques pr&eacute;-requis</span></p>

<p><span style="color:#3498db"><span style="font-size:18px">Installation de&nbsp;Python</span></span></p>

<p><span style="font-size:16px">Que ferait-on sans Python? Pour la suite et comme nous l&#39;avons d&egrave;j&agrave; mentionn&eacute; dans le pr&eacute;ambule, nous allons installer&nbsp;winpython 3.7.4.&nbsp;<a href="http://winpython.sourceforge.net/">winpython</a>.</span></p>

<p>&nbsp;</p>

<blockquote>
<p><span style="font-size:14px"><em>WinPython est une distribution portable open-source gratuite du langage de programmation python&nbsp;pour Windows XP /&nbsp;7/8/10 , con&ccedil;ue pour les scientifiques, prenant en charge les versions 32 bits et 64 bits de Python 2 et Python 3.</em></span></p>
</blockquote>

<p>.</p>

<p><span style="font-size:18px"><img alt="" src="images/media/uploads/2019/12/19/capture_jxItEdr.PNG" style="height:88px; width:700px" /></span></p>

<p><span style="font-size:16px"><em><strong>ATTENTION&nbsp;</strong></em>: les mises &agrave; jour de Tensorflow sont d&eacute;call&eacute;es par rapport aux sorties des versions de Python. A l&rsquo;heure o&ugrave; j&rsquo;&eacute;cris ce tutoriel, Tensorflow n&rsquo;est pas encore compatible avec Python 3.7 pour windows avec conda mais, je dis bien mais, il est disponible pour winpython&nbsp;. Pensez &agrave; v&eacute;rifier quelle est la derni&egrave;re version g&eacute;r&eacute;e&nbsp;<img alt="angel" src="https://armelsoubeiga.pythonanywhere.com/static/ckeditor/ckeditor/plugins/smiley/images/angel_smile.png" style="height:23px; width:23px" title="angel" />.</span></p>

<p><span style="font-size:16px">Une fois l&#39;installation finie, ouvrez une console et &eacute;crivez python. Si tout se passe bien vous devriez avoir quelque chose comme &ccedil;a:&nbsp;On vois don que j&#39;utilise la version 3.7.4</span></p>

<p>&nbsp;</p>

<p><span style="font-size:18px"><img alt="" src="images/media/uploads/2019/12/19/capture_SuT9I5Z.PNG" style="height:107px; width:700px" /></span></p>

<p>&nbsp;</p>

<h3><span style="color:#3498db"><span style="font-size:18px">Installation de&nbsp;pip</span></span></h3>

<p><span style="font-size:16px">Nous allons installer tensorflow en utilisant la commande <em><code>pip install</code></em>&nbsp;pour cela nous avons besoin en priorit&eacute; que pip soit install. Alors vous devrez relancer votre terminal et tapper la commande suivante&nbsp;<em><code>python -m pip install -U pip</code></em>. Cela vous installe la derni&egrave;re version de pip .&nbsp;</span></p>

<p>&nbsp;</p>

<h2><span style="color:#3498db"><span style="font-size:18px">Installation&nbsp;de Tensorflow CPU</span></span></h2>

<p><span style="font-size:16px">J&#39;aimerai vous dire d&#39;utiliser la commande courant (pip install tensorflow) mais cela vous installerez&nbsp;la derni&egrave;re version de tensorflow disponible (la version <strong>2.x</strong> au moment o&ugrave; j&#39;&eacute;cris ce post). Et cette version n&eacute;cessite&nbsp;un processeur&nbsp;GPU NVIDA . Ce qui ne fonctionnera pas.</span></p>

<p><span style="font-size:16px">Je partage avec vous un repertoire github qui ressence toutes les versions possibles de tensorflow en fonction de la version de python compatible, de la pr&eacute;sence d&#39;un GPU/CPU sur votre pc et en fonction de la pr&eacute;sence d&#39;une carte graphique NVIDA ou pas:&nbsp;<a href="https://github.com/fo40225/tensorflow-windows-wheel">tensorflow-windows-wheel</a>.</span></p>

<p><span style="font-size:16px">Pour ce tutoriel vous devrez telechargez une version&nbsp;&lt;filename.wh&gt; contenu dans un repertoire&nbsp; <code>sse2</code>.&nbsp;Ensuite vous devrez maintenant placer le fichier telecharg&eacute; dans le dossier d&#39;intallation de python et plus pr&eacute;cisement dans le repertoire scripts.&nbsp;</span></p>

<p>&nbsp;</p>

<p><span style="font-size:18px"><img alt="" src="images/media/uploads/2019/12/19/capture_wv3n3U4.PNG" style="height:164px; width:700px" /></span></p>

<p><span style="font-size:16px">Et enfin , vous installez en tapant la commande pip install <code>&lt;nom fichier.wh &gt;</code> et vous attendez quelques minutes jusqu&#39;&agrave; la fin de l&#39;installation.&nbsp;&nbsp;</span>&nbsp;&nbsp;</p>

<p>&nbsp;</p>

<h2><span style="font-size:20px">CONCLUSION</span></h2>

<p><span style="font-size:16px">En bref, voici en quelques lignes comment installer tensorflow sans avoir&nbsp; un processeur GPU NVIDA. N&#39;h&eacute;sitez pas &agrave; laisser en commentaire vos suggestions.&nbsp;</span></p>
