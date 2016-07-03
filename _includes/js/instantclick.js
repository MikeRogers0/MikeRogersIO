InstantClick.on('change', function() {
  if( typeof(ga) === "function" ){
    ga('send', 'pageview', location.pathname);
  }
});
InstantClick.init();
