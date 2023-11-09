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
			<button onclick="setMarkers(false)">마커 감추기</button>
			<button onclick="setMarkers(true)">마커 보이기</button>
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
		
		
		// 여러개 마커 생성
		// 지도에 표시된 마커 객체를 가지고 있을 배열
		var markers = [];
		
		// 마커를 표시할 위치와 title 객체 배열
		var positions = [
			{
				title: '서울시청', 
				latlng: new kakao.maps.LatLng(37.566535, 126.9779692)
			},
			{
				title: '덕수궁', 
				latlng: new kakao.maps.LatLng(37.5658049, 126.9751461)
			},
			{
				title: '탑골공원', 
				latlng: new kakao.maps.LatLng(37.5711455, 126.9883295)
			},
			{
				title: '서울역',
				latlng: new kakao.maps.LatLng(37.5547125, 126.9707878)
			}
		];
		
		// 지도위에 마커 표시합니다 
		for (var i = 0; i < positions.length; i ++) {
			addMarker(positions[i].latlng, positions[i].title);
		}
		
		// 지도 클릭 이벤트
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위치에 마커를 표시
			addMarker(mouseEvent.latLng);
		});
		
		// 마커를 생성하고 지도위에 표시하는 함수
		function addMarker(position, title) {
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				map: map, // 마커를 표시할 지도
				position: position, // 마커를 표시할 위치
				title : title // 마커의 타이틀, 마커에 마우스를 올리면 표시
			});
			
			// 생성된 마커를 배열에 추가
			markers.push(marker);
		}
		
		// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수
		function setMarkers(show) {
			var mapInfo = (show)? map : null;
			
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(mapInfo);
			}
		}
		
	</script>
	
</html>