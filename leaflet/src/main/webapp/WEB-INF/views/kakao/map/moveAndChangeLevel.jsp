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
		<div id="map" style="width:100%;height:750px;"></div>
		
		<p>
			<button onclick="setCenter()">지도 중심좌표 이동시키기</button>
			<button onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button>
			
			<button onclick="setDraggable(false)">지도 드래그 이동 끄기</button>
			<button onclick="setDraggable(true)">지도 드래그 이동 켜기</button>
		</p>
		
		<p>
			<button onclick="zoomIn()">지도레벨 - 1</button>
			<button onclick="zoomOut()">지도레벨 + 1</button>
			
			<button onclick="setZoomable(false)">지도 확대/축소 끄기</button>
			<button onclick="setZoomable(true)">지도 확대/축소 켜기</button>
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
		
		
		// 지도 이동
		function setCenter() {
			// 이동할 위도 경도 위치를 생성
			var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);
			
			// 지도 중심을 이동
			map.setCenter(moveLatLon);
		}

		function panTo() {
			// 이동할 위도 경도 위치를 생성
			var moveLatLon = new kakao.maps.LatLng(33.450580, 126.574942);
			
			// 지도 중심을 부드럽게 이동, 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동
			map.panTo(moveLatLon);
		}
		
		// 지도 이동 막기
		function setDraggable(draggable) {
			// 마우스 드래그로 지도 이동 가능여부를 설정 ( true/false )
			map.setDraggable(draggable);
		}
		
		// 지도 레벨 변경
		// 지도 레벨은 1~14, 숫자가 작을수록 지도 확대 수준이 높음
		function zoomIn() {
			// 현재 지도의 레벨
			var level = map.getLevel();
			
			// 지도 확대
			map.setLevel(level - 1);
		}	
		
		function zoomOut() {	
			// 현재 지도의 레벨
			var level = map.getLevel(); 
			
			// 지도 축소
			map.setLevel(level + 1);
		}
		
		// 지도 레벨 변경 막기
		function setZoomable(zoomable) {
			// 마우스 휠로 지도 확대,축소 가능여부를 설정 ( true/false )
			map.setZoomable(zoomable);
		}
		
	</script>
	
</html>