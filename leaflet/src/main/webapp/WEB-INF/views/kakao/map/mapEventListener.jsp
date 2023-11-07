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
		
		<p id="result"></p>
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
		
		
		// 클릭 이벤트
		// 지도 중심좌표에 마커 생성 
		var marker = new kakao.maps.Marker({ 
			position: map.getCenter() 
		}); 
		
		// 지도에 마커 표시
		marker.setMap(map);
		
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보
			var latlng = mouseEvent.latLng;
			
			// 마커 위치를 클릭한 위치로 옮김
			marker.setPosition(latlng);
			
			var message = '좌표(위도, 경도) : ' + latlng.getLat() + ', ' + latlng.getLng();
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
		});
		
		// 이동 이벤트
		kakao.maps.event.addListener(map, 'dragend', function() {
			// 지도 이동 후 중심좌표
			var latlng = map.getCenter();
			
			var message = '변경된 중심 좌표(위도, 경도) : ' + latlng.getLat() + ', ' + latlng.getLng();
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
		});
		
		// 레벨 변경 이벤트
		kakao.maps.event.addListener(map, 'zoom_changed', function() {
			// 지도 변경된 현재 레벨
			var level = map.getLevel();
			
			var message = '현재 지도 레벨 : ' + level;
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
		});
		
		// 중심좌표 변경 이벤트
		kakao.maps.event.addListener(map, 'center_changed', function() {
			// 지도의 레벨
			var level = map.getLevel();
		
			// 지도의 변경된 중심좌표
			var latlng = map.getCenter(); 
		
			var message = '지도 레벨 : ' + level + ', 중심 좌표(위도, 경도) : ' + latlng.getLat() + ', ' + latlng.getLng();
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
		});
		
		// 영역 변경 이벤트
		kakao.maps.event.addListener(map, 'bounds_changed', function() {
			// 지도 영역정보
			var bounds = map.getBounds();
			
			// 영역정보의 남서쪽 정보
			var swLatlng = bounds.getSouthWest();
			
			// 영역정보의 북동쪽 정보
			var neLatlng = bounds.getNorthEast();
			
			var message = '<p>영역좌표는 남서쪽 위도, 경도 : ' + swLatlng.toString() + ', ';
			message += '북동쪽 위도, 경도 :  ' + neLatlng.toString() + '</p>';
			
			var resultDiv = document.getElementById('result');
			resultDiv.innerHTML = message;
		});
		
		// 타일 로드 이벤트
		var marker = new kakao.maps.Marker();
		
		// 타일 로드가 완료되면 지도 중심에 마커를 표시
		kakao.maps.event.addListener(map, 'tilesloaded', displayMarker);

		function displayMarker() {
			// 마커의 위치를 지도중심으로 설정
			marker.setPosition(map.getCenter()); 
			marker.setMap(map); 

			// 아래 코드는 최초 한번만 타일로드 이벤트가 발생했을 때, 처리 후 이벤트를 제거하는 코드
			// kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		}
		
	</script>
	
</html>