---
title: 'Interface graphique en Python à l'aide de Tkinter'
date: 2020-08-25
permalink: /posts/2020/08/interface-graphique-en-python-à-l-aide-de-tkinter
tags:
  - interface
  - graphique
  - python
author_profile: false
toc: true
---

{% include toc %}

<p>Vous cherchez &agrave; cr&eacute;er une interface utilisateur graphique (GUI) en Python &agrave; l&#39;aide de tkinter?</p>

<p>Si tel est le cas, dans cet article, je vais vous montrer comment cr&eacute;er une interface graphique tkinter. Pour commencer, je vais partager le code complet que vous pouvez coller dans Python afin de cr&eacute;er l&#39;interface graphique tkinter ci-dessous. J&#39;expliquerai ensuite les principales parties du code.</p>

<p>Vous devrez vous assurer que le &nbsp;package <strong><em>matplotlib </em></strong>est install&eacute; dans python. Ce package est utilis&eacute; pour afficher les graphiques.&nbsp;</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><strong><em><span style="font-family:Courier New,Courier,monospace">import tkinter as tk<br />
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg<br />
from matplotlib.figure import Figure<br />
root= tk.Tk()</span></em></strong></span></div>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-family:Courier New,Courier,monospace"><strong><em>canvas1 = tk.Canvas(root, width = 800, height = 300)<br />
canvas1.pack()<br />
&nbsp;<br />
label1 = tk.Label(root, text=&quot;Graphical User Interface&quot;)<br />
label1.config(font=(&#39;Arial&#39;, 20))<br />
canvas1.create_window(400, 50, window=label1)<br />
&nbsp;&nbsp;&nbsp;<br />
entry1 = tk.Entry (root)<br />
canvas1.create_window(400, 100, window=entry1)&nbsp;<br />
&nbsp;&nbsp;<br />
entry2 = tk.Entry (root)<br />
canvas1.create_window(400, 120, window=entry2)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
entry3 = tk.Entry (root)<br />
canvas1.create_window(400, 140, window=entry3)&nbsp;</em></strong></span></span></div>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-family:Courier New,Courier,monospace"><strong><em>def create_charts():<br />
&nbsp;&nbsp;&nbsp;&nbsp;global x1<br />
&nbsp;&nbsp;&nbsp;&nbsp;global x2<br />
&nbsp;&nbsp;&nbsp;&nbsp;global x3<br />
&nbsp;&nbsp;&nbsp;&nbsp;global bar1<br />
&nbsp;&nbsp;&nbsp;&nbsp;global pie2<br />
&nbsp;&nbsp;&nbsp;&nbsp;x1 = float(entry1.get())<br />
&nbsp;&nbsp;&nbsp;&nbsp;x2 = float(entry2.get())<br />
&nbsp;&nbsp;&nbsp;&nbsp;x3 = float(entry3.get())<br />
&nbsp;&nbsp;&nbsp;&nbsp;figure1 = Figure(figsize=(4,3), dpi=100)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot1 = figure1.add_subplot(111)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;xAxis = [float(x1),float(x2),float(x3)]&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;yAxis = [float(x1),float(x2),float(x3)]&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot1.bar(xAxis,yAxis, color = &#39;lightsteelblue&#39;)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;bar1 = FigureCanvasTkAgg(figure1, root)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;bar1.get_tk_widget().pack(side=tk.LEFT, fill=tk.BOTH, expand=0)<br />
&nbsp;&nbsp;&nbsp;&nbsp;figure2 = Figure(figsize=(4,3), dpi=100)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot2 = figure2.add_subplot(111)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;labels2 = &#39;Label1&#39;, &#39;Label2&#39;, &#39;Label3&#39;&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;pieSizes = [float(x1),float(x2),float(x3)]<br />
&nbsp;&nbsp;&nbsp;&nbsp;my_colors2 = [&#39;lightblue&#39;,&#39;lightsteelblue&#39;,&#39;silver&#39;]<br />
&nbsp;&nbsp;&nbsp;&nbsp;explode2 = (0, 0.1, 0) &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot2.pie(pieSizes, colors=my_colors2, explode=explode2, labels=labels2, autopct=&#39;%1.1f%%&#39;, shadow=True, startangle=90)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot2.axis(&#39;equal&#39;) &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;pie2 = FigureCanvasTkAgg(figure2, root)<br />
&nbsp;&nbsp;&nbsp;&nbsp;pie2.get_tk_widget().pack()</em></strong></span></span></div>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><strong><em>def clear_charts():<br />
&nbsp; &nbsp; bar1.get_tk_widget().pack_forget()<br />
&nbsp; &nbsp; pie2.get_tk_widget().pack_forget()</em></strong></span></div>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><strong><em>button1 = tk.Button (root, text=&#39; Create Charts&nbsp;&#39;,command=create_charts, bg=&#39;palegreen2&#39;, font=(&#39;Arial&#39;, 11, &#39;bold&#39;))&nbsp;<br />
canvas1.create_window(400, 180, window=button1)<br />
&nbsp;&nbsp; &nbsp;<br />
button2 = tk.Button (root, text=&#39; &nbsp;Clear Charts&nbsp; &#39;, command=clear_charts, bg=&#39;lightskyblue2&#39;, font=(&#39;Arial&#39;, 11, &#39;bold&#39;))<br />
canvas1.create_window(400, 220, window=button2)<br />
&nbsp;&nbsp; &nbsp;<br />
button3 = tk.Button (root, text=&quot;Exit Application&quot;, command=root.destroy, bg=&#39;lightsteelblue2&#39;, font=(&#39;Arial&#39;, 11, &#39;bold&#39;))<br />
canvas1.create_window(400, 260, window=button3)</em></strong></span></div>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><strong><em><span style="font-family:Courier New,Courier,monospace">root.mainloop()</span></em></strong></span></div>

<p>&nbsp;</p>

<h2 style="text-align:start"><strong>Plongeons maintenant dans les principaux composants du code Python:</strong></h2>

<h2><strong>La toile</strong></h2>

<p style="text-align:start">Le canevas est votre &eacute;cran GUI dans lequel vous pouvez placer des &eacute;l&eacute;ments, tels que des boutons, des &eacute;tiquettes, des zones de saisie, etc.&nbsp;Vous pouvez contr&ocirc;ler les dimensions du canevas en modifiant les valeurs de largeur et de hauteur.</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><em><strong><span style="font-size:17px"><span style="background-color:#eeeeee"><span style="font-family:monospace"><span style="font-size:14px"><span style="font-family:Courier New,Courier,monospace">canvas1 = tk.Canvas (racine, largeur = 800, hauteur = 300)<br />
canvas1.pack()</span></span></span></span></span></strong></em></span></div>

<p>&nbsp;</p>

<h2><strong>L&#39;&eacute;tiquette</strong></h2>

<p style="text-align:start">Les &eacute;tiquettes peuvent &ecirc;tre utilis&eacute;es pour imprimer du texte sur le dessus du canevas.&nbsp;Ici, une &eacute;tiquette a &eacute;t&eacute; ajout&eacute;e pour afficher le texte suivant:</p>

<p style="text-align:start">Vous pouvez sp&eacute;cifier une famille de police et une taille de police diff&eacute;rentes pour votre &eacute;tiquette.&nbsp;Dans notre cas, la famille de polices est&nbsp;&laquo;Arial&raquo;&nbsp;et la taille de police est &laquo;&nbsp;20&raquo;.</p>

<p>Enfin, vous pouvez contr&ocirc;ler la position de l&#39;&eacute;tiquette en modifiant les coordonn&eacute;es sur la derni&egrave;re ligne ci-dessous (pour notre exemple, les coordonn&eacute;es sont 400 et 50):</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-size:17px"><span style="background-color:#eeeeee"><span style="font-family:monospace"><span style="font-size:14px"><strong><em><span style="font-family:Courier New,Courier,monospace">label1 = tk.Label (root, text = &#39;Interface utilisateur graphique&#39;)<br />
label1.config (font = (&#39;Arial&#39;, 20))<br />
canvas1.create_window (400, 50, fen&ecirc;tre = &eacute;tiquette1)</span></em></strong></span></span></span></span></span></div>

<h3 style="text-align:start">&nbsp;</h3>

<h2 style="text-align:start"><strong>Les bo&icirc;tes d&#39;entr&eacute;e</strong></h2>

<p>Les 3 chanmps de saisies permettent de collecter des informations aupr&egrave;s de l&#39;utilisateur.&nbsp;Ces informations seront ensuite utilis&eacute;es pour cr&eacute;er les graphiques matplotlib</p>

<p>Comme pr&eacute;c&eacute;demment, vous pouvez contr&ocirc;ler la position des zones de saisie en sp&eacute;cifiant les coordonn&eacute;es.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-size:14px"><span style="font-family:Courier New,Courier,monospace"><em><strong>entry1 = tk.Entry (root)<br />
canvas1.create_window(400, 100, window=entry1)<br />
&nbsp;<br />
entry2 = tk.Entry (root)<br />
canvas1.create_window(400, 120, window=entry2)<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
entry3 = tk.Entry (root)<br />
canvas1.create_window(400, 140, window=entry3)</strong></em></span></span></span></div>

<p>&nbsp;</p>

<h2 style="text-align:start"><strong>Les fonctions</strong></h2>

<p style="text-align:start">La fonction &#39;&nbsp;create_charts&nbsp;&#39; sera appel&eacute;e lorsque l&#39;utilisateur cliquera sur le premier bouton (c&#39;est-&agrave;-dire &#39;button1&#39;) pour dessiner les graphiques.</p>

<p>Les informations recueillies dans les bo&icirc;tes de saisie seront ensuite utilis&eacute;es pour repr&eacute;senter les graphiques &agrave; barres et &agrave; secteurs.&nbsp;Voici un guide complet qui explique comment placer des graphqiues sur une interface graphique tkinter.</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-family:Courier New,Courier,monospace"><strong><em>def create_charts():<br />
&nbsp;&nbsp;&nbsp;&nbsp;global x1<br />
&nbsp;&nbsp;&nbsp;&nbsp;global x2<br />
&nbsp;&nbsp;&nbsp;&nbsp;global x3<br />
&nbsp;&nbsp;&nbsp;&nbsp;global bar1<br />
&nbsp;&nbsp;&nbsp;&nbsp;global pie2<br />
&nbsp;&nbsp;&nbsp;&nbsp;x1 = float(entry1.get())<br />
&nbsp;&nbsp;&nbsp;&nbsp;x2 = float(entry2.get())<br />
&nbsp;&nbsp;&nbsp;&nbsp;x3 = float(entry3.get())<br />
&nbsp;&nbsp;&nbsp;&nbsp;figure1 = Figure(figsize=(4,3), dpi=100)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot1 = figure1.add_subplot(111)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;xAxis = [float(x1),float(x2),float(x3)]&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;yAxis = [float(x1),float(x2),float(x3)]&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot1.bar(xAxis,yAxis, color = &#39;lightsteelblue&#39;)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;bar1 = FigureCanvasTkAgg(figure1, root)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;bar1.get_tk_widget().pack(side=tk.LEFT, fill=tk.BOTH, expand=0)<br />
&nbsp;&nbsp;&nbsp;&nbsp;figure2 = Figure(figsize=(4,3), dpi=100)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot2 = figure2.add_subplot(111)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;labels2 = &#39;Label1&#39;, &#39;Label2&#39;, &#39;Label3&#39;&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;pieSizes = [float(x1),float(x2),float(x3)]<br />
&nbsp;&nbsp;&nbsp;&nbsp;my_colors2 = [&#39;lightblue&#39;,&#39;lightsteelblue&#39;,&#39;silver&#39;]<br />
&nbsp;&nbsp;&nbsp;&nbsp;explode2 = (0, 0.1, 0) &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot2.pie(pieSizes, colors=my_colors2, explode=explode2, labels=labels2, autopct=&#39;%1.1f%%&#39;, shadow=True, startangle=90)&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;subplot2.axis(&#39;equal&#39;) &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;pie2 = FigureCanvasTkAgg(figure2, root)<br />
&nbsp;&nbsp;&nbsp;&nbsp;pie2.get_tk_widget().pack()</em></strong></span></span></div>

<p>&nbsp;</p>

<p style="text-align:start">La fonction &#39;&nbsp;clear_charts&nbsp;&#39; sera appel&eacute;e lorsque l&#39;utilisateur cliquera sur le deuxi&egrave;me bouton (c&#39;est-&agrave;-dire, &#39;button2&#39;) pour effacer les graphiques de l&#39;interface graphique:</p>

<p style="text-align:start">&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><strong><em>def clear_charts():<br />
&nbsp; &nbsp; bar1.get_tk_widget().pack_forget()<br />
&nbsp; &nbsp; pie2.get_tk_widget().pack_forget()</em></strong></span></div>

<p>&nbsp;</p>

<h2 style="text-align:start"><strong>Les boutons</strong></h2>

<p style="text-align:start">Le premier bouton (c&#39;est-&agrave;-dire &#39;button1&#39;) peut &ecirc;tre utilis&eacute; pour d&eacute;clencher la fonction &#39;&nbsp;create_charts&nbsp;&#39; afin de dessiner les graphiques. Vous pouvez positionner le bouton sur le canevas en sp&eacute;cifiant les coordonn&eacute;es (dans notre cas, les coordonn&eacute;es sont 400 et 180):</p>

<p>&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-size:17px"><span style="background-color:#eeeeee"><span style="font-family:monospace"><strong><em><span style="font-size:14px">button1 = tk.Button (root, text=&#39; Create Charts &#39;,command=create_charts, bg=&#39;palegreen2&#39;, font=(&#39;Arial&#39;, 11, &#39;bold&#39;))&nbsp;<br />
canvas1.create_window(400, 180, window=button1)</span></em></strong></span></span></span></span></div>

<p>&nbsp;</p>

<p style="text-align:start">Le deuxi&egrave;me bouton (c&#39;est-&agrave;-dire &#39;button2&#39;) d&eacute;clenche la fonction &#39;&nbsp;clear_charts&nbsp;&#39; pour supprimer les graphiques pr&eacute;c&eacute;dents de l&#39;interface graphique:</p>

<p style="text-align:start">&nbsp;</p>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-size:14px"><span style="font-family:Courier New,Courier,monospace"><em><strong><span style="background-color:#eeeeee">button2 = tk.Button (root, text=&#39; &nbsp;Clear Charts &nbsp;&#39;, command=clear_charts, bg=&#39;lightskyblue2&#39;, font=(&#39;Arial&#39;, 11, &#39;bold&#39;))<br />
canvas1.create_window(400, 220, window=button2)</span></strong></em></span></span></span></div>

<p>&nbsp;</p>

<p style="text-align:start">Le bouton de sortie de l&#39;application (c&#39;est-&agrave;-dire &#39;button3&#39;) d&eacute;clenche la commande &#39;destroy&#39; pour fermer l&#39;interface graphique de tkinter en un clic:</p>

<pre style="text-align:start">
<span style="font-size:17px"><span style="background-color:#eeeeee"><span style="font-family:monospace"><span style="color:#0a0a0a">
</span></span></span></span></pre>

<div style="background:#eeeeee; border:1px solid #cccccc; padding:5px 10px"><span style="color:#8e44ad"><span style="font-family:Courier New,Courier,monospace"><em><strong><span style="font-size:14px"><span style="background-color:#eeeeee">button3 = tk.Button (root, text=&#39;Exit Application&#39;, command=root.destroy, bg=&#39;lightsteelblue2&#39;, font=(&#39;Arial&#39;, 11, &#39;bold&#39;))<br />
canvas1.create_window(400, 260, window=button3)</span></span></strong></em></span></span></div>

<p>&nbsp;</p>

<h2 style="text-align:start"><strong>Lancez l&#39;interface graphique de tkinter</strong></h2>

<p style="text-align:start">Une fois que vous &ecirc;tes pr&ecirc;t, ex&eacute;cutez le code complet en Python, et vous verrez cet &eacute;cran initial:</p>

<p style="text-align:start">&nbsp;</p>

<p style="text-align:start"><span style="font-size:18px"><span style="color:#0a0a0a"><span style="font-family:Arial,Helvetica,Verdana,sans-serif"><span style="background-color:#ffffff"><img alt="" src="images/media/uploads/2020/09/03/1_EWDwEky.png" style="height:343px; width:811px" /></span></span></span></span></p>

<p style="text-align:start">&nbsp;</p>

<p style="text-align:start">Tapez une valeur dans chacune des zones de saisie.&nbsp;Par exemple, saisissez les valeurs de 4, 5 et 6 dans les zones de saisie:</p>

<p style="text-align:start">&nbsp;</p>

<p style="text-align:start"><span style="font-size:18px"><span style="color:#0a0a0a"><span style="font-family:Arial,Helvetica,Verdana,sans-serif"><span style="background-color:#ffffff"><img alt="" src="images/media/uploads/2020/09/03/2.png" style="height:343px; width:812px" /></span></span></span></span></p>

<p style="text-align:start">&nbsp;</p>

<p>Ensuite, cliquez sur le bouton &laquo;&nbsp;<strong>Cr&eacute;er des graphiques</strong>&nbsp;&raquo;:</p>

<p style="text-align:start">&nbsp;</p>

<p style="text-align:start"><span style="font-size:18px"><span style="color:#0a0a0a"><span style="font-family:Arial,Helvetica,Verdana,sans-serif"><span style="background-color:#ffffff"><img alt="" src="images/media/uploads/2020/09/03/3.png" style="height:343px; width:812px" /></span></span></span></span></p>

<p style="text-align:start">&nbsp;</p>

<p style="text-align:start">&nbsp;</p>

<p style="text-align:start">Vous verrez maintenant les deux graphiques dans la section inf&eacute;rieure de votre &eacute;cran (en fonction des 3 valeurs que vous avez tap&eacute;es):</p>

<ul style="margin-left:48px">
	<li>Sur le c&ocirc;t&eacute; gauche, vous verrez le graphique &agrave; barres</li>
	<li>Sur le c&ocirc;t&eacute; droit, vous observerez le graphique &agrave; secteurs (repr&eacute;sentant vos valeurs en%)</li>
</ul>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p style="text-align:start"><span style="font-size:18px"><span style="color:#0a0a0a"><span style="font-family:Arial,Helvetica,Verdana,sans-serif"><span style="background-color:#ffffff"><img alt="" src="images/media/uploads/2020/09/03/4.png" style="height:643px; width:813px" /></span></span></span></span></p>

<h2 style="text-align:start">&nbsp;</h2>

<h2 style="text-align:start"><strong>Sources suppl&eacute;mentaires - GUI Tkinter</strong></h2>

<ul style="margin-left:48px">
	<li>Le guide suivant explique plus en d&eacute;tail comment placer des graphqiues sur une interface graphique tkinter.</li>
	<li>Vous pouvez &eacute;galement v&eacute;rifier comment ajouter des bo&icirc;tes de message &agrave; votre interface graphqie.</li>
	<li>Enfin, pour en savoir plus sur tkinter, veuillez vous r&eacute;f&eacute;rer &agrave; la documentation de tkinter.</li>
</ul>

<p>&nbsp;</p>
