<%@page import="java.util.Map"%>
<%@page import="com.gbhz.UserVO"%>
<%@page import="com.gbhz.DB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	// Map user = (Map)session.getAttribute("user");
	String type = request.getParameter("type");
	if ("save".equals(type)) {
		// 저장버튼이 눌렸을 때
		String FIELD_ID = request.getParameter("f_id");
		String FIELD_NAME = request.getParameter("f_name");
		String FIELD_ADDRESS = request.getParameter("f_addr");
		String FIELD_SIZE = request.getParameter("f_size");
		String FIELD_PRICE = request.getParameter("f_price");
		String FIELD_STATUS = request.getParameter("f_status");
		String FIELD_PO01 = request.getParameter("po1");
		String FIELD_PO02 = request.getParameter("po2");
		String FIELD_PO03 = request.getParameter("po3");
		String FIELD_PO04 = request.getParameter("po4");
		
		String sql = "";
		if (FIELD_ID==null || FIELD_ID.length()<1) {
			// 새로운 야적장 추가
			sql = "insert into TB_FIELD(FIELD_NAME,FIELD_ADDRESS,FIELD_SIZE,FIELD_PRICE,FIELD_PO01,FIELD_PO02,FIELD_PO03,FIELD_PO04,FIELD_STATUS) ";
			sql += "VALUES('@FIELD_NAME@','@FIELD_ADDRESS@','@FIELD_SIZE@','@FIELD_PRICE@','@FIELD_PO01@','@FIELD_PO02@','@FIELD_PO03@','@FIELD_PO04@','@FIELD_STATUS@')";
			sql = sql.replaceAll("@FIELD_NAME@", FIELD_NAME);
			sql = sql.replaceAll("@FIELD_ADDRESS@", FIELD_ADDRESS);
			sql = sql.replaceAll("@FIELD_SIZE@", FIELD_SIZE);
			sql = sql.replaceAll("@FIELD_PRICE@", FIELD_PRICE);
			sql = sql.replaceAll("@FIELD_PO01@", FIELD_PO01);
			sql = sql.replaceAll("@FIELD_PO02@", FIELD_PO02);
			sql = sql.replaceAll("@FIELD_PO03@", FIELD_PO03);
			sql = sql.replaceAll("@FIELD_PO04@", FIELD_PO04);
			sql = sql.replaceAll("@FIELD_STATUS@", FIELD_STATUS);
		} else {
			// 야적장 정보 수정
			sql = "update TB_FIELD SET FIELD_NAME='@FIELD_NAME@',FIELD_ADDRESS='@FIELD_ADDRESS@',FIELD_SIZE='@FIELD_SIZE@',FIELD_PRICE='@FIELD_PRICE@' WHERE FIELD_ID='"+FIELD_ID+"'";
			sql = sql.replaceAll("@FIELD_NAME@", FIELD_NAME);
			sql = sql.replaceAll("@FIELD_ADDRESS@", FIELD_ADDRESS);
			sql = sql.replaceAll("@FIELD_SIZE@", FIELD_SIZE);
			sql = sql.replaceAll("@FIELD_PRICE@", FIELD_PRICE);
		}
		if (sql.length()>0) DB.update(sql);
	} else if ("delete".equals(type)) {
		// 삭제버튼이 눌렸을 때
		String FIELD_ID = request.getParameter("f_id");
		String sql = "delete from TB_FIELD WHERE FIELD_ID='"+FIELD_ID+"'";
		DB.update(sql);
	}

