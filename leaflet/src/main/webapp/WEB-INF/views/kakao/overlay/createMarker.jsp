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
		
		
		/* 
		// 마커 생성
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(37.566535, 126.9779692)
		});
		
		// 마커가 지도 위에 표시되도록 설정
		marker.setMap(map);
		
		// 지도 위의 마커 제거
		// marker.setMap(null);
		
		// 마커가 드래그 가능하도록 설정
		marker.setDraggable(true);
		 */
		
		/* 
		// 다른 이미지로 마커 생성
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png' // 마커이미지 주소
		var imageSize = new kakao.maps.Size(64, 69) // 마커 크기
		var imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션 => 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정
		
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
		// 마커 생성
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(37.566535, 126.9779692), 
			draggable: true, // 도착 마커가 드래그 가능하도록 설정
			image: markerImage
		});
		
		// 마커가 지도 위에 표시되도록 설정
		marker.setMap(map);
		
		
		// dragstart, dragend 시 마커 이미지 변경
		kakao.maps.event.addListener(marker, 'dragstart', function() {
			marker.setImage(null);
		});
		
		kakao.maps.event.addListener(marker, 'dragend', function() {
			marker.setImage(markerImage);
		});
		 */
		
		// geolocation(현재위치) 마커 생성
		if (navigator.geolocation) {
			// 접속 위치
			navigator.geolocation.getCurrentPosition(function(position) {
				var lat = position.coords.latitude; // 위도
				var lon = position.coords.longitude; // 경도
				
				var locPosition = new kakao.maps.LatLng(lat, lon)
				var message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우 표시 내용
				
				// 마커, 인포윈도우 표시
				displayMarker(locPosition, message);
			});
		}
		else {
			var locPosition = new kakao.maps.LatLng(37.566535, 126.9779692);
			var message = 'geolocation을 사용할수 없어요..';
				
			displayMarker(locPosition, message);
		}
		
		// 지도에 마커와 인포윈도우를 표시하는 함수
		function displayMarker(locPosition, message) {
			// 마커를 생성
			var marker = new kakao.maps.Marker({  
				map: map, 
				position: locPosition
			}); 
			
			// 인포윈도우를 생성
			var infowindow = new kakao.maps.InfoWindow({
				content : message,
				removable : true
			});
			
			// 인포윈도우 마커위에 표시
			infowindow.open(map, marker);
			
			// 지도 중심좌표를 접속위치로 변경
			map.setCenter(locPosition);
		}
		
	</script>
	
</html>