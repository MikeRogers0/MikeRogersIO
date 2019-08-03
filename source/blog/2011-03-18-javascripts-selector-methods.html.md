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

The `querySelector()` method takes the CSS selector input, then returns a single element.

```html
<p id="myElem1" class="classExample">My First paragraph</p>
<p id="myElem2" class="classExample">My Second paragraph</p>
<form>
  <fieldset>
    <legend>Input Field</legend>
    <label>Check Me : <input type="checkbox" name="TickMe" value="ticked" /></label>
    <label>Check Me : <input type="checkbox" name="TickMe" value="ticked" /></label>
  </fieldset>
</form>
<script>
  document.querySelector('#myElem1').style.fontSize = "1.2em"; // Make the first paragraph 1.2em
  document.querySelector('p').style.color = "#0D0"; // This will only affect the first paragraph

  // You can also add event listeners...Again this will only affect the first checkbox.
  document.querySelector('input[type=checkbox]').addEventListener('click', function(e){alert("You Checked Me");});
</script>
```

## querySelectorAll() Example

The `querySelectorAll()` method will return a StaticNodeList (Like an array) of elements in which you can cycle through.

```html
<p id="myElem1" class="classExample">My First paragraph</p>
<p id="myElem2" class="classExample">My Second paragraph</p>
<form>
  <fieldset>
    <legend>Input Field</legend>
    <label>Check Me : <input type="checkbox" name="TickMe" value="ticked" /></label>
    <label>Check Me : <input type="checkbox" name="TickMe" value="ticked" /></label>
  </fieldset>
</form>
<script>
  var classExample = document.querySelectorAll('.classExample'); // Get all the elements with class "classExample"
  for(i=0; i<classExample.length; i++) {// Cycle through them
    classExample[i].style.fontSize = "1.2em"; // Change the fontSize.
  }

  // Add an click listner to the element #myElem1 and #myElem2
  var idExample = document.querySelectorAll('input[type=checkbox]');
  for(i=0; i<idExample.length; i++) {// Cycle through them
    idExample[i].addEventListener('click', function(e){alert("You Clicked me!");}); // Add the alert.
  }
</script>
```

## Current browser support level

Selectors are currently a W3C Candidate Recommendation, so they work in most browsers updated after January 2010\. Thus for the most part you can use the above code examples in your current website and only IE6 level users will have an issue (Though, they are probably use to that).

However, if you have to support older browsers you can make use of the getElementsByClassName() method. For example:

```html
<p id="myElem1" class="classExample">My First paragraph</p>
<p id="myElem2" class="classExample">My Second paragraph</p>
<script>
  if(!document.querySelectorAll){ // If the user does not have querySelectorAll()
    var classExample = document.getElementsByClassName('classExample'); // Get all the elements with class "classExample"
  }else{ // Otherwise do it the HTML5 way
    var classExample = document.querySelectorAll('.classExample');
  }

  for(i=0; i<classExample.length; i++) {// Cycle through them
    classExample[i].style.fontSize = "1.2em"; // Change the fontSize.
  }
</script>
```

## Further Reading

I've only lightly covered this topic; here are a few pages which will give you much more information on the new HTML5 method.

* [John Resig: Thoughts on querySelectorAll](http://ejohn.org/blog/thoughts-on-queryselectorall/)
* [Jef Claes: HTML5: New in the javascript Selector API](http://jclaes.blogspot.com/2010/11/html5-new-in-javascript-selector-api.html)
* [W3C: Selectors API Level 1](http://www.w3.org/TR/selectors-api/)
