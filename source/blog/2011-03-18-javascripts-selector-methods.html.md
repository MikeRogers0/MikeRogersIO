---
layout: post
title: JavaScript Selector Methods (Use CSS selectors in JS)
tags:
- JavaScript
status: publish
type: post
published: true
categories:
 – blog
meta:
  description: 'How to use querySelector in JS to make CSS style selections in JS'
  index: true
---
I was recently introduced a group of really funky new HTML5 JavaScript methods, which make me seriously think we can avoid having to include the jQuery library in lots of small websites. These methods are querySelectorAll() and querySelector().

In a nutshell, these methods behave exactly the same as the [jQuery selector](http://api.jquery.com/category/selectors/) but comes integrated into the browser, meaning you input the CSS selector (e.g. "#myDiv" or ".MyClass") and out pops the first element in the tree, or a StaticNodeList of the elements (depending on whether you use the All part).

## querySelector() Example

The querySelector() method takes the CSS selector input, then returns a single element.

{% gist 2941981 querySelector.html %}

[View querySelector() Demo](http://demos.mikerogers.io/JavaScripts_Selector_Methods/querySelector.html)

## querySelectorAll() Example

The querySelectorAll() method will return a StaticNodeList (Like an array) of elements in which you can cycle through.

{% gist 2941981 querySelectorAll.html %}

[View querySelectorAll() Demo](http://demos.mikerogers.io/JavaScripts_Selector_Methods/querySelectorAll.html)

## Current browser support level

Selectors are currently a W3C Candidate Recommendation, so they work in most browsers updated after January 2010\. Thus for the most part you can use the above code examples in your current website and only IE6 level users will have an issue (Though, they are probably use to that).

However, if you have to support older browsers you can make use of the getElementsByClassName() method. For example:

{% gist 2941981 getElementsByClassName.html %}

[View Demo](http://demos.mikerogers.io/JavaScripts_Selector_Methods/getElementsByClassName.html)

## Further Reading

I've only lightly covered this topic; here are a few pages which will give you much more information on the new HTML5 method.

*   [John Resig: Thoughts on querySelectorAll](http://ejohn.org/blog/thoughts-on-queryselectorall/)
*   [Jef Claes: HTML5: New in the javascript Selector API](http://jclaes.blogspot.com/2010/11/html5-new-in-javascript-selector-api.html)
*   [W3C: Selectors API Level 1](http://www.w3.org/TR/selectors-api/)
