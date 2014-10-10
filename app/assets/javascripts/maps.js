var map = L.mapbox.map('map', 'louishoang.jn2haba8', {
//this is where to put options for map such as auto zoom
  zoomControl: false
});

$( document ).ready(function() {
  $(".search_map").submit(function(event){
    event.preventDefault();
    var search = $('#search').val()
    $.ajax({
      url: '/users.json',
      type: "GET",
      data: { search: search },
      dataType: 'json',
      success: function(users) {
        //find lat and long of first user
        var myLayer = L.mapbox.featureLayer().addTo(map);
        var features = [];
        // mapbox.clearLayers();
        var firstLongitude = users[0].geometry.coordinates[0];
        var firstLatitude = users[0].geometry.coordinates[1];

        //center map
        map.setView([firstLatitude, firstLongitude], 13);

        //change zoom button position and disable zoom by mouse and scroll
        $(users).each(function(){
          var name = this.properties.name
          features.push(this);
          // .bindPopup('<button class="trigger">' + name + '</button>')
          // .addTo(map);

        });
        myLayer.setGeoJSON({
          type: 'FeatureCollection',
          features: features
        });
      }//close success
    }); // close ajax
  });
});


new L.Control.Zoom({ position: 'topright' }).addTo(map);
      map.touchZoom.disable();
      map.doubleClickZoom.disable();
      map.scrollWheelZoom.disable();

      // Disable tap handler, if present.
      if (map.tap) map.tap.disable();
// });
