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
		// 인포윈도우 생성
		var iwContent = '<div style="padding:5px;">Hello World!</div>', // 표출 내용
			iwPosition = new kakao.maps.LatLng(37.566535, 126.9779692), //인포윈도우 표시 위치
		
		// 인포윈도우를 생성 및 지도 표시
		var infowindow = new kakao.maps.InfoWindow({
			map: map, // 인포윈도우가 표시될 지도
			position : iwPosition, 
			content : iwContent,
			removable : true // 닫기버튼 표시
		});
			
		// 인포윈도우 제거
		// infowindow.close();
		 */
		
		// 마커에 인포윈도우 표시
		// 마커 생성
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(37.566535, 126.9779692)
		});
		
		// 마커가 지도 위에 표시되도록 설정
		marker.setMap(map);
		
		var iwContent = '<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 표출 내용
			iwPosition = new kakao.maps.LatLng(37.566535, 126.9779692); // 표시 위치
		
		// 인포윈도우를 생성
		var infowindow = new kakao.maps.InfoWindow({
			//position : iwPosition, 
			content : iwContent, 
			removable : true // 닫기버튼 표시
		});
		
		// 마커 위에 인포윈도우를 표시. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시 됨
		infowindow.open(map, marker); 
		
	</script>
	
</html>