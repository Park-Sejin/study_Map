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
		
		// Point
		var geojsonFeature = {
			"type": "Feature",
			"properties": {
				"name": "Coors Field",
				"amenity": "Baseball Stadium",
				"popupContent": "This is where the Rockies play!"
			},
			"geometry": {
				"type": "Point",
				"coordinates": [126.9779692, 37.566535]
			}
		};
		
		// 레이어 생성하면서 변수에 할당하는 방식
		L.geoJSON(geojsonFeature).addTo(map);
		
		// 빈 레이어 생성 후 변수에 할당하는 방식
		var myLayer = L.geoJSON().addTo(map);
		myLayer.addData(geojsonFeature);
		
		
		// LineString
		var myLines = [{
			"type": "LineString",
			"coordinates": [[126.9779692, 37.566535], [126.9789692, 37.565535], [126.9799692, 37.564535]]
		}, {
			"type": "LineString",
			"coordinates": [[126.9789692, 37.566535], [126.9799692, 37.565535], [126.9809692, 37.564535]]
		}];
		
		// 동일한 스타일 적용
		var myStyle = {
			"color": "#ff7800",
			"weight": 5,
			"opacity": 0.65
		};
			
		L.geoJSON(myLines, {
			style: myStyle
		}).addTo(map);
		
		
		// Polygon
		var states = [{
			"type": "Feature",
			"properties": {"party": "Republican"},
			"geometry": {
				"type": "Polygon",
				"coordinates": [[
					[126.9779692, 37.566535],
					[126.9769692, 37.565535],
					[126.9759692, 37.564535],
					[126.9789692, 37.564535],
					[126.9779692, 37.566535]
				]]
			}
		}, {
			"type": "Feature",
			"properties": {"party": "Democrat"},
			"geometry": {
				"type": "Polygon",
				"coordinates": [[
					[126.9789692, 37.567535],
					[126.9779692, 37.566535],
					[126.9769692, 37.565535],
					[126.9799692, 37.565535],
					[126.9789692, 37.567535]
				]]
			}
		}];
		
		// 개별 스타일 적용 ( party 속성 확인 후 각 다각형의 스타일 지정 )
		L.geoJSON(states, {
			style: function(feature) {
				switch (feature.properties.party) {
					case 'Republican': return {color: "#ff0000"};
					case 'Democrat':   return {color: "#0000ff"};
				}
			}
		}).addTo(map);
		
		
		// Point to layer
		function onEachFeature(feature, layer) {
			// popupContent 속성 존재여부 판별
			if (feature.properties && feature.properties.popupContent) {
				layer.bindPopup(feature.properties.popupContent);
			}
		}
		
		var geojsonFeature = {
			"type": "Feature",
			"properties": {
				"name": "Coors Field",
				"amenity": "Baseball Stadium",
				"popupContent": "This is where the Rockies play!"
			},
			"geometry": {
				"type": "Point",
				"coordinates": [126.9789692, 37.567535]
			}
		};
		
		var geojsonMarkerOptions = {
			radius: 8,
			fillColor: "#ff7800",
			color: "#000",
			weight: 1,
			opacity: 1,
			fillOpacity: 0.8
		};
		
		L.geoJSON(geojsonFeature, {
			pointToLayer: function (feature, latlng) {
				return L.circleMarker(latlng, geojsonMarkerOptions);
			},
			onEachFeature: onEachFeature
		}).addTo(map);
		
		
		// Fillter 옵션
		var someFeatures = [{
			"type": "Feature",
			"properties": {
				"name": "Coors Field",
				"show_on_map": true
			},
			"geometry": {
				"type": "Point",
				"coordinates": [126.9789692, 37.567535]
			}
		}, {
			"type": "Feature",
			"properties": {
				"name": "Busch Field",
				"show_on_map": false
			},
			"geometry": {
				"type": "Point",
				"coordinates": [126.9799692, 37.568535]
			}
		}];
		
		// Busch Field는 false이기 때문에 출력되지 않음
		L.geoJSON(someFeatures, {
			filter: function(feature, layer) {
				return feature.properties.show_on_map;
			}
		}).addTo(map);
		
		
	</script>
	
</html>