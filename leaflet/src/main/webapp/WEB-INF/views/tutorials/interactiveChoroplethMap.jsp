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
		<script src="/js/tutorials/TL_SCCO_SIG.js"></script>
		
		<script src="/js/lib/jquery-3.7.0.min.js"></script>
		
		<style type="text/css">
			#map { width:100%; height:820px; }
			
			.info {
				padding: 6px 8px;
				font: 14px/16px Arial, Helvetica, sans-serif;
				background: white;
				background: rgba(255,255,255,0.8);
				box-shadow: 0 0 15px rgba(0,0,0,0.2);
				border-radius: 5px;
			}
			.info h4 {
				margin: 0 0 5px;
				color: #777;
			}
			
			.legend {
				line-height: 18px;
				color: #555;
			}
			.legend i {
				width: 18px;
				height: 18px;
				float: left;
				margin-right: 8px;
				opacity: 0.7;
			}
		</style>
	</head>
	<body>
		<h3>Place</h3>
		<div id="map"></div>
	</body>
	
	<script type="text/javascript">
		var map = new L.Map('map', {
			center: new L.LatLng(37.566535, 126.9779692),
			zoom: 2,
			crs: L.Proj.CRS.Daum, // 새로 정의된 Daum Map CRS
			worldCopyJump: false, // https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
		});
		var baseLayers = L.tileLayer.koreaProvider('DaumMap.Street').addTo(map);
		
		//L.geoJson(statesData).addTo(map);
		
		// 색상
		function getColor(d) {
			return d > 50 ? '#800026' :
				   d > 45 ? '#BD0026' :
				   d > 43 ? '#E31A1C' :
				   d > 40 ? '#FC4E2A' :
				   d > 30 ? '#FD8D3C' :
				   d > 28 ? '#FEB24C' :
				   d > 11 ? '#FED976' :
							'#FFEDA0';
		}
		
		function style(feature) {
			return {
				//fillColor: getColor(feature.properties.density),
				fillColor: getColor(feature.properties.SIG_CD.substring(0,2)),
				weight: 2,
				opacity: 1,
				color: 'white',
				dashArray: '3',
				fillOpacity: 0.7
			};
		}
		
		//L.geoJson(statesData, {style: style}).addTo(map);
		
		
		// 상호작용
		/* // mouseover
		function highlightFeature(e) {
			var layer = e.target;
			
			layer.setStyle({
				weight: 5,
				color: '#666',
				dashArray: '',
				fillOpacity: 0.7
			});
			
			layer.bringToFront();
		}
		
		// mouseout
		function resetHighlight(e) {
			geojson.resetStyle(e.target);
		}
		
		// click
		function zoomToFeature(e) {
			map.fitBounds(e.target.getBounds());
		}
		
		function onEachFeature(feature, layer) {
			layer.on({
				mouseover: highlightFeature,
				mouseout: resetHighlight,
				click: zoomToFeature
			});
		}
		
		// 레이어 리스너 추가
		geojson = L.geoJson(statesData, {
			style: style,
			onEachFeature: onEachFeature
		}).addTo(map); */
		
		
		// 사용자 정의 정보 제어
		var info = L.control();

		info.onAdd = function (map) {
			this._div = L.DomUtil.create('div', 'info');
			this.update();
			return this._div;
		};
		
		// method that we will use to update the control based on feature properties passed
		info.update = function (props) {
			this._div.innerHTML = '<h4>US Population Density</h4>' + 
				((props)? '<b>' + props.SIG_KOR_NM + '</b><br />' + props.SIG_CD : 'Hover over a state');
		};
		
		info.addTo(map);
		
		// mouseover
		function highlightFeature(e) {
			var layer = e.target;
			
			layer.setStyle({
				weight: 5,
				color: '#666',
				dashArray: '',
				fillOpacity: 0.7
			});
			
			layer.bringToFront();
			info.update(layer.feature.properties); // 추가
		}
		
		// mouseout
		function resetHighlight(e) {
			geojson.resetStyle(e.target);
			info.update(); // 추가
		}
		
		// click
		function zoomToFeature(e) {
			map.fitBounds(e.target.getBounds());
		}
		
		function onEachFeature(feature, layer) {
			layer.on({
				mouseover: highlightFeature,
				mouseout: resetHighlight,
				click: zoomToFeature
			});
		}
		
		// 레이어 리스너 추가
		geojson = L.geoJson(statesData, {
			style: style,
			onEachFeature: onEachFeature
		}).addTo(map);
		
		
		// 사용자 정의 범례 컨트롤
		var legend = L.control({position: 'bottomright'});

		legend.onAdd = function (map) {
			var div = L.DomUtil.create('div', 'info legend'),
				grades = [0, 11, 28, 30, 40, 43, 45, 50],
				labels = [];
		
			// loop through our density intervals and generate a label with a colored square for each interval
			for (var i = 0; i < grades.length; i++) {
				div.innerHTML +=
					'<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
					grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
			}
		
			return div;
		};
		
		legend.addTo(map);
		
	</script>
	
</html>