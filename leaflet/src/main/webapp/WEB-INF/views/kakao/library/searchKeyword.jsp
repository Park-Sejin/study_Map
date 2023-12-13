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
		
		
		// 키워드로 장소 검색
		// 마커를 클릭 시 장소명을 표출할 인포윈도우
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 장소 검색 객체 생성
		var ps = new kakao.maps.services.Places();
		ps.keywordSearch('이태원 맛집', placesSearchCB);
		
		// 키워드 검색 완료 콜백함수
		function placesSearchCB (data, status, pagination) {
			if (status == kakao.maps.services.Status.OK) {
				// LatLngBounds 객체에 좌표 추가
				var bounds = new kakao.maps.LatLngBounds();
				
				for (var i=0; i<data.length; i++) {
					displayMarker(data[i]);
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}
				
				// 검색된 장소 위치를 기준으로 지도 범위 재설정
				map.setBounds(bounds);
			}
		}
		
		// 지도에 마커 표시
		function displayMarker(place) {
			// 마커 생성
			var marker = new kakao.maps.Marker({
				map: map,
				position: new kakao.maps.LatLng(place.y, place.x)
			});
			
			// 마커 클릭이벤트
			kakao.maps.event.addListener(marker, 'click', function() {
				// 장소명이 인포윈도우에 표출
				infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
				infowindow.open(map, marker);
			});
		}
		
	</script>
	
</html>