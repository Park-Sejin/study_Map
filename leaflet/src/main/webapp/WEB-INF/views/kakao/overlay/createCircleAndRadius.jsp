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
		
		
		// 원의 반경 계산
		var drawingFlag = false; // 원이 그려지고 있는 상태를 가지고 있을 변수
		var centerPosition; // 원의 중심좌표
		var drawingCircle; // 그려지고 있는 원을 표시할 원 객체
		var drawingLine; // 그려지고 있는 원의 반지름을 표시할 선 객체
		var drawingOverlay; // 그려지고 있는 원의 반경을 표시할 커스텀오버레이
		var drawingDot; // 그려지고 있는 원의 중심점을 표시할 커스텀오버레이
		var circles = []; // 클릭으로 그려진 원과 반경 정보를 표시하는 선과 커스텀오버레이를 가지고 있을 배열
		
		// 클릭 이벤트
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 원을 그리고 있는 상태가 아닌 경우
			if (!drawingFlag) {
				drawingFlag = true; 
				
				// 원이 그려질 중심좌표를 클릭한 위치로 설정
				centerPosition = mouseEvent.latLng;
 				
				// 선 객체 생성 ( 그려지고 있는 원의 반경을 표시 )
				if (!drawingLine) {
					drawingLine = new kakao.maps.Polyline({
						strokeWeight: 3, // 선의 두께
						strokeColor: '#00a0e9', // 선의 색깔
						strokeOpacity: 1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
						strokeStyle: 'solid' // 선의 스타일
					});
				}
				
				// 원 객체 생성 ( 그려지고 있는 원을 표시 )
				if (!drawingCircle) {
					drawingCircle = new kakao.maps.Circle({ 
						strokeWeight: 1, // 선의 두께
						strokeColor: '#00a0e9', // 선의 색깔
						strokeOpacity: 0.1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
						strokeStyle: 'solid', // 선의 스타일
						fillColor: '#00a0e9', // 채우기 색깔
						fillOpacity: 0.2 // 채우기 불투명도
					});
				}
				
				// 커스텀오버레이 생성 ( 그려지고 있는 원의 반경 정보 )
				if (!drawingOverlay) {
					drawingOverlay = new kakao.maps.CustomOverlay({
						xAnchor: 0,
						yAnchor: 0,
						zIndex: 1
					});
				}
			}
		});
		
		// 마우스무브 이벤트 (그려질 원의 위치와 반경정보를 동적으로 표시)
		kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
			// 원을 그리고있는 상태인 경우
			if (drawingFlag) {
				// 마우스 커서의 현재 위치
				var mousePosition = mouseEvent.latLng;
				
				// 그려지고 있는 선을 표시할 좌표 배열
				var linePath = [centerPosition, mousePosition];
				
				// 그려지고 있는 선을 표시할 선 객체에 좌표 배열을 설정
				drawingLine.setPath(linePath);
				
				// 원의 반지름
				var length = drawingLine.getLength();
				
				if(length > 0) {
					// 그려지고 있는 원의 중심좌표와 반지름
					var circleOptions = {
						center : centerPosition,
						radius: length,
					};
					
					// 그려지고 있는 원의 옵션
					drawingCircle.setOptions(circleOptions); 
						
					// 반경 정보를 표시할 커스텀오버레이의 내용
					var radius = Math.round(drawingCircle.getRadius());
					var content = '<div class="info">반경 <span class="number">' + radius + '</span>m</div>';
					
					// 오버레이의 좌표를 마우스커서 위치로 설정
					drawingOverlay.setPosition(mousePosition);
					
					// 오버레이에 표시할 내용 설정
					drawingOverlay.setContent(content);
					
					// 원을 지도에 표시
					drawingCircle.setMap(map); 
					
					// 선을 지도에 표시
					drawingLine.setMap(map);
					
					// 커스텀 오버레이를 지도에 표시
					drawingOverlay.setMap(map);
				} else {
					drawingCircle.setMap(null);
					drawingLine.setMap(null);
					drawingOverlay.setMap(null);
				}
			}
		});
		
		// 클릭 이벤트 (원, 선, 커스텀 오버레이를 표시하고 그리기를 종료)
		kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
			if (drawingFlag) {
				drawingFlag = false;
				
				// 마우스로 오른쪽 클릭한 위치
				var rClickPosition = mouseEvent.latLng; 
				
				// 원의 반경을 표시할 선 객체 생성
				var polyline = new kakao.maps.Polyline({
					path: [centerPosition, rClickPosition], // 선을 구성하는 좌표 배열
					strokeWeight: 3, // 선의 두께
					strokeColor: '#00a0e9', // 선의 색깔
					strokeOpacity: 1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
					strokeStyle: 'solid' // 선의 스타일
				});
				
				// 원 객체 생성
				var circle = new kakao.maps.Circle({ 
					center : centerPosition, // 원의 중심좌표
					radius: polyline.getLength(), // 원의 반지름 (m 단위)
					strokeWeight: 1, // 선의 두께
					strokeColor: '#00a0e9', // 선의 색깔
					strokeOpacity: 0.1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
					strokeStyle: 'solid', // 선의 스타
					fillColor: '#00a0e9', // 채우기 색깔
					fillOpacity: 0.2  // 채우기 불투명도
				});
				
				// 원의 반경 정보
				var radius = Math.round(circle.getRadius());
				// 커스텀 오버레이에 표시할 반경 정보
				var content = getTimeHTML(radius);
				
				
				// 반경정보를 표시할 커스텀 오버레이 생성
				var radiusOverlay = new kakao.maps.CustomOverlay({
					content: content, // 표시할 내용
					position: rClickPosition, // 표시할 위치
					xAnchor: 0,
					yAnchor: 0,
					zIndex: 1 
				});  
				
				// 원을 지도에 표시
				circle.setMap(map); 
				
				// 선을 지도에 표시
				polyline.setMap(map);
				
				// 커스텀 오버레이를 지도에 표시
				radiusOverlay.setMap(map);
				
				// 배열에 담을 객체 (원, 선, 커스텀오버레이 객체)
				var radiusObj = {
					'polyline' : polyline,
					'circle' : circle,
					'overlay' : radiusOverlay
				};
				
				// 배열에 추가 ("모두 지우기" 버튼을 클릭했을 때 지도에 그려진 원, 선, 커스텀오버레이들을 지움)
				circles.push(radiusObj);
				
				// 중심 좌표 초기화
				centerPosition = null;
				
				// 그려지고 있는 원, 선, 커스텀오버레이를 지도에서 제거
				drawingCircle.setMap(null);
				drawingLine.setMap(null);
				drawingOverlay.setMap(null);
			}
		});
		
		// 지도에 표시되어 있는 모든 원, 선, 커스텀 오버레이 제거
		function removeCircles() {
			for (var i = 0; i < circles.length; i++) {
				circles[i].circle.setMap(null);
				circles[i].polyline.setMap(null);
				circles[i].overlay.setMap(null);
			}
			
			circles = [];
		}
		
		// 그려진 원의 반경 정보 및 반경에 대한 도보, 자전거 시간을 계산하는 함수
		function getTimeHTML(distance) {
			// 도보 (시속 평균 : 4km/h, 분속 : 67m/min)
			var walkkTime = distance / 67 | 0;
			var walkHour = '', walkMin = '';
			
			// 시
			if (walkkTime > 60) {
				walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
			}
			// 분
			walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'
			
			// 자전거 (평균 시속 : 16km/h, 분속 : 267m/min)
			var bycicleTime = distance / 227 | 0;
			var bycicleHour = '', bycicleMin = '';
			
			// 시
			if (bycicleTime > 60) {
				bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
			}
			// 분
			bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'
			
			// 거리와 도보 시간, 자전거 시간 content
			var content = '<ul class="info">';
			content += '	<li>';
			content += '		<span class="label">총거리</span><span class="number">' + distance + '</span>m';
			content += '	</li>';
			content += '	<li>';
			content += '		<span class="label">도보</span>' + walkHour + walkMin;
			content += '	</li>';
			content += '	<li>';
			content += '		<span class="label">자전거</span>' + bycicleHour + bycicleMin;
			content += '	</li>';
			content += '</ul>'

			return content;
		}
		
	</script>
	
</html>