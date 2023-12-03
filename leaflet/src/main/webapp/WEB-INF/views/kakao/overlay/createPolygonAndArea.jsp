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
			.info {position:relative;top:5px;left:5px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;font-size:12px;padding:5px;background:#fff;list-style:none;margin:0;} 
			.info:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
			.info .label {display:inline-block;width:50px;}
			.number {font-weight:bold;color:#00a0e9;}  
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
		
		
		// 다각형의 면적 계산
		var drawingFlag = false; // 다각형이 그려지고 있는 상태를 가지고 있을 변수
		var drawingPolygon; // 그려지고 있는 다각형을 표시할 다각형 객체
		var polygon; // 그리기가 종료됐을 때 지도에 표시할 다각형 객체
		var areaOverlay; // 다각형의 면적정보를 표시할 커스텀오버레이
		
		// 지도를 클릭 이벤트 (다각형 그리기 => 그려진 다각형이 있으면 지우고 다시 그림)
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 마우스로 클릭한 위치
			var clickPosition = mouseEvent.latLng;
			
			// 다각형을 그리고있는 상태가 아닌 경우
			if (!drawingFlag) {
				drawingFlag = true;
				
				// 지도 위에 다각형이 표시되고 있다면 제거
				if (polygon) {  
					polygon.setMap(null);
					polygon = null;  
				}
				
				// 면적정보 커스텀오버레이가 표시되고 있다면 제거
				if (areaOverlay) {
					areaOverlay.setMap(null);
					areaOverlay = null;
				}
				
				// 그려지고 있는 다각형을 표시할 다각형을 생성
				drawingPolygon = new kakao.maps.Polygon({
					map: map, // 다각형을 표시할 지도
					path: [clickPosition], // 다각형을 구성하는 좌표 배열
					strokeWeight: 3, // 선의 두께
					strokeColor: '#00a0e9', // 선의 색깔
					strokeOpacity: 1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
					strokeStyle: 'solid', // 선의 스타일
					fillColor: '#00a0e9', // 채우기 색깔
					fillOpacity: 0.2 // 채우기 불투명도
				}); 
				
				// 그리기가 종료됐을때 지도에 표시할 다각형을 생성
				polygon = new kakao.maps.Polygon({ 
					path: [clickPosition], // 다각형을 구성하는 좌표 배열
					strokeWeight: 3, // 선의 두께
					strokeColor: '#00a0e9', // 선의 색깔
					strokeOpacity: 1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
					strokeStyle: 'solid', // 선의 스타일
					fillColor: '#00a0e9', // 채우기 색깔
					fillOpacity: 0.2 // 채우기 불투명도
				});
			}
			// 다각형을 그리고 있는 상태인 경우
			else {
				// 다각형의 좌표 배열
				var drawingPath = drawingPolygon.getPath();
			
				// 좌표 배열에 클릭한 위치를 추가
				drawingPath.push(clickPosition);
				
				// 다시 다각형 좌표 배열을 설정
				drawingPolygon.setPath(drawingPath);
			
				// 다각형의 좌표 배열
				var path = polygon.getPath();
			
				// 좌표 배열에 클릭한 위치를 추가
				path.push(clickPosition);
				
				// 다시 다각형 좌표 배열을 설정
				polygon.setPath(path);
			}
		});
		
		// 무브 이벤트 (그려질 다각형의 위치를 동적으로 표시)
		kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
			// 다각형을 그리고있는 상태인 경우
			if (drawingFlag){
				// 마우스 커서의 현재 위치
				var mousePosition = mouseEvent.latLng; 
				
				// 그려지고있는 다각형의 좌표배열
				var path = drawingPolygon.getPath();
				
				// 마우스무브로 추가된 마지막 좌표를 제거
				if (path.length > 1) {
					path.pop();
				}
				
				// 마우스의 커서 위치를 좌표 배열에 추가
				path.push(mousePosition);
				
				// 그려지고 있는 다각형의 좌표를 다시 설정
				drawingPolygon.setPath(path);
			}
		});
		
		// 오른쪽 클릭 이벤트 (다각형을 그리고있다면 다각형 그리기를 종료)
		kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
			// 다각형을 그리고있는 상태인 경우
			if (drawingFlag) {
				drawingFlag = false;
				
				// 그려지고있는 다각형을 지도에서 제거
				drawingPolygon.setMap(null);
				drawingPolygon = null;  
				
				// 클릭된 죄표로 그릴 다각형의 좌표배열
				var path = polygon.getPath();
			
				if (path.length > 2) {
					// 지도에 다각형을 표시
					polygon.setMap(map); 
					
					// 다각형의 총면적을 계산
					var area = Math.round(polygon.getArea());
					// 커스텀오버레이에 추가될 내용
					var content = '<div class="info">총면적 <span class="number"> ' + area + '</span> m<sup>2</sup></div>';
					
					// 면적정보를 지도에 표시
					areaOverlay = new kakao.maps.CustomOverlay({
						map: map, // 커스텀오버레이를 표시할 지도
						content: content,  // 커스텀오버레이에 표시할 내용
						xAnchor: 0,
						yAnchor: 0,
						position: path[path.length-1] // 커스텀오버레이를 표시할 위치
					});
				} else { 
					polygon = null;
				}
			}
		});
		
	</script>
	
</html>