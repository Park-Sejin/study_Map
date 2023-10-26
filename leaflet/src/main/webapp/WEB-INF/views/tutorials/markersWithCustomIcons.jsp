<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<!-- Leaflet CSS -->
		<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
		 
		<!-- Make sure you put this AFTER Leaflet's CSS -->
		<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.9.1/proj4.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4leaflet/1.0.2/proj4leaflet.min.js"></script>
		<script src="/js/lib/Leaflet.KoreanTmsProviders.js"></script>
		
		<script src="/js/lib/jquery-3.7.0.min.js"></script>
		
		<style type="text/css">
			#map { width:100%; height:820px; }
		</style>
	</head>
	<body>
		<h3>Place</h3>
		<div id="map"></div>
	</body>
	
	<script type="text/javascript">
		var map = new L.Map('map', {
			center: new L.LatLng(37.566535, 126.9779692),
			zoom: 10,
			crs: L.Proj.CRS.Daum, // 새로 정의된 Daum Map CRS
			worldCopyJump: false, // https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
		});
		var baseLayers = L.tileLayer.koreaProvider('DaumMap.Street').addTo(map);
		
		/* // 녹색잎 아이콘 정의
		var greenIcon = L.icon({
			iconUrl: '/img/leaf-green.png',
			shadowUrl: '/img/leaf-shadow.png',
			
			iconSize: [38, 95], // size of the icon
			shadowSize: [50, 64], // size of the shadow
			iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
			shadowAnchor: [4, 62],  // the same for the shadow
			popupAnchor: [-3, -76] // point from which the popup should open relative to the iconAnchor
		});
		
		L.marker([37.566535, 126.9779692], {icon: greenIcon}).addTo(map); */
		
		// 아이콘 클래스 정의
		var LeafIcon = L.Icon.extend({
			options: {
				shadowUrl: 'leaf-shadow.png',
				iconSize:     [38, 95],
				shadowSize:   [50, 64],
				iconAnchor:   [22, 94],
				shadowAnchor: [4, 62],
				popupAnchor:  [-3, -76]
			}
		});
		
		var greenIcon = new LeafIcon({iconUrl: '/img/leaf-green.png'});
		var redIcon = new LeafIcon({iconUrl: '/img/leaf-red.png'});
		var orangeIcon = new LeafIcon({iconUrl: '/img/leaf-orange.png'});
		
		L.marker([37.566535, 126.9779692], {icon: greenIcon}).addTo(map).bindPopup("I am a green leaf.");
		L.marker([37.567535, 126.9779692], {icon: redIcon}).addTo(map).bindPopup("I am a red leaf.");
		L.marker([37.568535, 126.9779692], {icon: orangeIcon}).addTo(map).bindPopup("I am an orange leaf.");
		
	</script>
	
</html>