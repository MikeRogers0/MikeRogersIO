---
layout: post
title: How to use Google Web Fonts on Wufoo forms
tags:
- XHTML &amp; CSS
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'How to embed custom fonts from google web fonts into Wufoo forms.'
  index: true
---
[Wufoo](http://wufoo.com/) is a great service which makes managing forms on a website pretty simple, unfortunately their font selection is fairly limited. Luckily there is a really quick way to get better fonts on Wufoo.

Firstly, create a Wufoo theme with a custom CSS file. You can achieve this by clicking "Themes" in the tabbed navigation, than selecting "Advanced" in the property select box and than putting a URL to a CSS file to which you have access to. Than click "Save Theme" & giving it a rememberable name.

{% img src: /uploads/2012/04/custom-css-file.jpg width: 500 alt: "Custom CSS file set up on Wufoo" %}

Next find the font you want to use on [Google Web Fonts](http://www.google.com/webfonts), than click "Quick-use" than select the "@import" tab to receive the code to put into your CSS sheet. The @import CSS rule will be used to download the extra font.

{% img src: /uploads/2012/04/google-web-fonts.jpg width: 500 alt: "Screenshot of the import option for a google font." %}

Put the code provided by Google Web Fonts into the top of your CSS file and voila, you can start using the font you selected on Wufoo forms.

I've set up an [example Wufoo form](http://demos.fullondesign.co.uk/wufoo-fonts/), you can copy.
