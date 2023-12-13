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
			/* 
			.label * {display: inline-block;vertical-align: top;}
			.label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
			.label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
			.label .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;} 
			 */
			
			/* 
			.overlaybox {position:relative;width:360px;height:350px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
			.overlaybox div, ul {overflow:hidden;margin:0;padding:0;}
			.overlaybox li {list-style: none;}
			.overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;margin-bottom:8px;}
			.overlaybox .first {position:relative;width:247px;height:136px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png') no-repeat;margin-bottom:8px;}
			.first .text {color:#fff;font-weight:bold;}
			.first .triangle {position:absolute;width:48px;height:48px;top:0;left:0;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:6px;font-size:18px;}
			.first .movietitle {position:absolute;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;}
			.overlaybox ul {width:247px;}
			.overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
			.overlaybox li span {display:inline-block;}
			.overlaybox li .number {font-size:16px;font-weight:bold;}
			.overlaybox li .title {font-size:13px;}
			.overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;} 
			.overlaybox li .up {background-position:0 -40px;}
			.overlaybox li .down {background-position:0 -60px;}
			.overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
			.overlaybox li:hover {color:#fff;background:#d24545;}
			.overlaybox li:hover .up {background-position:0 0px;}
			.overlaybox li:hover .down {background-position:0 -20px;}
			 */
			
			/* 
			.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
			.wrap * {padding: 0;margin: 0;}
			.wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
			.wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
			.info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
			.info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
			.info .close:hover {cursor: pointer;}
			.info .body {position: relative;overflow: hidden;}
			.info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
			.desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
			.desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
			.info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
			.info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
			.info .link {color: #5085BB;}
			 */
			
			/* 
			.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
			.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
			.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
			.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
			.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
			 */
			
			.overlay {
				position:absolute;
				left: -50px;
				top:0;
				width:100px;
				height: 100px;
				background: #fff;
				border:1px solid #ccc;
				border-radius: 5px;
				padding:5px;
				font-size:12px;
				text-align: center;
				white-space: pre;
				word-wrap: break-word;
			}
			
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
		
		
		// 커스텀오버레이 생성
		/* 
		// 커스텀 오버레이 생성 1
		var content = '<div class ="label"><span class="left"></span><span class="center">Custom Overlay</span><span class="right"></span></div>';
		
		var customOverlay = new kakao.maps.CustomOverlay({
			position: new kakao.maps.LatLng(33.450701, 126.570667),
			content: content
		});
		
		// 커스텀 오버레이 지도에 표시
		customOverlay.setMap(map);
		*/
		
		/* 
		// 커스텀 오버레이 생성 2
		var content = '<div class="overlaybox">' +
					'	<div class="boxtitle">금주 영화순위</div>' +
					'	<div class="first">' +
					'		<div class="triangle text">1</div>' +
					'		<div class="movietitle text">드래곤 길들이기2</div>' +
					'	</div>' +
					'	<ul>' +
					'		<li class="up">' +
					'			<span class="number">2</span>' +
					'			<span class="title">명량</span>' +
					'			<span class="arrow up"></span>' +
					'			<span class="count">2</span>' +
					'		</li>' +
					'		<li>' +
					'			<span class="number">3</span>' +
					'			<span class="title">해적(바다로 간 산적)</span>' +
					'			<span class="arrow up"></span>' +
					'			<span class="count">6</span>' +
					'		</li>' +
					'		<li>' +
					'			<span class="number">4</span>' +
					'			<span class="title">해무</span>' +
					'			<span class="arrow up"></span>' +
					'			<span class="count">3</span>' +
					'		</li>' +
					'		<li>' +
					'			<span class="number">5</span>' +
					'			<span class="title">안녕, 헤이즐</span>' +
					'			<span class="arrow down"></span>' +
					'			<span class="count">1</span>' +
					'		</li>' +
					'	</ul>' +
					'</div>';
		
		var customOverlay = new kakao.maps.CustomOverlay({
			position: new kakao.maps.LatLng(33.450701, 126.570667),
			content: content,
			xAnchor: 0.3,
			yAnchor: 0.91
		});
	
		// 커스텀 오버레이를 지도에 표시합니다
		customOverlay.setMap(map);
		*/
		
		/* 
		// 닫기가 가능한 커스텀 오버레이
		// 지도에 마커를 표시
		var marker = new kakao.maps.Marker({
			map: map, 
			position: new kakao.maps.LatLng(33.450701, 126.570667)
		});
		
		var content = '<div class="wrap">' + 
					'	<div class="info">' + 
					'		<div class="title">' + 
					'			카카오 스페이스닷원' + 
					'			<div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
					'		</div>' + 
					'		<div class="body">' + 
					'			<div class="img">' + 
					'				<img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' + 
					'			</div>' + 
					'			<div class="desc">' + 
					'				<div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' + 
					'				<div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' + 
					'				<div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' + 
					'			</div>' + 
					'		</div>' + 
					'	</div>' + 
					'</div>';
		
		// 마커 위에 커스텀오버레이를 표시 ( 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치 설정함 )
		var overlay = new kakao.maps.CustomOverlay({
			content: content,
			map: map,
			position: marker.getPosition()
		});
		
		// 마커를 클릭했을 때 커스텀 오버레이 표시
		kakao.maps.event.addListener(marker, 'click', function() {
			overlay.setMap(map);
		});
		
		// 커스텀 오버레이를 닫기 위해 호출되는 함수
		function closeOverlay() {
			overlay.setMap(null);
		}
		 */
		
		/* 
		// 이미지 마커와 커스텀 오버레이
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지 주소
			imageSize = new kakao.maps.Size(64, 69), // 마커이미지 크기
			imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지 옵션. ( 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정 )
		
		// 마커 생성
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(33.450701, 126.570667),
			image: new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption) // 마커이미지 설정
		});
		
		// 마커를 지도 위에 표시
		marker.setMap(map);
		
		// 커스텀 오버레이 생성
		var content = '<div class="customoverlay">' +
					'	<a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
					'		<span class="title">구의야구공원</span>' +
					'	</a>' +
					'</div>';
		
		var customOverlay = new kakao.maps.CustomOverlay({
			map: map,
			position: marker.getPosition(),
			content: content,
			yAnchor: 1 
		});
		 */
		
		// 커스텀 오버레이 드레그
		// 커스텀 오버레이 생성
		var content = document.createElement('div');
		content.className = 'overlay';
		content.innerHTML = '드래그 해주세요 :D';
		
		var customoverlay = new kakao.maps.CustomOverlay({
			map: map,
			content: content,
			position: new kakao.maps.LatLng(33.450701, 126.570667)
		});
		
		var startX, startY, startOverlayPoint; // 드래그 시작좌표, 커스텀 오버레이의 위치좌표
		
		// mousedown 이벤트
		addEventHandle(content, 'mousedown', onMouseDown);
		
		// mouseup 이벤트
		addEventHandle(document, 'mouseup', onMouseUp);
		
		// mousedown 호출 핸들러
		function onMouseDown(e) {
			// 커스텀 오버레이를 드래그 할 때, 내부 텍스트가 영역 선택되는 현상을 막아줌
			if (e.preventDefault) {
				e.preventDefault();
			} else {
				e.returnValue = false;
			}
			
			var proj = map.getProjection(); // 화면픽셀좌표, 지도좌표간 변환을 위한 MapProjection 객체
			var overlayPos = customoverlay.getPosition(); // 커스텀 오버레이의 현재 위치
		
			// 커스텀오버레이에서 마우스 관련 이벤트가 발생해도 지도가 움직이지 않도록 설정
			kakao.maps.event.preventMap();
		
			// mousedown된 좌표를 설정
			startX = e.clientX;
			startY = e.clientY;
		
			// mousedown됐을 때의 커스텀 오버레이의 좌표 -> 지도 컨테이너내 픽셀 좌표로 변환
			startOverlayPoint = proj.containerPointFromCoords(overlayPos);
		
			// mousemove 이벤트 등록
			addEventHandle(document, 'mousemove', onMouseMove);
		}
		
		// mousemove 호출 핸들러
		function onMouseMove(e) {
			// 커스텀 오버레이를 드래그 할 때, 내부 텍스트가 영역 선택되는 현상을 막아줌
			if (e.preventDefault) {
				e.preventDefault();
			} else {
				e.returnValue = false;
			}
			
			var proj = map.getProjection(); // 화면픽셀좌표, 지도좌표간 변환을 위한 MapProjection 객체
			var deltaX = startX - e.clientX; // 실제로 마우스가 이동된 픽셀좌표 (mousedown한 좌표 - mousemove한 좌표)
			var deltaY = startY - e.clientY;
			
			// mousedown됐을 때의 커스텀 오버레이의 좌표에 실제로 마우스가 이동된 픽셀좌표를 반영
			var newPoint = new kakao.maps.Point(startOverlayPoint.x - deltaX, startOverlayPoint.y - deltaY); 
			// 계산된 픽셀 좌표를 지도 컨테이너에 해당하는 지도 좌표로 변경
			var newPos = proj.coordsFromContainerPoint(newPoint);
		
			// 커스텀 오버레이의 좌표를 설정
			customoverlay.setPosition(newPos);
		}
		
		// mouseu 호출 핸들러
		function onMouseUp(e) {
			// 등록된 mousemove 이벤트 핸들러 제거
			removeEventHandle(document, 'mousemove', onMouseMove);
		}
		
		// target node에 이벤트 핸들러를 등록하는 함수
		function addEventHandle(target, type, callback) {
			if (target.addEventListener) {
				target.addEventListener(type, callback);
			} else {
				target.attachEvent('on' + type, callback);
			}
		}
		
		// target node에 등록된 이벤트 핸들러를 제거하는 함수
		function removeEventHandle(target, type, callback) {
			if (target.removeEventListener) {
				target.removeEventListener(type, callback);
			} else {
				target.detachEvent('on' + type, callback);
			}
		}
		
	</script>
	
</html>