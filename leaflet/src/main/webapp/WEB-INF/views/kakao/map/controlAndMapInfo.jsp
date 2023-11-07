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
			.map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
			.radius_border{border:1px solid #919191;border-radius:5px;}	 
			.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:130px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
			.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
			.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}	   
			.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
			.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}	
			.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
			.custom_typecontrol .selected_btn:hover {color:#fff;}   
			.custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5;} 
			.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}	 
			.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}			 
			.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;}  
		</style>
	</head>
	<body>
		<h3>Place</h3>
		<div id="map" style="width:100%;height:750px;"></div>
		
		<!-- 지도타입 컨트롤 div -->
		<div class="custom_typecontrol radius_border">
			<span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
			<span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
		</div>
		<!-- 지도 확대, 축소 컨트롤 div -->
		<div class="custom_zoomcontrol radius_border"> 
			<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
			<span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
		</div>
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
		
		
		// 지도 정보
		// 지도의 현재 중심좌표
		var center = map.getCenter(); 
		
		// 지도의 현재 레벨
		var level = map.getLevel();
		
		// 지도타입
		var mapTypeId = map.getMapTypeId(); 
		
		// 지도의 현재 영역
		var bounds = map.getBounds();
		
		// 영역의 남서쪽 좌표
		var swLatLng = bounds.getSouthWest(); 
		
		// 영역의 북동쪽 좌표
		var neLatLng = bounds.getNorthEast(); 
		
		// 영역정보 문자열 ((남,서), (북,동)) 형식
		var boundsStr = bounds.toString();
		
		
		// 컨트롤 생성
		/* 
		// 지도타입 컨트롤 생성 : 일반 지도와 스카이뷰 전환
		var mapTypeControl = new kakao.maps.MapTypeControl();
		
		// 지도 타입 컨트롤을 지도에 표시 ( 오른쪽 위 )
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		
		// 줌 컨트롤 생성 : 지도 확대 축소 제어
		var zoomControl = new kakao.maps.ZoomControl();
		
		// 줌 컨트롤을 지도에 표시 ( 오른쪽 위 )
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		*/
		
		// 사용자 정의 컨트롤
		// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수
		function setMapType(maptype) { 
			var roadmapControl = document.getElementById('btnRoadmap');
			var skyviewControl = document.getElementById('btnSkyview');
			if (maptype === 'roadmap') {
				map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
				roadmapControl.className = 'selected_btn';
				skyviewControl.className = 'btn';
			} else {
				map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
				skyviewControl.className = 'selected_btn';
				roadmapControl.className = 'btn';
			}
		}
		
		// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수
		function zoomIn() {
			map.setLevel(map.getLevel() - 1);
		}
		
		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수
		function zoomOut() {
			map.setLevel(map.getLevel() + 1);
		}
		
	</script>
	
</html>