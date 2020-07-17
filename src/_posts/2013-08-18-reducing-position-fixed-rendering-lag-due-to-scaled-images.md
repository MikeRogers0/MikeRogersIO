---
layout: post
title: Reducing position:fixed; rendering lag due to scaled images
description: Using position:fixed; causes the page to lag when your scrolling, scaled images make this issues worse. Here is a fix to make it less noticeable.
---
I'm currently working on a project that uses a variable amount of images which are scaled into 120px by 120px elements (The images are 3rd party). On lower end devices I noticed a lag when scrolling the page, upon further inspection the issue was also noticeable on my desktop machine. [Here is a demonstration of the issue](/2013/08/18/fixed-position-scroll-lag.html).

## The Problem
After watching the page render in the timeline tool in Chrome and watching the timeline as the page was scrolled, the issue was clear. 

![The Chrome Dev tools timeline showing the lag cause](/uploads/2013/08/18/timeine-repainting.jpg)

The scaled images were being repainted from the cache each time the page was scrolled. As there was quite a few images this caused a lag in the page rendering. Upon further investigation it turned out to be due to there being a element which used position:fixed; on the page, which triggers the elements on the page to be repainted when they collide. More information about this issue has been documented by <a href="http://remysharp.com/2012/05/24/issues-with-position-fixed-scrolling-on-ios/">Remy Sharp</a>.

## A Solution
I tried a few approaches at fixing this issue, including moving the scaled background images into image elements. However, I found the best approach was to use HTML5 canvas to reduce the time it took to repaint the elements.

### The HTML5 Canvas Approach
Scaling the images via canvas, then injecting the canvas like a background image into a container element worked great. I've set up a [demo of the HTML5 Canvas approach](/2013/08/18/fixed-position-scroll-lag-html5-canvas-solution.html). You'll notice that while the elements are still being repainted, the lag is greatly reduced albeit the initial loading time is slightly increased. 

Below is the code sample used in the demonstration, though to keep things simple I didn't do much with image ratios.

```javascript
// The function that scales an images with canvas then runs a callback.
function scaleImage(url, width, height, liElm, callback){
	var img = new Image(),
	width = width,
	height = height,
	callback;

	// When the images is loaded, resize it in canvas.
	img.onload = function(){
		var canvas = document.createElement("canvas"),
        ctx = canvas.getContext("2d");

        canvas.width = width;
        canvas.height= height;

        // draw the img into canvas
        ctx.drawImage(this, 0, 0, width, height);

        // Run the callback on what to do with the canvas element.
        callback(canvas, liElm);
	};

	img.src = url;
}

// List of imgur images
var images = ['u0s09PV','bdRlP3o','o7lwgZo','wvOjdUJ','D0lsDQz','sB46sHZ','nvRcyJM'],
imagesList = document.getElementById('imagesList');

// Loop through the images.
for(i in images){
	// make an li we can use in the callback.
	liElm = document.createElement('li');
	
	// append the currently empty li into the ul.
	imagesList.appendChild(liElm);

	scaleImage('http://i.imgur.com/'+images[i]+'.jpg', 150, 150, liElm, function(canvas, liElm){
		// Append the canvas element to the li.
		liElm.appendChild(canvas);
	});
}
```

This works by downloading the image, then resizing it into a canvas element which is injected into the list element, then CSS absolute position is used to position the canvas correctly. 
