<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=efd80a5d832d16b149bdad0c598441d4&libraries=services"></script>
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
		
		
		// 주소로 장소 표시
		// 주소-좌표 변환 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표 검색
		geocoder.addressSearch('서울특별시 중구 세종대로 110', function(result, status) {
			// 정상 검색
			if (status == kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				// 마커 표시
				var marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});
				
				// 인포윈도우에 장소 설명 표시
				var infowindow = new kakao.maps.InfoWindow({
					content: '<div style="width:150px;text-align:center;padding:6px 0;">서울특별시청</div>'
				});
				infowindow.open(map, marker);
				
				// 지도 중심 이동
				map.setCenter(coords);
			}
		});
	</script>
	
</html>