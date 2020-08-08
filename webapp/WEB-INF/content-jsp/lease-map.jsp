<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/taglib/taglib.jsp"%>
<%-- <%@include file="/WEB-INF/content-jsp/session.jsp"%> --%>
<link rel="stylesheet" href="css/map.css"/>
<div class="lease-map">
	<h2>사용하고자 하는 야적장 부지를 선택해주세요.</h2>
	<table>
		<tr>
			<td class="view_p1"><a href="/content.jsp?body=lease-map&view=p1">울산 본항</a></td>
			<td class="view_p2"><a href="/content.jsp?body=lease-map&view=p2">북신항</a></td>
			<td class="view_p3"><a href="/content.jsp?body=lease-map&view=p3">남신항</a></td>
			<td class="view_p4"><a href="/content.jsp?body=lease-map&view=p4">온산항</a></td>
			<td class="view_p5"><a href="/content.jsp?body=lease-map&view=p5">미포항</a></td>
		</tr>
	</table>
	<div id="map" style="width:100%; height:calc( 100% - 200px );">
		<div id="info">
			<div class="info-addr"></div>
			<span>면적:</span><span class="info-size"></span>㎡&nbsp;&nbsp;&nbsp;
			<span>가격:</span><span class="info-price"></span>원&nbsp;&nbsp;&nbsp;
			<span>상태:</span><span class="info-stat"></span>&nbsp;&nbsp;&nbsp;
		</div>
	</div>
	<form action="" method="post">
		<input type="hidden" name="f_id" id="f_id">
	</form>
</div>

<!-- OpenLayers -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.0.1/build/ol.js"></script>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
	
	// 세자리 콤마
	function numComma(number) {
		var num = (""+number).split(".");
		num[0] = num[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num.join(".");
	}
	
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
			zoom:17,
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
		
		var info = $('#info');
		/* info.tooltip({
		  animation: false,
		  trigger: 'manual'
		}); */
		
		var displayFeatureInfo = function(pixel) {
			info.css({
				left: (pixel[0] + 10) + 'px',
			    top: (pixel[1] - 15) + 'px'
			});
			var feature = map.forEachFeatureAtPixel(pixel, function(feature) {
				return feature;
			});
			if (feature) {
				var st = {"av":"임대 가능","unav":"임대 불가능"};
				info.show();
				info.find(".info-addr").text(feature.get("FIELD_ADDRESS"));
				info.find(".info-size").text(numComma(feature.get("FIELD_SIZE")));
				info.find(".info-price").text(numComma(feature.get("FIELD_PRICE")));
				info.find(".info-stat").text(st[feature.get("FIELD_STATUS")]);
				
				
			} else {
				info.hide();
			}
		};
		
		map.on('pointermove', function(evt) {
			if (evt.dragging) {
			    /* info.tooltip('hide'); */
			    return;
			}
			displayFeatureInfo(map.getEventPixel(evt.originalEvent));
		});
		
		$.post("/getData.jsp",{type:"field-list"},function(data){
			var list = JSON.parse(data);
/* 			console.log(list[0].FIELD_ID);
			console.log(list[0].FIELD_PO01);
			console.log(list[2].FIELD_PO01); */
			// for (var i=1; i<11; i++) if (list[0]["GP"+i]) polygon.draw(x1,y1);
			for(var i=0;i<list.length;i++){
				var d=list[i];
				var coordinates = [d.FIELD_PO01.split(","),d.FIELD_PO02.split(","),d.FIELD_PO03.split(","),d.FIELD_PO04.split(",")];
				d["geometry"] = new ol.geom.Polygon([coordinates]);
				var polygon_feature = new ol.Feature(d);
				if(d.FIELD_STATUS=="av"){
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
				}else{
					var style = new ol.style.Style({
						stroke:new ol.style.Stroke({
							color:[0,0,0,.3],
							width:3
						}),
						fill:new ol.style.Fill({
							color:[173, 95, 95,.7]
						}),
						text:new ol.style.Text({
						    text: d.FIELD_NAME,
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
				}
			}
		});	
		/* 
		
		
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
		}); */
		window["map"] = map;
		
		if (window["gLogin"]){
			map.on("click",function(e){
				var pixel = map.getEventPixel(e.originalEvent);
				var feature = map.forEachFeatureAtPixel(pixel, function(feature) {
					return feature;
				});
				if (feature) {
					if(feature.get("FIELD_STATUS")=='unav'){
						alert("["+feature.get("FIELD_NAME")+"] 부지는 이미 임대 중입니다. 다른 부지를 선택해주세요.");
						return;
					}
					if (!confirm("["+feature.get("FIELD_NAME")+"] 부지를 임대 신청하겠습니까?")) return;
					window.location = "/content.jsp?body=lease-application&user_id=user1&field_id="+feature.get("FIELD_ID");

				}
			});
		}
	});
</script>

<script type="text/javascript">
	$(function() {
	
		// 울산 본항
		if ("${param.view}"=="p1" || !"${param.view}"){
			$("td.view_p1").addClass("active");
			let center = [14402938.449273264,4233782.628832038];
			map.getView().setCenter(center);
			map.getView().setRotation(1.55);
		}
		// 북신항
		else if("${param.view}"=="p2"){
			$("td.view_p2").addClass("active");
			let center = [14401479.925381534,4226636.094223501];
			map.getView().setCenter(center);
			map.getView().setRotation(1.1);
		}
		// 남신항
		else if("${param.view}"=="p3"){
			$("td.view_p3").addClass("active");
			let center = [14401249.620724853,4222953.817380765];
			map.getView().setCenter(center);
		}
		// 온산항
		else if("${param.view}"=="p4"){
			$("td.view_p4").addClass("active");
			let center = [14399471.56940605,4223697.625168329];
			map.getView().setCenter(center);
		}
		// 미포항
		else if("${param.view}"=="p5"){
			$("td.view_p5").addClass("active");
			let center = [14410063.801042907,4235212.088193253];
			map.getView().setCenter(center);
		}
		
/* 		$.post("/getData.jsp",{type:"field-list"},function(data){
			var list = JSON.parse(data);
			console.log(list[0].FIELD_ID);
			//for (var i=1; i<11; i++) if (list[0]["GP"+i]) polygon.draw(x1,y1);
		}); */
		
	});
</script>
