// test page *-*

$(function() {
	var setting = {
		source:new ol.source.XYZ({
			// Satellite
			url:'http://api.vworld.kr/req/wmts/1.0.0/33584218-1B9F-334B-8F05-1EF1A26B4F27/Satellite/{z}/{y}/{x}.jpeg'
		})
	};
	
	var olLayer = new ol.layer.Tile(setting);
	
	var olView = new ol.View({
		center:ol.proj.transform([129.382946,35.504831],'EPSG:4326','EPSG:3857'),
		zoom:18,
		//minZoom:12,
		maxZoom:19
	});
	
	var source = new ol.source.Vector({wrapX: false});
	
	var vector = new ol.layer.Vector({
	  source: source
	});
	
	var map = new ol.Map({
	    target: 'map',
	    layers: [olLayer,vector],
	    view:olView
	});
	
	var coordinates = [ol.proj.transform([129.371822,35.462871],'EPSG:4326','EPSG:3857'),
						ol.proj.transform([129.373539,35.462346],'EPSG:4326','EPSG:3857'),
						ol.proj.transform([129.371007,35.457382],'EPSG:4326','EPSG:3857'),
						ol.proj.transform([129.369097,35.458003],'EPSG:4326','EPSG:3857')					
	];
	
	// polygon feature 생성
	var polygon_feature = new ol.Feature({
		geometry:new ol.geom.Polygon([coordinates])
	});
	
	// 스타일 설정
	var style = new ol.style.Style({
		stroke:new ol.style.Stroke({
			color:[0,0,0,.3],
			width:3
		}),
		fill:new ol.style.Fill({
			color:[255,255,255,.7]
		}),
		text:new ol.style.Text({
		    text: 'Y5',
		    textAlign: 'center',
		    font: '15px roboto,sans-serif'            
		})
	});
	
	polygon_feature.setStyle(style);
	
	var vector_layer = new ol.layer.Vector({
		source:new ol.source.Vector({
			features:[polygon_feature]
		})
	});
	
	map.addLayer(vector_layer);
	window["map"] = map;
	
	window["draw"] = new ol.interaction.Draw({
	  type: 'Polygon',
	  source: setting.source
	});

	window["snap"] = new ol.interaction.Snap({
	  source: setting.source
	});
});