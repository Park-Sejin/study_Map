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
			center: new kakao.maps.LatLng(33.450701, 126.570667), // 필수값
			level: 3
		};
		
		//지도 생성 및 객체 리턴
		var map = new kakao.maps.Map(container, options);
		
		
		// 도형 그리기
		// 원
		var circle = new kakao.maps.Circle({
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 원의 중심좌표
			radius: 50, // 미터 단위의 원 반지름
			strokeWeight: 5, // 선의 두께
			strokeColor: '#75B8FA', // 선의 색깔
			strokeOpacity: 1, // 선의 불투명도 (1에서 0 사이의 값이며, 0에 가까울수록 투명)
			strokeStyle: 'dashed', // 선의 스타일
			fillColor: '#CFE7FF', // 채우기 색깔
			fillOpacity: 0.7  // 채우기 불투명도
		});
		
		// 지도에 원 표시
		circle.setMap(map);
		
		// 선
		// 선을 구성하는 좌표 배열. 이 좌표들을 이어서 선을 표시
		var linePath = [
			new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
			new kakao.maps.LatLng(33.452739313807456, 126.5709308145358),
			new kakao.maps.LatLng(33.45178067090639, 126.5726886938753) 
		];
		
		var polyline = new kakao.maps.Polyline({
			path: linePath, // 선을 구성하는 좌표배열
			strokeWeight: 5, // 선의 두께
			strokeColor: '#FFAE00', // 선의 색깔
			strokeOpacity: 0.7, // 선의 불투명도 (1에서 0 사이의 값이며, 0에 가까울수록 투명)
			strokeStyle: 'solid' // 선의 스타일
		});
		
		// 지도에 선 표시
		polyline.setMap(map);
		
		// 사각형
		var sw = new kakao.maps.LatLng(33.448842, 126.570379), // 사각형 영역의 남서쪽 좌표
			ne = new kakao.maps.LatLng(33.450026,  126.568556); // 사각형 영역의 북동쪽 좌표
		
		// 지도에 표시할 사각형을 생성 ( 사각형을 생성할 때 영역정보는 LatLngBounds 객체로 넘겨줘야 함 )
		var rectangle = new kakao.maps.Rectangle({
			bounds: new kakao.maps.LatLngBounds(sw, ne), // 그려질 사각형의 영역정보
			strokeWeight: 4, // 선의 두께
			strokeColor: '#FF3DE5', // 선의 색깔
			strokeOpacity: 1, // 선의 불투명도 (1에서 0 사이의 값이며, 0에 가까울수록 투명)
			strokeStyle: 'shortdashdot', // 선의 스타일
			fillColor: '#FF8AEF', // 채우기 색깔
			fillOpacity: 0.8 // 채우기 불투명
		});
		
		// 지도에 사각형을 표시
		rectangle.setMap(map);
		
		// 다각형
		// 다각형을 구성하는 좌표 배열. 이 좌표들을 이어서 다각형을 표시
		var polygonPath = [
			new kakao.maps.LatLng(33.45133510810506, 126.57159381623066),
			new kakao.maps.LatLng(33.44955812811862, 126.5713551811832),
			new kakao.maps.LatLng(33.449986291544086, 126.57263296172184),
			new kakao.maps.LatLng(33.450682513554554, 126.57321034054742),
			new kakao.maps.LatLng(33.451346760004206, 126.57235740081413) 
		];
		
		// 지도에 표시할 다각형을 생성
		var polygon = new kakao.maps.Polygon({
			path:polygonPath, // 그려질 다각형의 좌표 배열
			strokeWeight: 3, // 선의 두께
			strokeColor: '#39DE2A', // 선의 색깔
			strokeOpacity: 0.8, // 선의 불투명 (1에서 0 사이의 값이며, 0에 가까울수록 투명)
			strokeStyle: 'longdash', // 선의 스타일
			fillColor: '#A2FF99', // 채우기 색깔
			fillOpacity: 0.7 // 채우기 불투명
		});
		
		// 지도에 다각형을 표시합니다
		polygon.setMap(map);
		
		// 구멍난 다각형
		// 다각형 객체를 구성할 좌표배열
		var path = [
			new kakao.maps.LatLng(33.45086654081833, 126.56906858718982),
			new kakao.maps.LatLng(33.45010890948828, 126.56898629127468),
			new kakao.maps.LatLng(33.44979857909499, 126.57049357211622),
			new kakao.maps.LatLng(33.450137483918496, 126.57202991943016),
			new kakao.maps.LatLng(33.450706188506054, 126.57223147947938),
			new kakao.maps.LatLng(33.45164068091554, 126.5713126693152)
		];
		
		var hole = [
			new kakao.maps.LatLng(33.4506262491095, 126.56997323165163),
			new kakao.maps.LatLng(33.45029422800042, 126.57042659659218),
			new kakao.maps.LatLng(33.45032339792896, 126.5710395101452),
			new kakao.maps.LatLng(33.450622037218295, 126.57136070280123),
			new kakao.maps.LatLng(33.450964416902046, 126.57129448564594),
			new kakao.maps.LatLng(33.4510527150534, 126.57075627706975)
		];
		
		// 다각형을 생성하고 지도에 표시합니다
		var polygon = new kakao.maps.Polygon({
			map: map,
			path: [path, hole], // 좌표 배열의 배열로 하나의 다각형을 표시
			strokeWeight: 2,
			strokeColor: '#b26bb2',
			strokeOpacity: 0.8,
			fillColor: '#f9f',
			fillOpacity: 0.7 
		});
		
	</script>
	
</html>