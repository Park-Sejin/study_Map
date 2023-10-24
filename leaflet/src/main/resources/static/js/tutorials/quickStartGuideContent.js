const quickStartGuide = {
	
	init : function(){
		quickStartGuide.bindEvent();
		
		// 마커 셋팅
		quickStartGuide.setMaker();
	},
	bindEvent: function(){
		$(document).on("click", ".leaflet-marker-icon", function(e){
			let marker = $(this);
			
			console.log(e.getLatLng(), marker)
			
			return;
			var popup = L.popup()
				.setLatLng(e.latlng)
				.setContent("You clicked the map at " + e.latlng.toString())
				.openOn(map);
		})
	},
	setMaker : function(){
		let marker1 = L.marker([37.566535, 126.9779692]).addTo(map);
		let marker2 = L.marker([37.560535, 126.9769692]).addTo(map);
		let marker3 = L.marker([37.569535, 126.9759692]).addTo(map);
		let marker4 = L.marker([37.570535, 126.9749692]).addTo(map);
		let marker5 = L.marker([37.565535, 126.9739692]).addTo(map);
		
		console.log(marker1)
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
};
	
quickStartGuide.init();
