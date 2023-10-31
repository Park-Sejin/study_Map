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
		/* 
		var map = new L.Map('map', {
			center: new L.LatLng(37.566535, 126.9779692),
			zoom: 10,
			crs: L.Proj.CRS.Daum, // 새로 정의된 Daum Map CRS
			worldCopyJump: false, // https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
		});
		var baseLayers = L.tileLayer.koreaProvider('DaumMap.Street').addTo(map);
		*/
		
		
		// 레이어 그룹
		var one = L.marker([37.566535, 126.9779692]).bindPopup('This is One, CO.');
		var two = L.marker([37.567535, 126.9779692]).bindPopup('This is Two, CO.');
		var three = L.marker([37.568535, 126.9779692]).bindPopup('This is Three, CO.');
		var four = L.marker([37.569535, 126.9779692]).bindPopup('This is Four, CO.');
		
		var cities = L.layerGroup([one, two, three, four]);
		
		
		// 레이어 제어
		var osm = L.tileLayer.koreaProvider('DaumMap.Street', {
			attribution : "osm layer"
		});
		var osmHOT = L.tileLayer.koreaProvider('DaumMap.Street', {
			attribution : "osmHOT layer"
		});
		
		var map = L.map('map', {
			center: [37.566535, 126.9779692],
			zoom: 10,
			crs: L.Proj.CRS.Daum, // 새로 정의된 Daum Map CRS
			worldCopyJump: false, // https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
			layers: [osm, cities]
		});
		
		// layer
		var baseMaps = {
			"DaumMap": osm,
			"<span style='color: red'>DaumMap.HOT</span>": osmHOT
		};
		
		// overlay
		var overlayMaps = {
			"Cities": cities
		};
		
		var layerControl = L.control.layers(baseMaps, overlayMaps).addTo(map);
		
		// 레이어, 오버레이 추가
		var five = L.marker([37.566535, 126.9789692]).bindPopup('This is Five.');
		var six = L.marker([37.566535, 126.9799692]).bindPopup('This is Six');
			
		var cityPlaces = L.layerGroup([five, six]);
		var openTopoMap = L.tileLayer.koreaProvider('DaumMap.Street', {
			attribution : "openTopoMap layer"
		});
	
		layerControl.addBaseLayer(openTopoMap, "OpenTopoMap");
		layerControl.addOverlay(cityPlaces, "cityPlaces");
		
	</script>
	
</html>