<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>


<script>
function access(){
  alert('Choose location ');
}
</script>
    </head>
 
    <body onload="access()">
                    <div class="header-block header-block-search hidden-sm-down">
                        <form role="search">
                            <div class="input-container"> <i class="fa fa-search"></i> <input type="search" id="mapsearch" placeholder="Search Location">
                                <div class="underline"></div>
                            </div>
                        </form>
                    </div>

                    <article class="content item-editor-page">
                   	<div class="title-block">

                   	<div id="map-canvas" style="height:600px;width:1330px;margin-top:50px;margin-left:90px;"> </div>
	               
                   	<form action="register2_user.jsp" method="post">
                   		<input type="hidden" name ="lat" id="lat"/>
                   		<input type="hidden" name ="lng" id="lng"/>
                   		<input type="hidden" name="location" id="location" />
                   		<input type="hidden" name="locality" id="locality" />
                   		<input type="hidden" name="state" id="state" />
                   		<input type="hidden" name="pin" id="pin" />
    		 	   		<center><input type="submit" id="sendloc" value="Go" class="btn btn-success" ></center>
    		 	   	</form> 
 				   </div>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD8DXyFQH6HR6IkcTVOIr2CxWyUSIYNAqg&libraries=places"></script>

<script type="text/javascript">

    var map = new google.maps.Map(document.getElementById('map-canvas'), {
      zoom: 15,
      center: new google.maps.LatLng(19.997454, 73.789803),

      mapTypeId: google.maps.MapTypeId.HYBRID
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i,j;



    var fenway = {lat:19.997454, lng: 73.789803};
    	var panorama = new google.maps.StreetViewPanorama(
            document.getElementById('pano'), {
              position: fenway,
              pov: {
                heading: 34,
                pitch: 10
              }
            });
        map.setStreetView(panorama);


//map = new google.maps.Map(element, options);
	var searchBox = new google.maps.places.SearchBox(document.getElementById('mapsearch'));
       //     map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBox);

	 var marker = new google.maps.Marker({
		 position:{
			     lat:19.997454,
				 lng:73.789803
		 },
		 map:map,
		 draggable:true});

	google.maps.event.addListener(searchBox, 'places_changed', function(c){
		console.log(searchBox.getPlaces());
		var places = searchBox.getPlaces();
		var bounds = new google.maps.LatLngBounds();
		var i,place;

		for(i=0;place = places[i];i++){
			bounds.extend(place.geometry.location);
			marker.setPosition(place.geometry.location);
		}

		map.fitBounds(bounds);
		map.setZoom(17);
	});

	google.maps.event.addListener(map, 'click', function(c){
    placeMarker(c.latLng);
    
	});
  function placeMarker(location) {
     var marker = new google.maps.Marker({
         position: location,
         map: map
     });
     // alert('location set ');
     var x = document.getElementById('sendloc');
     var lat = document.getElementById('lat');
     lat.value = location.lat();
     var lng = document.getElementById('lng');
     lng.value=  location.lng();
     
     // Optional: You can display the formatted address if needed
     // Reverse geocode the location to get the address
     var geocoder = new google.maps.Geocoder();
     // Reverse geocode the location to get the address components
     var geocoder = new google.maps.Geocoder();
     geocoder.geocode({ 'location': location }, function(results, status) {
         if (status === 'OK') {
             if (results[0]) {
            	 document.getElementById('location').value = results[0].formatted_address;
                 // Extract address components
                 var addressComponents = results[0].address_components;
                 var locality, district, state, pin;
                 addressComponents.forEach(function(component) {
                     if (component.types.includes('administrative_area_level_2')) {
                    	 locality = component.long_name;
                     } else if (component.types.includes('administrative_area_level_1')) {
                         state = component.long_name;
                     } else if (component.types.includes('postal_code')) {
                         pin = component.long_name;
                     }
                 });

                 // Set the address components in the corresponding input fields
                 document.getElementById('locality').value = locality || '';
                 document.getElementById('state').value = state || '';
                 document.getElementById('pin').value = pin || '';
             } else {
                 console.log('No results found');
             }
         } else {
             console.log('Geocoder failed due to: ' + status);
         }
     });

     // Optional: You can display an alert or perform other actions here
     alert('Location set: ' + location.lat() + ', ' + location.lng());
      
     x.type = "submit";
 }
 </script>



</head>
<body>

</body>
</html>