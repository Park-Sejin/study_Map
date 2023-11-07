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
			<button onclick="setOverlayMapTypeId('traffic')">교통정보 보기</button> 
			<button onclick="setOverlayMapTypeId('roadview')">로드뷰 도로정보 보기</button> 
			<button onclick="setOverlayMapTypeId('terrain')">지형정보 보기</button>
			<button onclick="setOverlayMapTypeId('use_district')">지적편집도 보기</button>
			<button onclick="setOverlayMapTypeId('bicycle')">자전거 도로 보기</button>
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
		
		
		// 지도타입에 맞는 지도정보 표시
		// 지도에 추가된 지도타입정보
		var currentTypeId;
		
		var mapTypes = {
			traffic : kakao.maps.MapTypeId.TRAFFIC, 			// 교통정보 지도타입
			roadview :  kakao.maps.MapTypeId.ROADVIEW, 			// 로드뷰 도로정보 지도타입
			terrain : kakao.maps.MapTypeId.TERRAIN, 			// 지형정보 지도타입
			use_district : kakao.maps.MapTypeId.USE_DISTRICT, 	// 지적편집도 지도타입
			bicycle : kakao.maps.MapTypeId.BICYCLE 				// 자전거 도로 지도타입
		};
		
		function setOverlayMapTypeId(maptype) {
			var changeMaptype;
			
			changeMaptype = mapTypes[maptype];
			
			// 이미 등록된 지도 타입이 있으면 제거
			if (currentTypeId) {
				map.removeOverlayMapTypeId(currentTypeId);
			}
			
			// maptype에 해당하는 지도타입을 지도에 추가
			map.addOverlayMapTypeId(changeMaptype);
			
			// 지도에 추가된 타입정보를 변경
			currentTypeId = changeMaptype;
		}
		
	</script>
	
</html>