var map;
function initGMap() {
  var gmapElm = document.getElementById('gmap');
  map = new google.maps.Map(gmapElm, {
    center: {lat: 0, lng: 0},
    zoom: 2
  });

  loadKmlLayer(gmapElm.attributes["data-kml"].value, map);
}

function loadKmlLayer(src, map) {
  var kmlLayer = new google.maps.KmlLayer(src, {
    suppressInfoWindows: false,
    preserveViewport: true,
    map: map
  });
  //google.maps.event.addListener(kmlLayer, 'click', function(event) {
    //var content = event.featureData.infoWindowHtml;
  //});
}
