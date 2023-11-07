<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=efd80a5d832d16b149bdad0c598441d4"></script>
		<script src="/js/lib/jquery-3.7.0.min.js"></script>
		
		<style type="text/css">
			
		</style>
	</head>
	<body>
		<h3>Place</h3>
		<div id="map" style="width:100%;height:800px;"></div>
		
		<p>
			<button onclick="setBounds()">지도 범위 재설정 하기</button>
			
			<button onclick="resizeMap()">지도 크기 바꾸기</button>
			<button onclick="relayout()">relayout 호출하기</button>
		</p>
	</body>
	
	<script type="text/javascript">
		//지도를 담을 영역의 DOM 레퍼런스
		var container = document.getElementById('map');
		
		//지도를 생성할 때 필요한 기본 옵션
		var options = {
			center: new kakao.maps.LatLng(37.566535, 126.9779692), // 필수값
			level: 3
		};
		
		//지도 생성 및 객체 리턴
		var map = new kakao.maps.Map(container, options);
		
		
		// 지도 범위 재설정
		var points = [
			new kakao.maps.LatLng(37.5554893, 126.9783216),
			new kakao.maps.LatLng(37.5537586, 126.9809696),
			new kakao.maps.LatLng(37.579617, 126.977041)
		];
		
		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성
		var bounds = new kakao.maps.LatLngBounds();
		
		for (var i = 0; i < points.length; i++) {
			// 배열의 좌표들이 잘 보이게 마커 추가
			var marker = new kakao.maps.Marker({ position : points[i] });
			marker.setMap(map);
			
			// LatLngBounds 객체에 좌표 추가
			bounds.extend(points[i]);
		}
		
		function setBounds() {
			// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정
			// 이때 지도의 중심좌표와 레벨이 변경될 수 있음
			map.setBounds(bounds);
		}
		
		// 지도 영역 크기 변경
		function resizeMap() {
			var mapContainer = document.getElementById('map');
			mapContainer.style.width = '650px';
			mapContainer.style.height = '650px'; 
		}
		
		function relayout() {
			// 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있음
			// 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 함
			// window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동 호출
			map.relayout();
		}
		
	</script>
	
</html>