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
		/* // 지도를 초기화하고 해당 보기를 선택한 지리적 좌표와 확대/축소 수준으로 설정
		var map = L.map('map').setView([37.566535, 126.9779692], 13);
		
		// 타일 레이어를 추가 (템플릿 수정 가능)
		L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
			maxZoom: 19,
			attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
		}).addTo(map); */
		
		var map = new L.Map('map', {
			center: new L.LatLng(37.566535, 126.9779692),
			zoom: 10,
			crs: L.Proj.CRS.Daum, // 새로 정의된 Daum Map CRS
			worldCopyJump: false, // https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
		});
		var baseLayers = L.tileLayer.koreaProvider('DaumMap.Street').addTo(map);
		
		
		// 마커 추가
		var marker = L.marker([37.566535, 126.9779692]).addTo(map);
		
		// 원 추가
		var circle = L.circle([37.566535, 126.9779692], {
			color: 'red', // 외곽선 색상
			fillColor: '#f03', // 채움 색상
			fillOpacity: 0.5, // 투명도
			radius: 500 // 반경을 미터 단위로 지정
		}).addTo(map);
		
		// 다각형 추가
		var polygon = L.polygon([
			[37.569535, 126.9779692],
			[37.559535, 126.9879692],
			[37.559535, 126.9679692]
		]).addTo(map);
		
		// 개체 클릭 시 팝업이 오픈됨. openPopup()로 팝업을 강제적으로 열 수 있음
		marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup();
		circle.bindPopup("I am a circle.");
		polygon.bindPopup("I am a polygon.");
		
		// 새 팝업을 열 때 이전에 열린 팝업을 자동으로 닫음 => .addTo 대신 .openOn 사용
		var popup = L.popup()
			.setLatLng([37.566535, 126.9779692])
			.setContent("I am a standalone popup.")
			.openOn(map);
		
		
		// 클릭 이벤트
		var popup = L.popup();
		function onMapClick(e) {
			// alert("You clicked the map at " + e.latlng);
			
			popup
			.setLatLng(e.latlng)
			.setContent("You clicked the map at " + e.latlng.toString())
			.openOn(map);
		}
	
		map.on('click', onMapClick);
	</script>
	
</html>