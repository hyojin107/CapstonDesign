<%@page import="com.gbhz.DB"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String lease_form_id = request.getParameter("lease_form_id");

	Map<Object, Object> lease_form = DB.selectDetail("select * from TB_LEASE_FORM WHERE LEASE_FORM_ID = '"+lease_form_id+"'");
	request.setAttribute("lease_form",lease_form);
	
	Map<Object, Object> field = DB.selectDetail("select * from TB_FIELD WHERE FIELD_ID = '"+lease_form.get("FIELD_ID")+"'");
	request.setAttribute("field",field);
%>
<div id="map" style="width:100%;height:50%;">
</div>
<div class="detail">
	<table class="table-type01">
		<tr><th>신청 번호</th><td>${lease_form.LEASE_FORM_ID}</td><th>신청 일자</th><td>${lease_form.DATE}</td></tr>
		<tr><th>주소</th><td colspan="3">${field.FIELD_ADDRESS}</td></tr>
		<tr><th>면적</th><td>${field.FIELD_SIZE}㎡</td><th>금액</th><td>${field.FIELD_PRICE}원</td></tr>
		<tr><th>사용 기간</th><td>${lease_form.START_DATE}~${lease_form.END_DATE}</td><th>사용 목적</th><td>${lease_form.PURPOSE}</td></tr>
		<tr><th>신청 상태</th><td colspan="3">${lease_form.STATUS}</td></tr>
	</table>
	<input type="button" value="목록으로" class="blue-button">
	<input type="button" value="신청 수정" class="blue-button">
	<input type="button" value="신청 취소" class="blue-button">
</div>
<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.0.1/build/ol.js"></script>
<script type="text/javascript">
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
	
	var displayFeatureInfo = function(pixel) {
		info.css({
			left: pixel[0] + 'px',
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
		
		var coordinates = [feature.get("FIELD_PO01"),
			feature.get("FIELD_PO02"),
			feature.get("FIELD_PO03"),
			feature.get("FIELD_PO04"),
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
});
</script>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
</script>