%><div class="register-view lease-map">
	<h2>야적장 부지 관리</h2>
	<h4>야적장 추가 버튼을 눌러 새로운 야적장을 추가할 수 있습니다.</h4>
	<table>
		<tr>
			<td class="view_p1"><a href="/content.jsp?body=register-field&view=p1">울산 본항</a></td>
			<td class="view_p2"><a href="/content.jsp?body=register-field&view=p2">북신항</a></td>
			<td class="view_p3"><a href="/content.jsp?body=register-field&view=p3">남신항</a></td>
			<td class="view_p4"><a href="/content.jsp?body=register-field&view=p4">온산항</a></td>
			<td class="view_p5"><a href="/content.jsp?body=register-field&view=p5">미포항</a></td>
		</tr>
	</table>
	
	<div id="map">
		<!-- 지도 표시 -->
	</div>
	<div class="register-form">
		<!-- 등록 정보 -->
		<form action="" method="post" id="registerLocation">
			<input type="hidden" id="type" name="type"> <!-- 저장 버튼 또는 삭제 버튼이 눌렸는지 여부 -->
			<input type="hidden" id="f_id" name="f_id"> <!-- FIELD_ID -->
			<table>
				<tr>
					<th>야적장 이름</th><td><input type="text" name="f_name" id="f_name"></td>
				</tr>
				<tr>
					<th>야적장 위치</th><td><input type="text" name="f_addr" id="f_addr"></td>
				</tr>
				<tr>
					<th>면적</th><td><input type="text" name="f_size" id="f_size" onchange="calCost();"></td>
				</tr>
				<tr>
					<th>금액</th><td><input type="text" name="f_price" id="f_price"></td>
				</tr>
				<tr>
					<th>좌표1</th><td><input type="text" id="po1" name="po1" readonly="readonly" value="0,0"></td>
				</tr>
				<tr>
					<th>좌표2</th><td><input type="text" id="po2" name="po2" readonly="readonly" value="0,0"></td>
				</tr>
				<tr>
					<th>좌표3</th><td><input type="text" id="po3" name="po3" readonly="readonly" value="0,0"></td>
				</tr>
				<tr>
					<th>좌표4</th><td><input type="text" id="po4" name="po4" readonly="readonly" value="0,0"></td>
				</tr>
				<tr>
					<th>임대 가능 여부</th>
					<td>
						<input type="radio" id="f_stat1" name="f_status" value="av" checked>가능
						<input type="radio" id="f_stat2" name="f_status" value="unav" style="margin-left: 1.5em;">불가능
					</td>
				</tr>
			</table>
			<div class="buttons">
				<input type="button" value="야적장 추가" class="blue-button add-button" onclick="addBtn();">
				<input type="button" value="저장" class="blue-button save-button" onclick="saveBtn();" style="display:none;">
				<input type="button" value="삭제" class="blue-button delete-button" onclick="deleteBtn()" style="display:none;">
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(".body-frame").addClass("no-sub");
</script>

