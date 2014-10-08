var map = L.mapbox.map('map', 'louishoang.jn2haba8').setView([42.366, -71.109], 13);

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
