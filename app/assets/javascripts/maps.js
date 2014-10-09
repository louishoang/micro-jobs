var map = L.mapbox.map('map', 'louishoang.jn2haba8', {
  //this is where to put options for map such as auto zoom
  zoomControl: false
}).setView([42.366, -71.109], 13);

// Disable drag and zoom handlers.
new L.Control.Zoom({ position: 'topright' }).addTo(map);
map.touchZoom.disable();
map.doubleClickZoom.disable();
map.scrollWheelZoom.disable();

// Disable tap handler, if present.
if (map.tap) map.tap.disable();

$("#map").ready(function() {

  var data = $.ajax({
    url: '/users.json',
    dataType: 'json',
    success: function(users) {
      // Add markers to map
      map.markerLayer.setGeoJSON(users);

      // Iterate over each marker on the map
      map.markerLayer.eachLayer(function(marker) {
        var properties = marker.feature.properties;
        // Create the popup content HTML
        var popupContent = "<a href='/users/" + properties.id + "'>" + properties.name + "</a>";

        // Bind the popup to the marker
        marker.bindPopup(popupContent, {
          closeButton: true,
          minWidth: 200
        });
      });
    }
  });
});
