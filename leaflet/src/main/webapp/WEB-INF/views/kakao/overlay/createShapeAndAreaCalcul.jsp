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
			.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
			.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
			.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
			.number {font-weight:bold;color:#ee6152;}
			.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
			.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
			.distanceInfo .label {display:inline-block;width:50px;}
			.distanceInfo:after {content:none;}
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
		
		
		// 선의 거리 계산
		var drawingFlag = false; // 선이 그려지고 있는 상태
		var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체
		var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체
		var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이
		var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열
		
		// 지도를 클릭 이벤트 (선 그리기 => 그려진 선이 있으면 지우고 다시 그림)
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 마우스로 클릭한 위치
			var clickPosition = mouseEvent.latLng;
			
			// 선을 그리고있는 상태가 아닌 경우
			if (!drawingFlag) {
				drawingFlag = true;
				
				// 그려진 선이나 커스텀 오버레이 및 거리정보가 있다면 제거하는 함수
				deleteShapeAndInfo();
			
				// 클릭한 위치를 기준으로 선을 생성
				clickLine = new kakao.maps.Polyline({
					map: map, // 선을 표시할 지도
					path: [clickPosition], // 선을 구성하는 좌표 배열 ( 클릭한 위치 )
					strokeWeight: 3, // 선의 두께
					strokeColor: '#db4040', // 선의 색깔
					strokeOpacity: 1, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
					strokeStyle: 'solid' // 선의 스타일
				});
				
				// 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성
				moveLine = new kakao.maps.Polyline({
					strokeWeight: 3, // 선의 두께
					strokeColor: '#db4040', // 선의 색깔
					strokeOpacity: 0.5, // 선의 불투명도 (0에서 1 사이값이며, 0에 가까울수록 투명)
					strokeStyle: 'solid' // 선의 스타일
				});
			}
			// 선을 그리고 있는 상태인 경우
			else {
				// 그려지고 있는 선의 좌표 배열
				var path = clickLine.getPath();
				
				// 좌표 배열에 클릭한 위치를 추가
				path.push(clickPosition);
				
				// 선을 구성하는 좌표 배열 재설정
				clickLine.setPath(path);
			}
			
			// 클릭한 지점에 대한 정보를 지도에 표시
			var distance = Math.round(clickLine.getLength());
			displayCircleDot(clickPosition, distance);
		});
		
		// 무브 이벤트 (그려질 선의 위치를 동적으로 표시)
		kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
			// 선을 그리고 있는 상태인 경우
			if (drawingFlag){
				// 마우스 커서의 현재 위치
				var mousePosition = mouseEvent.latLng; 
				
				// 그려지고 있는 선의 좌표 배열
				var path = clickLine.getPath();
				
				// 마우스 클릭 마지막 좌표, 마우스 커서 현재 위치의 좌표
				var movepath = [path[path.length-1], mousePosition];
				moveLine.setPath(movepath);	
				moveLine.setMap(map);
				
				// 선의 총 거리 계산
				var distance = Math.round(clickLine.getLength() + moveLine.getLength());
				// 커스텀오버레이에 추가될 내용
				var content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>';
				
				// 거리정보를 지도에 표시
				showDistance(content, mousePosition);
			}			 
		});
		
		// 오른쪽 클릭 이벤트 (선을 그리고있다면 선 그리기를 종료)
		kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
			// 선을 그리고있는 상태인 경우
			if (drawingFlag) {
				drawingFlag = false;
				
				// 마우스무브로 그려진 선은 지도에서 제거
				moveLine.setMap(null);
				moveLine = null;  
				
				// 그려진 선의 좌표 배열
				var path = clickLine.getPath();
				
				if (path.length > 1) {
					// 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지움
					if (dots[dots.length-1].distance) {
						dots[dots.length-1].distance.setMap(null);
						dots[dots.length-1].distance = null;	
					}
					
					// 선의 총 거리를 계산
					var distance = Math.round(clickLine.getLength());
					// 커스텀오버레이에 추가될 내용
					var content = getTimeHTML(distance);
						
					// 거리정보를 지도에 표시
					showDistance(content, path[path.length-1]);
				} else {
					// 지도에 표시되고 있는 선과 정보들을 지도에서 제거
					deleteShapeAndInfo();
				}
			}
		});
		
		// 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수
		function showDistance(content, position) {
			// 커스텀오버레이가 생성된 상태인 경우
			if (distanceOverlay) {
				// 커스텀 오버레이의 위치와 표시할 내용을 설정
				distanceOverlay.setPosition(position);
				distanceOverlay.setContent(content);
			}
			// 커스텀 오버레이가 생성되지 않은 상태인 경우
			else {
				// 커스텀 오버레이를 생성
				distanceOverlay = new kakao.maps.CustomOverlay({
					map: map, // 커스텀오버레이를 표시할 지도
					content: content,  // 커스텀오버레이에 표시할 내용
					position: position, // 커스텀오버레이를 표시할 위치
					xAnchor: 0,
					yAnchor: 0,
					zIndex: 3  
				});
			}
		}
		
		// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수
		function displayCircleDot(position, distance) {
			// 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성
			var circleOverlay = new kakao.maps.CustomOverlay({
				content: '<span class="dot"></span>',
				position: position,
				zIndex: 1
			});
			
			// 지도에 표시
			circleOverlay.setMap(map);
			
			if (distance > 0) {
				// 그려진 선의 총 거리를 표시할 커스텀 오버레이 생성
				var distanceOverlay = new kakao.maps.CustomOverlay({
					content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
					position: position,
					yAnchor: 1,
					zIndex: 2
				});
				// 지도에 표시
				distanceOverlay.setMap(map);
			}
			// 배열에 추가
			dots.push({circle:circleOverlay, distance: distanceOverlay});
		}
		
		
		// 그려진 도형 및 오버레이를 제거하는 함수
		function deleteShapeAndInfo() {
			// deleteClickLine ( 선 )
			if (clickLine) {
				clickLine.setMap(null);
				clickLine = null;
			}
			
			// deleteDistnce ( 커스텀 오버레이 )
			if (distanceOverlay) {
				distanceOverlay.setMap(null);
				distanceOverlay = null;
			}
			
			// deleteCircleDot ( 클릭 지점에 대한 정보 )
			for (var i = 0; i < dots.length; i++ ){
				if (dots[i].circle) { 
					dots[i].circle.setMap(null);
				}
				
				if (dots[i].distance) {
					dots[i].distance.setMap(null);
				}
			}
				
			dots = [];
		}
		
		// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산한 text
		function getTimeHTML(distance) {
			// 도보 ( 평균 시속 : 4km/h, 분속 : 67m/min )
			var walkkTime = distance / 67 | 0;
			var walkHour = '', walkMin = '';
			
			// 시
			if (walkkTime > 60) {
				walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
			}
			// 분
			walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'
			
			// 자전거 ( 평균 시속 : 16km/h, 분속 : 267m/min )
			var bycicleTime = distance / 227 | 0;
			var bycicleHour = '', bycicleMin = '';
			
			// 시
			if (bycicleTime > 60) {
				bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
			}
			// 분
			bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'
			
			// HTML Content
			var content = '<ul class="dotOverlay distanceInfo">';
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