<!-- OpenLayers -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.0.1/build/ol.js"></script>
<script type="text/javascript">
	// 세자리 콤마
	function numComma(number) {
		var num = (""+number).split(".");
		num[0] = num[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num.join(".");
	}

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
			}else{
				var style = new ol.style.Style({
					stroke:new ol.style.Stroke({
						color:[0,0,0,.3],
						width:3
					}),
					fill:new ol.style.Fill({
						color:[173,95,95,.7]
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
	
</script>

<!-- 클릭해서 폴리곤 그리기 -->
<script type="text/javascript">
	var draw = new ol.interaction.Draw({
		type: 'Polygon',
		source: source,
	});
	
	var snap = new ol.interaction.Snap({
		source: source
	});

	// 면적에 따른 금액 계산
	function calCost(){
		var cost = $("#f_size").val()*420;
		var reg = $(".register-form");
		reg.find("#f_price").val(cost);
	}
	
    // 그리기 모드 값을 갖는 변수
    var drawMode = false;
    function addBtn(){
 		$("#f_stat1").trigger("click"); // 가능 체크
    	drawMode = !drawMode;
    	if (drawMode) {
    		//
    		
        	// 클릭한 위치의 좌표 얻기
           	map.on("click",function(e){
           		var pixel = map.getEventPixel(e.originalEvent);
        		var feature = map.forEachFeatureAtPixel(pixel, function(feature) {
        			return feature;
        		});
           	});
        		
       		// 폴리곤 그리고 snap
       		map.addInteraction(draw);
       	    map.addInteraction(snap);
       	    
    	   	draw.on("drawend" , function(e) {
    	 		var coordinates = e.feature.get("geometry").getCoordinates(); //[ [[x1,y1],[x2,y2],.....] ]
    	 		var coordinate = coordinates[0];
    	 		for (var i=0; i<coordinate.length; i++) {
    	 			$("#po"+(i+1)).val(coordinate[i]);
    	 		}
    	 		e.feature.set("FIELD_STATUS", "av");
    	 		console.log("drawend");
    	 	    map.removeInteraction(draw);
    	 	    map.removeInteraction(snap);
    	 	});
        } else {
        	// 야적장 등록 버튼 비활성화(된 것처럼 색깔 바꾸기)
        }
	}
    
    // 변경된 feature 저장하는 함수
    function saveBtn() {
    	var form = $("#registerLocation"); // form을 가져옴
		if (!form.find("#f_name").val()) {
			alert("아적장 이름이 입력되어야 합니다.");
			form.find("#f_name").focus(); // 야적장 이름에 커서 이동
			return;
		}    	
		if (!form.find("#f_addr").val()) {
			alert("아적장 위치가 입력되어야 합니다.");
			form.find("#f_addr").focus(); // 야적장 위치에 커서 이동
			return;
		}    	
		if (!form.find("#f_size").val()) {
			alert("아적장 면적이 입력되어야 합니다.");
			form.find("#f_size").focus(); // 야적장 면적에 커서 이동
			return;
		}    	
		if (!form.find("#f_price").val()) {
			alert("아적장 금액이 입력되어야 합니다.");
			form.find("#f_price").focus(); // 야적장 금액에 커서 이동
			return;
		}    	
    	
    	if (!confirm("저장하시겠습니까 ?")) return;
    	form.find("[name=type]").val("save"); // type을 저장으로 설정
    	form.submit();
    }
    
    // 선택된 feature를 삭제하는 함수
    function deleteBtn(){
    	if (!confirm("선택한 야적장을 삭제하시겠습니까 ?")) return;
    	var form = $("#registerLocation"); // form을 가져옮
		var FIELD_ID = form.find("")
    	form.find("[name=type]").val("delete"); // type을 저장으로 설정
    	form.submit();    	
    }
    
    // 클릭한 위치의 좌표 얻기
   	map.on("click",function(e){
   		var pixel = map.getEventPixel(e.originalEvent);
		var feature = map.forEachFeatureAtPixel(pixel, function(feature) {
			return feature;
		});
		if (feature) {
			// 오른쪽 입력폼 값 표시 ( 명칭, 주소, 좌표, 가격, .....)
			var reg = $(".register-form");
			reg.find("#f_id").val(feature.get("FIELD_ID"));
			reg.find("#f_name").val(feature.get("FIELD_NAME"));
			reg.find("#f_addr").val(feature.get("FIELD_ADDRESS"));
			
			var fieldSize = feature.get("FIELD_SIZE");
			reg.find("#f_size").val(fieldSize ? numComma(fieldSize) : "");

			var fieldPrice = feature.get("FIELD_PRICE");
			reg.find("#f_price").val(fieldPrice ? numComma(fieldPrice) : "");

			// 저장 및 삭제 버튼 보이기
			reg.find(".blue-button.save-button").show();
			reg.find(".blue-button.delete-button").show();
			if(feature.get("FIELD_STATUS")=="av"){
				reg.find("#f_stat1").trigger("click"); // 가능 체크
				// stat2는 체크 해제
			} else{
				reg.find("#f_stat2").trigger("click"); // 불가능 체크
			}
	 		var coordinates = feature.get("geometry").getCoordinates(); //[ [[x1,y1],[x2,y2],.....] ]
	 		var coordinate = coordinates[0];
	 		for (var i=0; i<coordinate.length; i++) {
	 			$("#po"+(i+1)).val(coordinate[i]);
	 		}
		} else {
			// 오른쪽 입력 폼 초기화
			// 저장 버튼 비활성
			//document.getELementById("")
			var reg = $(".register-form");
			reg.find("#f_id").val("");
			reg.find("#f_name").val("");
			reg.find("#f_addr").val("");
			reg.find("#f_size").val("");
			reg.find("#f_price").val("");
	 		for (var i=0; i<4; i++) $("#po"+(i+1)).val("");
			// 저장 및 삭제 버튼 숨기기
			reg.find(".blue-button.save-button").hide();
			reg.find(".blue-button.delete-button").hide();
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

		$.post("/getData.jsp",{type:"field-list"},function(data){
			var list = JSON.parse(data);
			console.log(list[0].FIELD_ID);
			//for (var i=1; i<11; i++) if (list[0]["GP"+i]) polygon.draw(x1,y1);
		});		
	});
</script>