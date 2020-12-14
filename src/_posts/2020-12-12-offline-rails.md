---
layout: post
title: How to Make Rails Work Offline (PWA)
description: I've been experimenting with Progressive Web Apps
---

I've been experimenting a lot lately with allowing Ruby on Rails to work offline, by this I mean having a sensible fallback for when the network unexpectedly drops out (e.g. the user is underground).

The main way to achieve this via by making our app a Progressive Web App (PWA) via a Service Worker. This allow us to create a pretty nice user experience, without having to rewrite our Rails App to a non-traditional approach (e.g. server side rendering & Turbolinks).

## Screencasts

I've put together a few screencasts so you can see everything in action :D

- [The serviceworker-rails gem](https://www.youtube.com/watch?v=EKa6IOBRnHI)
- [webpacker-pwa & Workbox](https://www.youtube.com/watch?v=c9slVBXsXyo)
- [NetworkFirst, CacheFirst & StaleWhileRevalidate](https://www.youtube.com/watch?v=iL7erF3t83o)

## What is a service worker?

A Service Worker is a JavaScript file you serve to the browser, which will intercept future network requests to your website. The result is you can control how a request will react if the network is down, or if you want to always serve requests from the cache.

<svg width="960px" height="441px" viewBox="0 0 960 441" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="service-worker" transform="translate(0.000000, 3.000000)">
            <g id="Application" transform="translate(0.000000, 128.000000)">
                <g id="Group" transform="translate(0.000000, 151.000000)" fill="currentColor" fill-rule="nonzero" font-family="Helvetica" font-size="31" font-weight="normal">
                    <text id="Application">
                        <tspan x="0" y="30">Application</tspan>
                    </text>
                </g>
                <g id="layout" stroke-linecap="round" stroke-linejoin="round" transform="translate(8.000000, 0.000000)" stroke="#3271F0" stroke-width="4">
                    <rect id="Rectangle" x="0" y="0" width="135" height="135" rx="2"></rect>
                    <line x1="0" y1="45" x2="135" y2="45" id="Path"></line>
                    <line x1="45" y1="135" x2="45" y2="45" id="Path"></line>
                </g>
            </g>
            <g id="Service-Worker" transform="translate(381.000000, 128.000000)">
                <g id="Group" transform="translate(0.000000, 151.000000)" fill="currentColor" fill-rule="nonzero" font-family="Helvetica" font-size="31" font-weight="normal">
                    <text id="Service-Worker">
                        <tspan x="0" y="30">Service Worker</tspan>
                    </text>
                </g>
                <g id="settings" stroke-linecap="round" stroke-linejoin="round" transform="translate(38.000000, 0.000000)" stroke="#3271F0" stroke-width="5">
                    <circle id="Oval" cx="67.5" cy="67.5" r="18.5"></circle>
                    <path d="M112.909091,85.9090909 C111.237874,89.69578 112.039778,94.1183996 114.934091,97.0772727 L115.302273,97.4454545 C117.606809,99.7474286 118.9017,102.871114 118.9017,106.128409 C118.9017,109.385704 117.606809,112.50939 115.302273,114.811364 C113.000299,117.1159 109.876613,118.410791 106.619318,118.410791 C103.362023,118.410791 100.238338,117.1159 97.9363636,114.811364 L97.5681818,114.443182 C94.6093087,111.548868 90.1866891,110.746965 86.4,112.418182 C82.6907485,114.007919 80.2797315,117.648555 80.2636364,121.684091 L80.2636364,122.727273 C80.2636364,129.505313 74.7689492,135 67.9909091,135 C61.212869,135 55.7181818,129.505313 55.7181818,122.727273 L55.7181818,122.175 C55.620961,118.018662 52.9928495,114.344173 49.0909091,112.909091 C45.30422,111.237874 40.8816004,112.039778 37.9227273,114.934091 L37.5545455,115.302273 C35.2525714,117.606809 32.1288862,118.9017 28.8715909,118.9017 C25.6142956,118.9017 22.4906104,117.606809 20.1886364,115.302273 C17.8840999,113.000299 16.5892092,109.876613 16.5892092,106.619318 C16.5892092,103.362023 17.8840999,100.238338 20.1886364,97.9363636 L20.5568182,97.5681818 C23.4511315,94.6093087 24.2530351,90.1866891 22.5818182,86.4 C20.992081,82.6907485 17.3514452,80.2797315 13.3159091,80.2636364 L12.2727273,80.2636364 C5.49468716,80.2636364 0,74.7689492 0,67.9909091 C0,61.212869 5.49468716,55.7181818 12.2727273,55.7181818 L12.825,55.7181818 C16.9813381,55.620961 20.6558273,52.9928495 22.0909091,49.0909091 C23.762126,45.30422 22.9602224,40.8816004 20.0659091,37.9227273 L19.6977273,37.5545455 C17.3931908,35.2525714 16.0983001,32.1288862 16.0983001,28.8715909 C16.0983001,25.6142956 17.3931908,22.4906104 19.6977273,20.1886364 C21.9997013,17.8840999 25.1233865,16.5892092 28.3806818,16.5892092 C31.6379771,16.5892092 34.7616623,17.8840999 37.0636364,20.1886364 L37.4318182,20.5568182 C40.3906913,23.4511315 44.8133109,24.2530351 48.6,22.5818182 L49.0909091,22.5818182 C52.8001605,20.992081 55.2111776,17.3514452 55.2272727,13.3159091 L55.2272727,12.2727273 C55.2272727,5.49468716 60.7219599,0 67.5,0 C74.2780401,0 79.7727273,5.49468716 79.7727273,12.2727273 L79.7727273,12.825 C79.7888224,16.8605361 82.1998395,20.5011719 85.9090909,22.0909091 C89.69578,23.762126 94.1183996,22.9602224 97.0772727,20.0659091 L97.4454545,19.6977273 C99.7474286,17.3931908 102.871114,16.0983001 106.128409,16.0983001 C109.385704,16.0983001 112.50939,17.3931908 114.811364,19.6977273 C117.1159,21.9997013 118.410791,25.1233865 118.410791,28.3806818 C118.410791,31.6379771 117.1159,34.7616623 114.811364,37.0636364 L114.443182,37.4318182 C111.548868,40.3906913 110.746965,44.8133109 112.418182,48.6 L112.418182,49.0909091 C114.007919,52.8001605 117.648555,55.2111776 121.684091,55.2272727 L122.727273,55.2272727 C129.505313,55.2272727 135,60.7219599 135,67.5 C135,74.2780401 129.505313,79.7727273 122.727273,79.7727273 L122.175,79.7727273 C118.139464,79.7888224 114.498828,82.1998395 112.909091,85.9090909 Z" id="Path"></path>
                </g>
            </g>
            <g id="Internet" transform="translate(813.000000, 250.000000)">
                <g id="Group" transform="translate(15.000000, 151.000000)" fill="currentColor" fill-rule="nonzero" font-family="Helvetica" font-size="31" font-weight="normal">
                    <text id="Internet">
                        <tspan x="0" y="30">Internet</tspan>
                    </text>
                </g>
                <g id="globe" stroke-linecap="round" stroke-linejoin="round" stroke="#3271F0" stroke-width="5">
                    <circle id="Oval" cx="67.5" cy="67.5" r="67.5"></circle>
                    <line x1="0" y1="67.5" x2="135" y2="67.5" id="Path"></line>
                    <path d="M68,0 C84.8836425,18.483882 94.4785811,42.4712285 95,67.5 C94.4785811,92.5287715 84.8836425,116.516118 68,135 C51.1163575,116.516118 41.5214189,92.5287715 41,67.5 C41.5214189,42.4712285 51.1163575,18.483882 68,0 L68,0 Z" id="Path"></path>
                </g>
            </g>
            <g id="Cache" transform="translate(804.000000, 25.000000)">
                <g id="hard-drive" stroke-linecap="round" stroke-linejoin="round" stroke="#3271F0" stroke-width="5">
                    <line x1="153" y1="62" x2="0" y2="62" id="Path"></line>
                    <path d="M26.3925,8.46375 L0,61 L0,106.75 C0,115.172342 6.85004333,122 15.3,122 L137.7,122 C146.149957,122 153,115.172342 153,106.75 L153,61 L126.6075,8.46375 C124.023865,3.2813602 118.719921,0.00307078035 112.914,0 L40.086,0 C34.2800786,0.00307078035 28.9761346,3.2813602 26.3925,8.46375 Z" id="Path"></path>
                    <line x1="29.96" y1="92" x2="30.04" y2="92" id="Path"></line>
                    <line x1="60.96" y1="92" x2="61.04" y2="92" id="Path"></line>
                </g>
                <g id="Group" transform="translate(31.000000, 140.000000)" fill="currentColor" fill-rule="nonzero" font-family="Helvetica" font-size="31" font-weight="normal">
                    <text id="Cache">
                        <tspan x="0" y="30">Cache</tspan>
                    </text>
                </g>
            </g>
            <polygon fill="currentColor" style="opacity: 0.8;" fill-rule="nonzero" points="363.046714 178.595408 365.225653 179.821061 389.225653 193.321061 393.099322 195.5 389.225653 197.678939 365.225653 211.178939 363.046714 212.404592 360.595408 208.046714 362.774347 206.821061 378.455 198 200.543 198 216.225653 206.821061 218.404592 208.046714 215.953286 212.404592 213.774347 211.178939 189.774347 197.678939 185.900678 195.5 189.774347 193.321061 213.774347 179.821061 215.953286 178.595408 218.404592 182.953286 216.225653 184.178939 200.542 193 378.458 193 362.774347 184.178939 360.595408 182.953286"></polygon>
            <polygon fill="currentColor" style="opacity: 0.8;" fill-rule="nonzero" points="738.206677 87.7609822 740.779449 88.2152415 769.11735 93.2186974 773.691169 94.0262695 770.689865 97.9150401 752.094755 122.008604 750.406521 124.196038 746.43719 120.474606 748.125423 118.287172 760.2754 102.543786 746.312284 108.223797 614.874275 161.686504 600.911039 167.365641 619.42719 170.63547 621.999963 171.089729 621.175661 176.760982 618.602889 176.306723 590.264988 171.303267 585.691169 170.495694 588.692473 166.606924 607.287583 142.51336 608.975817 140.325926 612.945148 144.047359 611.256915 146.234792 599.105896 161.97703 613.070054 156.298168 744.508063 102.83546 758.470257 97.1551747 739.955148 93.8864947 737.382375 93.4322354"></polygon>
            <polygon fill="currentColor" style="opacity: 0.8;" fill-rule="nonzero" points="628.826597 202 629.33465 207.552803 626.737073 207.824318 608.042186 209.777762 621.675208 216.196818 754.428967 278.697268 768.060404 285.114953 756.791529 269.053937 755.225548 266.82222 759.401497 263.474644 760.967478 265.706361 778.216033 290.28769 781 294.255186 776.382085 294.737879 747.77098 297.728486 745.173403 298 744.66535 292.447197 747.262927 292.175682 765.95677 290.221122 752.324792 283.803182 619.571033 221.302732 605.938552 214.883931 617.208471 230.946063 618.774452 233.17778 614.598503 236.525356 613.032522 234.293639 595.783967 209.71231 593 205.744814 597.617915 205.262121 626.22902 202.271514"></polygon>
        </g>
    </g>
</svg>

### Service Worker Limitations

When researching this topic, I found Server Workers aren't a perfect solution. 

- URL of service worker must stay the same, e.g. `/service-worker.js`
- If you're using webpacker-dev-server, it will give you a hard time.
- ~25MB limit ( https://stackoverflow.com/a/35696506/445724 )

## Libraries

Service Workers awesome & because they've been around a few years there is quite a few libraries which make it a lot easier to work with.

### The serviceworker-rails Gem

The [serviceworker-rails](https://github.com/rossta/serviceworker-rails) gem will work pretty nicely for most use cases, it works with the Asset Pipeline (Sprockets) & has a very nifty generator for automated setup.

The only downside of this approach is because it's using the Asset Pipeline, it defaults to a verbose vanilla JavaScript approach. This makes using the new libraries out there which can cut down some of the boilerplate a little tricky.

### webpacker-pwa library

One of the biggest drawbacks with webpack is it's quite tricky to configure if you're not working with it regularly. The [webpacker-pwa](https://github.com/coorasse/webpacker-pwa) library makes adding the extra configuration a lot easier.

The awesome result of this, is you can write the your service workers JavaScript in modern JS, then it'll be served without the asset hash.

### Workbox

The vanilla Service Worker JavaScript is [pretty verbose](https://developers.google.com/web/fundamentals/primers/service-workers). While I was initially exploring approach to allowing Rails to work offline, I was finding the JavaScript was getting pretty hard to explain.

Then I was shown [Workbox](https://developers.google.com/web/tools/workbox/), which allows the Service Worker JavaScript to be boiled down to something more like:

```javascript
// app/javascript/service_workers/service-worker.js
import { registerRoute } from 'workbox-routing';
import { NetworkFirst, StaleWhileRevalidate, CacheFirst } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response';
import { ExpirationPlugin } from 'workbox-expiration';

// Loading pages (and turbolinks requests), checks the network first
registerRoute(
  ({request}) => request.destination === "document" || (
    request.destination === "" &&
    request.mode === "cors" &&
    request.headers.get('Turbolinks-Referrer') !== null
  ),
  new NetworkFirst({
    cacheName: 'documents',
    plugins: [
      new ExpirationPlugin({
        maxEntries: 5,
        maxAgeSeconds: 5 * 60, // 5 minutes
      }),
      new CacheableResponsePlugin({
        statuses: [0, 200],
      }),
    ],
  })
);

// Load CSS & JS from the Cache
registerRoute(
  ({request}) => request.destination === "script" ||
  request.destination === "style",
  new CacheFirst({
    cacheName: 'assets-styles-and-scripts',
    plugins: [
      new ExpirationPlugin({
        maxEntries: 10,
        maxAgeSeconds: 60 * 60 * 24 * 30, // 30 Days
      }),
      new CacheableResponsePlugin({
        statuses: [0, 200],
      }),
    ],
  })
);
```

I think that's much more approachable.

## Strategies

There are 3 main approach for caching and serving content which I settled on using.

### NetworkFirst

This is kind of the best default choice for any page which _might_ change between page loads.

As the name hints, it'll try to request the resource from the webserver caching it if it's successful, or falling back to its cached copy if the server is unreachable.

### CacheFirst

This is the best choice for assets such a CSS, JavaScript & Images.

This approach will initially request the file, then cache the response. For subsequent requests it'll use the cached file.

### StaleWhileRevalidate

This is the quirky option! It serves the cached content, but then in the background it'll make a request to the server to update its cache.

## Eager-Caching Assets

It's possible to preload assets into your cache. You can do this from within your `service-worker.js`, however I found I'd reach for mixing ERB & JavaScript when I took this approach. Instead I eager-cached my assets by parsing my DOM when the service worker was registered.

```javascript
// app/javascript/service_workers/index.js
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/service-worker.js', { scope: "/" })
      .then(function(registration) {
        console.log('[ServiceWorker Client]', 'registration successful with scope: ', registration.scope);

        registration.addEventListener('updatefound', function() {

          // Cache a few popular pages ahead of time.
          caches.open('documents').then(function(cache) {
            let links = document.querySelectorAll('a[href^="/"]:not([rel="nofollow"])');
            cache.addAll( Array.from(links).map(elem => elem.getAttribute("href")) );
            cache.addAll( [document.location.pathname] );
          });

          // Cache all the CSS & JS assets on the page.
          caches.open('assets-styles-and-scripts').then(function(cache) {
            let stylesheetLinks = document.querySelectorAll('link[rel="stylesheet"][href^="/"]');
            cache.addAll( Array.from(stylesheetLinks).map(elem => elem.getAttribute("href")) );

            let scriptLinks = document.querySelectorAll('script[src^="/"]');
            cache.addAll( Array.from(scriptLinks).map(elem => elem.getAttribute("src")) );
          });
        });

      }, function(err) {
        console.log('[ServiceWorker Client]','registration failed: ', err);
      });
  });
}
```

I didn't make a video on this approach as I wasn't able to validate anyone else doing it, but I did like it.

## Conclusions


