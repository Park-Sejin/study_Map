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
			.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
			.map_wrap {position:relative;width:100%;height:350px;}
			#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
			#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
			#category li.on {background: #eee;}
			#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
			#category li:last-child{margin-right:0;border-right:0;}
			#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
			#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
			#category li .bank {background-position: -10px 0;}
			#category li .mart {background-position: -10px -36px;}
			#category li .pharmacy {background-position: -10px -72px;}
			#category li .oil {background-position: -10px -108px;}
			#category li .cafe {background-position: -10px -144px;}
			#category li .store {background-position: -10px -180px;}
			#category li.on .category_bg {background-position-x:-46px;}
			.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
			.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
			.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
			.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
			.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
			.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
			.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
			.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
			.placeinfo .tel {color:#0f7833;}
			.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
		</style>
	</head>
	<body>
		<h3>Place</h3>
		
		<p style="margin-top:-12px">
			<em class="link">
				<a href="https://apis.map.kakao.com/web/documentation/#CategoryCode" target="_blank">카테고리 코드목록을 보시려면 여기를 클릭하세요!</a>
			</em>
		</p>
		<div class="map_wrap">
			<div id="map" style="width:100%;height:800px;position:relative;overflow:hidden;"></div>
			<ul id="category">
				<li id="BK9" data-order="0">
					<span class="category_bg bank"></span>
					은행
				</li>
				<li id="MT1" data-order="1">
					<span class="category_bg mart"></span>
					마트
				</li>
				<li id="PM9" data-order="2">
					<span class="category_bg pharmacy"></span>
					약국
				</li>
				<li id="OL7" data-order="3">
					<span class="category_bg oil"></span>
					주유소
				</li>
				<li id="CE7" data-order="4">
					<span class="category_bg cafe"></span>
					카페
				</li>
				<li id="CS2" data-order="5">
					<span class="category_bg store"></span>
					편의점
				</li>
			</ul>
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
		
		/* 
		// 카테고리로 장소 검색
		// 마커 클릭 시 장소명을 표출할 인포윈도우
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 장소 검색 객체 생성
		var ps = new kakao.maps.services.Places(map);
		ps.categorySearch('BK9', placesSearchCallBack, {useMapBounds:true}); // 은행
		
		// 키워드 검색 완료 콜백함수
		function placesSearchCallBack(data, status, pagination) {
			if (status == kakao.maps.services.Status.OK) {
				for (var i=0; i<data.length; i++) {
					displayMarker(data[i]);
				}
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
		 */
		
		// 카테고리로 장소검색 후 마커 표출
		// 마커 클릭 시 장소의 상세정보를 표출할 커스텀오버레이 및 엘리먼트
		var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1});
		var contentNode = document.createElement('div');
		
		// 커스텀 오버레이에 css class 추가 및 컨텐츠 설정
		contentNode.className = 'placeinfo_wrap';
		placeOverlay.setContent(contentNode);
		
		// 마커 담을 배열
		var markers = [];
		
		// 현재 선택된 카테고리
		var currCategory = '';
		
		// 장소 검색 객체 생성
		var ps = new kakao.maps.services.Places(map); 
		
		// 커스텀 오버레이에 mousedown, touchstart 이벤트가 발생했을 때, 지도 객체에 이벤트가 전달되지 않도록 함
		addEventHandle(contentNode, 'mousedown');
		addEventHandle(contentNode, 'touchstart');
		
		// 각 카테고리에 클릭 이벤트 등록
		addCategoryClickEvent();
		
		// 지도에 idle 이벤트 등록 ( 중심 좌표나 확대 수준이 변경되면 발생함 )
		kakao.maps.event.addListener(map, 'idle', searchPlaces);
		
		// 카테고리 검색을 요청하는 함수
		function searchPlaces() {
			if (!currCategory) {
				return;
			}
			
			// 커스텀 오버레이를 숨김
			placeOverlay.setMap(null);
			
			// 마커 제거
			removeMarker();
			
			ps.categorySearch(currCategory, placesSearchCallBack, {useMapBounds:true});
		}
		
		// 장소검색 완료 콜백함수
		function placesSearchCallBack(data, status, pagination) {
			// 정상 검색
			if (status == kakao.maps.services.Status.OK) {
				// 마커 표시
				displayPlaces(data);
			}
			// 검색결과가 없는경우
			else if (status == kakao.maps.services.Status.ZERO_RESULT) {
				
			}
			// 에러
			else if (status == kakao.maps.services.Status.ERROR) {
				
			}
		}
		
		// 마커 표시하는 함수
		function displayPlaces(places) {
			// 선택된 카테코리 순번 ( 스프라이트 이미지에서의 위치를 계산하는데 사용 )
			var order = document.getElementById(currCategory).getAttribute('data-order');
			
			for (var i=0; i<places.length; i++) {
				// 마커 생성
				var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
				
				// 마커 클릭 이벤트 ( 장소정보 표출 )
				(function(marker, place) {
					kakao.maps.event.addListener(marker, 'click', function() {
						displayPlaceInfo(place);
					});
				})(marker, places[i]);
			}
		}
		
		// 마커 생성 함수
		function addMarker(position, order) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url ( 스프라이트 이미지 )
				imageSize = new kakao.maps.Size(27, 28), // 마커 이미지 크기
				imgOptions =  {
					spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지 크기
					spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
				},
				markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
					marker = new kakao.maps.Marker({
					position: position, // 마커 위치
					image: markerImage
				});
			
			marker.setMap(map); // 마커를 표시
			markers.push(marker); // 배열에 마커 추가
			
			return marker;
		}
		
		// 지도 위 마커 모두 제거
		function removeMarker() {
			for(var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}
		
		// 클릭한 마커 장소의 상세정보를 커스텀 오버레이로 표시하는 함수
		function displayPlaceInfo(place) {
			var content  = '<div class="placeinfo">';
				content += '	<a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';
			
			if (place.road_address_name) {
				content += '	<span title="' + place.road_address_name + '">' + place.road_address_name + '</span>';
				content += '	<span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
			}
			else {
				content += '	<span title="' + place.address_name + '">' + place.address_name + '</span>';
			}
			
				content += '	<span class="tel">' + place.phone + '</span>';
				content += '</div>';
				content += '<div class="after"></div>';
			
			contentNode.innerHTML = content;
			placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
			placeOverlay.setMap(map);  
		}
		
		// 엘리먼트에 이벤트 핸들러로 kakao.maps.event.preventMap 이벤트 등록하는 함수
		function addEventHandle(target, type) {
			if (target.addEventListener) {
				target.addEventListener(type, kakao.maps.event.preventMap);
			} else {
				target.attachEvent('on' + type, kakao.maps.event.preventMap);
			}
		}
		
		// 각 카테고리에 클릭 이벤트 등록하는 함수
		function addCategoryClickEvent() {
			var category = document.getElementById('category'),
				children = category.children;
			
			for(var i=0; i<children.length; i++) {
				children[i].onclick = onClickCategory;
			}
		}
		
		// 카테고리를 클릭했을 때 호출되는 함수
		function onClickCategory() {
			var id = this.id;
			var className = this.className;
			
			placeOverlay.setMap(null);
			
			if (className == 'on') {
				currCategory = '';
				changeCategoryClass();
				removeMarker();
			} else {
				currCategory = id;
				changeCategoryClass(this);
				searchPlaces();
			}
		}
		
		// 클릭된 카테고리에 스타일을 적용하는 함수
		function changeCategoryClass(el) {
			var category = document.getElementById('category')
			var children = category.children;
			
			for (var i=0; i<children.length; i++) {
				children[i].className = '';
			}
			
			if (el) {
				el.className = 'on';
			}
		}
	</script>
	
</html>