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
			.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
			.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
			.map_wrap {position:relative;width:100%;height:500px;}
			#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:350px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
			.bg_white {background:#fff;}
			#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
			#menu_wrap .option{text-align: center;}
			#menu_wrap .option p {margin:10px 0;}  
			#menu_wrap .option button {margin-left:5px;}
			#placesList li {list-style: none;}
			#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
			#placesList .item span {display: block;margin-top:4px;}
			#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
			#placesList .item .info{padding:10px 0 10px 55px;}
			#placesList .info .gray {color:#8a8a8a;}
			#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
			#placesList .info .tel {color:#009900;}
			#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
			#placesList .item .marker_1 {background-position: 0 -10px;}
			#placesList .item .marker_2 {background-position: 0 -56px;}
			#placesList .item .marker_3 {background-position: 0 -102px}
			#placesList .item .marker_4 {background-position: 0 -148px;}
			#placesList .item .marker_5 {background-position: 0 -194px;}
			#placesList .item .marker_6 {background-position: 0 -240px;}
			#placesList .item .marker_7 {background-position: 0 -286px;}
			#placesList .item .marker_8 {background-position: 0 -332px;}
			#placesList .item .marker_9 {background-position: 0 -378px;}
			#placesList .item .marker_10 {background-position: 0 -423px;}
			#placesList .item .marker_11 {background-position: 0 -470px;}
			#placesList .item .marker_12 {background-position: 0 -516px;}
			#placesList .item .marker_13 {background-position: 0 -562px;}
			#placesList .item .marker_14 {background-position: 0 -608px;}
			#placesList .item .marker_15 {background-position: 0 -654px;}
			#pagination {margin:10px auto;text-align: center;}
			#pagination a {display:inline-block;margin-right:10px;}
			#pagination .on {font-weight: bold; cursor: default;color:#777;}
		</style>
	</head>
	<body>
		<h3>Place</h3>
		<div id="map" style="width:100%;height:800px;"></div>
		
		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
						키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
						<button type="submit">검색하기</button> 
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
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
		// 키워드로 장소 검색
		// 마커 클릭 시 장소명을 표출할 인포윈도우
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 장소 검색 객체 생성
		var ps = new kakao.maps.services.Places();
		ps.keywordSearch('이태원 맛집', placesSearchCB);
		
		// 키워드 검색 완료 콜백함수
		function placesSearchCB (data, status, pagination) {
			if (status == kakao.maps.services.Status.OK) {
				// LatLngBounds 객체에 좌표 추가
				var bounds = new kakao.maps.LatLngBounds();
				
				for (var i=0; i<data.length; i++) {
					displayMarker(data[i]);
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}
				
				// 검색된 장소 위치를 기준으로 지도 범위 재설정
				map.setBounds(bounds);
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
		
		// 키워드로 장소검색 후 목록 표출
		// 마커를 클릭 시 장소명을 표출할 인포윈도우
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 장소 검색 객체 생성
		var ps = new kakao.maps.services.Places();
		
		// 마커 담을 배열
		var markers = [];
		
		// 키워드로 장소를 검색
		searchPlaces();
		
		// 키워드 검색을 요청하는 함수
		function searchPlaces() {
			var keyword = document.getElementById('keyword').value;
			
			if(!keyword.replace(/^\s+|\s+$/g, '')) {
				alert('키워드를 입력해주세요!');
				return false;
			}
			
			// 키워드로 장소검색 요청
			ps.keywordSearch(keyword, placesSearchCB);
		}
		
		// 장소검색 완료 콜백함수
		function placesSearchCB(data, status, pagination) {
			if (status == kakao.maps.services.Status.OK) {
				// 검색 목록과 마커 표출
				displayPlaces(data);
				
				// 페이지 번호 표출
				displayPagination(pagination);
			}
			else if (status == kakao.maps.services.Status.ZERO_RESULT) {
				alert('검색 결과가 존재하지 않습니다.'); return;
			}
			else if (status == kakao.maps.services.Status.ERROR) {
				alert('검색 결과 중 오류가 발생했습니다.'); return;
			}
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수
		function displayPlaces(data) {
			var listEl = document.getElementById('placesList'), 
				menuEl = document.getElementById('menu_wrap'), 
				fragment = document.createDocumentFragment(), // DOM 노드
				bounds = new kakao.maps.LatLngBounds();
			
			// 검색 결과 목록 데이터 및 마커 제거
			removeAllChildNods(listEl);
			removeMarker();
			
			for(var i=0; i<data.length; i++) {
				// 마커 생성
				var placePosition = new kakao.maps.LatLng(data[i].y, data[i].x), 
					marker = addMarker(placePosition, i), 
					itemEl = getListItem(i, data[i]); // 검색 결과 항목 Element를 생성
				
				// LatLngBounds 객체에 좌표 추가
				bounds.extend(placePosition);
				
				// 마커와 검색결과 항목에 대한 이벤트 등록
				(function(marker, title) {
					// mouseover 이벤트 : 장소에 인포윈도우에 장소명을 표시
					kakao.maps.event.addListener(marker, 'mouseover', function() {
						displayInfowindow(marker, title);
					});
					
					// mouseout 이벤트 : 인포윈도우 닫기
					kakao.maps.event.addListener(marker, 'mouseout', function() {
						infowindow.close();
					});
					
					itemEl.onmouseover =  function () {
						displayInfowindow(marker, title);
					};
					
					itemEl.onmouseout =  function () {
						infowindow.close();
					};
				})(marker, data[i].place_name);
				
				fragment.appendChild(itemEl);
			}
			
			// 검색결과 항목들을 검색결과 목록 Element에 추가
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;
			
			// 검색된 장소 위치를 기준으로 지도 범위를 재설정
			map.setBounds(bounds);
		}
		
		// 검색결과 항목을 Element로 반환하는 함수
		function getListItem(index, data) {
			var el = document.createElement('li');
			
			var itemStr  = '<span class="markerbg marker_' + (index+1) + '"></span>';
				itemStr += '<div class="info">';
				itemStr += '	<h5>' + data.place_name + '</h5>';
			
			if (data.road_address_name) {
				itemStr += '	<span>' + data.road_address_name + '</span>';
				itemStr += '	<span class="jibun gray">' + data.address_name  + '</span>';
			} else {
				itemStr += '	<span>' +  data.address_name + '</span>';
			}
			
				itemStr += '	<span class="tel">' + data.phone + '</span>';
				itemStr += '</div>';
			
			el.innerHTML = itemStr;
			el.className = 'item';
			
			return el;
		}
		
		// 마커를 생성하는 함수
		function addMarker(position, idx, title) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지
				imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
				imgOptions = {
					spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
					spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표 (이미지 1~15 매칭)
					offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
				};
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				marker = new kakao.maps.Marker({
					position: position,
					image: markerImage
				});
			
			marker.setMap(map); // 마커 표출
			markers.push(marker); // 배열에 생성된 마커 추가
			
			return marker;
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거
		function removeMarker() {
			for(var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}
		
		// 검색결과 목록 하단에 페이지번호를 표시는 함수
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'),
				fragment = document.createDocumentFragment();
			
			// 기존에 추가된 페이지번호 삭제
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild (paginationEl.lastChild);
			}
			
			for (var i=1; i<=pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;
				
				if (i == pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						}
					})(i);
				}
				
				fragment.appendChild(el);
			}
			
			paginationEl.appendChild(fragment);
		}
		
		// 인포윈도우에 장소명을 표시하는 함수
		function displayInfowindow(marker, title) {
			var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
			
			infowindow.setContent(content);
			infowindow.open(map, marker);
		}
		
		// 검색결과 목록의 자식 Element를 제거하는 함수
		function removeAllChildNods(el) {
			while (el.hasChildNodes()) {
				el.removeChild (el.lastChild);
			}
		}
	</script>
	
</html>