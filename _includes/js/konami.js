// Konami Code, from http://mattkirman.com/2009/05/11/how-to-recreate-the-konami-code-in-javascript/
if (window.addEventListener) {
  // create the keys and konami variables
  var keys = [],
      konami = "38,38,40,40,37,39,37,39,66,65";

  // bind the keydown event to the Konami function
  window.addEventListener("keydown", function(e){
    // push the keycode to the 'keys' array
    keys.push(e.keyCode);

    // and check to see if the user has entered the Konami code
    if (keys.toString().indexOf(konami) >= 0) {
      keys = [];
      
      // do something such as:
      (function(){
        // Add some neato CSS
        link = document.createElement('link');
        link.rel= "stylesheet";
        link.href = "/css/konami.css";
        head  = document.getElementsByTagName('head')[0]; 
        head.appendChild(link)

        // Add a 2001's mouse trail, from https://codepen.io/falldowngoboone/pen/PwzPYv
        // dots is an array of Dot objects,
        // mouse is an object used to track the X and Y position
        // of the mouse, set with a mousemove event listener below
        var dots = [],
          mouse = {
            x: 0,
            y: 0
          };

          // The Dot object used to scaffold the dots
          var Dot = function() {
            this.x = 0;
            this.y = 0;
            this.node = (function(){
              var n = document.createElement("div");
              n.className = "trail";
              document.body.appendChild(n);
              return n;
            }());
          };
          // The Dot.prototype.draw() method sets the position of 
          // the object's <div> node
          Dot.prototype.draw = function() {
            this.node.style.left = this.x + "px";
            this.node.style.top = this.y + "px";
          };

          // Creates the Dot objects, populates the dots array
          for (var i = 0; i < 12; i++) {
            var d = new Dot();
            dots.push(d);
          }

          // This is the screen redraw function
          function draw() {
            // Make sure the mouse position is set everytime
            // draw() is called.
            var x = mouse.x,
              y = mouse.y;

              // This loop is where all the 90s magic happens
              dots.forEach(function(dot, index, dots) {
                var nextDot = dots[index + 1] || dots[0];

                dot.x = x;
                dot.y = y;
                dot.draw();
                x += (nextDot.x - dot.x) * .6;
                y += (nextDot.y - dot.y) * .6;

              });
          }

          addEventListener("mousemove", function(event) {
            //event.preventDefault();
            mouse.x = event.pageX;
            mouse.y = event.pageY;
          });

          // animate() calls draw() then recursively calls itself
          // everytime the screen repaints via requestAnimationFrame().
          function animate() {
            draw();
            requestAnimationFrame(animate);
          }

          // And get it started by calling animate().
          animate();
        
      })();
    };
  }, true);
};
