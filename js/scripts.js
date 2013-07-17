// At the end of the page, this will fire.
(function(){
	// Lazy load gists?

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

			// do something such as:
			(function(){
				alert('Konami');
			})();

			// and finally clean up the keys array
			keys = [];
			};
		}, true);
	};

	// Google Analtics
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-7014273-6', 'mikerogers.io');
	ga('send', 'pageview');
})();