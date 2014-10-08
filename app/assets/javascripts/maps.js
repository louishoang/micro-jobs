var map = L.mapbox.map('map', 'louishoang.jn2haba8').setView([42.366, -71.109], 13);

$("#map").ready(function() {
  // // Set marker with JSON
  // var data = $.parseJSON($.ajax({
  //   url:  '/users.json',
  //   dataType: "json",
  //   async: false
  // }).responseText);

  var data = $.ajax({
    url: '/users.json',
    dataType: 'json',
    success: function(users) {
      map.featureLayer.setGeoJSON(users);
      // debugger;
    }
  });

  // var featureLayer = L.mapbox.featureLayer(data).addTo(map);

  // var featureLayer = L.mapbox.featureLayer()
  //   .loadURL('/users.json')
  //   .on('ready', function(layer) {
  //     debugger;
  //       this.eachLayer(function(marker) {
  //           // See the following for styling hints:
  //           // https://help.github.com/articles/mapping-geojson-files-on-github#styling-features
  //           marker.setIcon(L.mapbox.marker.icon({
  //               'marker-color': '#CC0000'
  //           }));
  //       });
  //   })
  //   .addTo(map);

  // // Set marker without JSON
  // L.marker([37.9, -77], {
  //   icon: L.mapbox.marker.icon({
  //       'marker-size': 'medium',
  //       'marker-symbol': 'rocket',
  //       'marker-color': '#fa0'
  //   })
  // }).addTo(map);

  // featureLayer.eachLayer(function(data) {

  //   var marker;
  //   var properties;
  //   var popupContent;

  //   marker = data;
  //   properties = marker.feature.properties;
  //     if (properties.role === "User") {
  //       popupContent = '<div class="popup">' + '<p>' + properties.name + '</p>' + '</div>';
  //     }

  //   marker.bindPopup(popupContent, {
  //     closeButton: false,
  //     minWidth: 100,
  //     maxWidth: 200,
  //     maxHeight: 200,
  //   });
  // })
});
