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
			.category, .category *{margin:0;padding:0;color:#000;}   
			.category {position:absolute;overflow:hidden;top:10px;left:10px;width:150px;height:50px;z-index:10;border:1px solid black;font-family:'Malgun Gothic','맑은 고딕',sans-serif;font-size:12px;text-align:center;background-color:#fff;}
			.category .menu_selected {background:#FF5F4A;color:#fff;border-left:1px solid #915B2F;border-right:1px solid #915B2F;margin:0 -1px;} 
			.category li{list-style:none;float:left;width:50px;height:45px;padding-top:5px;cursor:pointer;} 
			.category .ico_comm {display:block;margin:0 auto 2px;width:22px;height:26px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png') no-repeat;} 
			.category .ico_coffee {background-position:-10px 0;}  
			.category .ico_store {background-position:-10px -36px;}   
			.category .ico_carpark {background-position:-10px -72px;} 
		</style>
	</head>
	<body>
		<h3>Place</h3>
		<div id="map" style="width:100%;height:800px;"></div>
		
		<!-- 지도 위에 표시될 마커 카테고리 -->
		<div class="category">
			<ul>
				<li id="coffeeMenu" onclick="changeMarker('coffee')">
					<span class="ico_comm ico_coffee"></span>
					커피숍
				</li>
				<li id="storeMenu" onclick="changeMarker('store')">
					<span class="ico_comm ico_store"></span>
					편의점
				</li>
				<li id="carparkMenu" onclick="changeMarker('carpark')">
					<span class="ico_comm ico_carpark"></span>
					주차장
				</li>
			</ul>
		</div>
	</body>
	
	<script type="text/javascript">
		//지도를 담을 영역의 DOM 레퍼런스
		var container = document.getElementById('map');
		
		//지도를 생성할 때 필요한 기본 옵션
		var options = {
			center: new kakao.maps.LatLng(37.498004414546934, 127.02770621963765), // 필수값
			level: 3
		};
		
		//지도 생성 및 객체 리턴
		var map = new kakao.maps.Map(container, options);
		
		
		// 마커 좌표 배열
		// 커피숍 마커가 표시될 좌표
		var coffeePositions = [
			new kakao.maps.LatLng(37.499590490909185, 127.0263723554437),
			new kakao.maps.LatLng(37.499427948430814, 127.02794423197847),
			new kakao.maps.LatLng(37.498553760499505, 127.02882598822454),
			new kakao.maps.LatLng(37.497625593121384, 127.02935713582038),
			new kakao.maps.LatLng(37.49646391248451, 127.02675574250912),
			new kakao.maps.LatLng(37.49629291770947, 127.02587362608637),
			new kakao.maps.LatLng(37.49754540521486, 127.02546694890695)
		];
		
		// 편의점 마커가 표시될 좌표
		var storePositions = [
			new kakao.maps.LatLng(37.497535461505684, 127.02948149502778),
			new kakao.maps.LatLng(37.49671536281186, 127.03020491448352),
			new kakao.maps.LatLng(37.496201943633714, 127.02959405469642),
			new kakao.maps.LatLng(37.49640072567703, 127.02726459882308),
			new kakao.maps.LatLng(37.49640098874988, 127.02609983175294),
			new kakao.maps.LatLng(37.49932849491523, 127.02935780247945),
			new kakao.maps.LatLng(37.49996818951873, 127.02943721562295)
		];
		
		// 주차장 마커가 표시될 좌표
		var carparkPositions = [
			new kakao.maps.LatLng(37.49966168796031, 127.03007039430118),
			new kakao.maps.LatLng(37.499463762912974, 127.0288828824399),
			new kakao.maps.LatLng(37.49896834100913, 127.02833986892401),
			new kakao.maps.LatLng(37.49893267508434, 127.02673400572665),
			new kakao.maps.LatLng(37.49872543597439, 127.02676785815386),
			new kakao.maps.LatLng(37.49813096097184, 127.02591949495914),
			new kakao.maps.LatLng(37.497680616783086, 127.02518427952202)
		];
		
		var markerImageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png'; // 마커이미지의 주소 (스프라이트 이미지)
		var coffeeMarkers = []; // 커피숍 마커
		var storeMarkers = []; // 편의점 마커
		var carparkMarkers = []; // 주차장 마커
		
		// 마커 생성 및 배열 추가 함수
		createMarkers();
		
		// 지도에 커피숍 마커가 보이도록 설정
		changeMarker('coffee');
		
		// 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성
		function createMarkerImage(src, size, options) {
			var markerImage = new kakao.maps.MarkerImage(src, size, options);
			return markerImage;
		}
		
		// 좌표와 마커이미지를 받아 마커를 생성
		function createMarker(position, image) {
			var marker = new kakao.maps.Marker({
				position: position,
				image: image
			});
			
			return marker;
		}
		
		// 마커 생성 및 배열 추가 함수
		function createMarkers() {
			// 커피숍
			for (var i = 0; i < coffeePositions.length; i++) {
				var imageSize = new kakao.maps.Size(22, 26);
				var imageOptions = {
					spriteOrigin: new kakao.maps.Point(10, 0),
					spriteSize: new kakao.maps.Size(36, 98)
				};
				
				// 마커이미지와 마커 생성
				var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions)
				var marker = createMarker(coffeePositions[i], markerImage);
				
				// 생성된 마커를 커피숍 마커 배열에 추가
				coffeeMarkers.push(marker);
			}
			
			// 편의점
			for (var i = 0; i < storePositions.length; i++) {
				var imageSize = new kakao.maps.Size(22, 26);
				var imageOptions = {
					spriteOrigin: new kakao.maps.Point(10, 36),
					spriteSize: new kakao.maps.Size(36, 98)
				};
				
				// 마커이미지와 마커 생성
				var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions);
				var marker = createMarker(storePositions[i], markerImage);
				
				// 생성된 마커를 편의점 마커 배열에 추가
				storeMarkers.push(marker);
			}
			
			// 주차장
			for (var i = 0; i < carparkPositions.length; i++) {
				var imageSize = new kakao.maps.Size(22, 26);
				var imageOptions = {
					spriteOrigin: new kakao.maps.Point(10, 72),
					spriteSize: new kakao.maps.Size(36, 98)
				};
				
				// 마커이미지와 마커 생성
				var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions);
				var marker = createMarker(carparkPositions[i], markerImage);
				
				// 생성된 마커를 주차장 마커 배열에 추가
				carparkMarkers.push(marker);
			}
		}
		
		// 커피숍 마커들의 지도 표시 여부를 설정
		function setMarkers(coffeeMap, storeMap, carparkMap) {
			// 커피숍
			for (var i = 0; i < coffeeMarkers.length; i++) {
				coffeeMarkers[i].setMap(coffeeMap);
			}
			
			// 편의점
			for (var i = 0; i < storeMarkers.length; i++) {
				storeMarkers[i].setMap(storeMap);
			}
			
			// 주차장
			for (var i = 0; i < carparkMarkers.length; i++) {
				carparkMarkers[i].setMap(carparkMap);
			}
		}
		
		// 카테고리 클릭 함수
		function changeMarker(type){
			var coffeeMenu = document.getElementById('coffeeMenu');
			var storeMenu = document.getElementById('storeMenu');
			var carparkMenu = document.getElementById('carparkMenu');
			
			// 커피숍 카테고리
			if (type === 'coffee') {
				// 커피숍 카테고리 활성화 처리
				coffeeMenu.className = 'menu_selected';
				storeMenu.className = '';
				carparkMenu.className = '';
				
				// 커피숍 마커들만 지도에 표시하도록 설정
				setMarkers(map, null, null);
			}
			// 편의점 카테고리
			else if (type === 'store') {
				// 편의점 카테고리 활성화 처리
				coffeeMenu.className = '';
				storeMenu.className = 'menu_selected';
				carparkMenu.className = '';
				
				// 편의점 마커들만 지도에 표시하도록 설정
				setMarkers(null, map, null);
			}
			// 주차장 카테고리
			else if (type === 'carpark') {
				// 주차장 카테고리 활성화 처리
				coffeeMenu.className = '';
				storeMenu.className = '';
				carparkMenu.className = 'menu_selected';
				
				// 주차장 마커들만 지도에 표시하도록 설정
				setMarkers(null, null, map);
			}
		}
	</script>
	
</html>