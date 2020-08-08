<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
    .info-h2{
        display: block;
        margin: 50px auto;
        text-align: center;
        /*font-size: 22px;*/
        color: rgba(25, 17, 68, 0.904);
        border: #94c8b1 1px dotted;
        border-left: hsl(226, 83%, 47%) 10px solid;
        padding: 10px 20px;
        margin-bottom: 0;
        /*box-shadow: 3px 5px 5px 1px rgba(0,0,0,0.2);*/
        ::-webkit-scrollbar {

display:none;

} 
    }
    img{
        display: block;
        margin: 70px auto;
    }
    .text{
        margin: 30px auto;
        text-align: center;
        font-size: 18px;
    }  
</style>   
<h1>서비스 개요</h1>
<div>
	<h2 class="info-h2">서비스 소개</h2>
	<div class="text">
		<p>
			<strong>야적장?</strong> 항만을 이용하는 화물을 선적하기 전 또는 밖으로 반출하기 전 일정 기간 동안 보관하는 별도의 구조물이 없는 옥외의 화물 장치장을 말한다.
		</p>
		<p>
			항만법 제30조 제1항에 의거하여 항만시설(야적장, 항만부지, 항만건물 등)을 사용하려는 경우에는
			항만법 시행령 제26조에서 정하는 신청서에 따라 최소 5일 전에 관리청에 제출하면 5일 만에 허가를 받아 사용 가능하다.
		</p>
		<p>            
			본 서비스는 실제 야적장 부지를 지도로 시각화하여 손쉽고, 간편하게 야적장을 임대관리 할 수 있게 한다.
		</p>
	</div>
	    <!--
	    <div class="text">
	        <p>
	            <strong>서비스 장점 및 특징</strong>
	        </p>
	        <p>
	            
	        </p>
	    </div> -->
	<h2 class="info-h2">서비스 구성</h2>
	<div>
		<img src="${pageContext.request.contextPath }/images/system.PNG">
	</div>
</div>
<script type="text/javascript">
	//$(".body-frame").addClass("no-sub");
	$(".body-frame .side h2").text("서비스 소개"); // 서브 메뉴 제목을 변경
	$(".body-frame .side ul>li").remove(); // 서브메뉴 하위 모두 삭제
	$("<li></li>").text("서비스 개요").addClass("active").appendTo(".body-frame .side ul"); // 첫번째 서버 하위메뉴 등록
	$("<li></li>").text("신청 안내").appendTo(".body-frame .side ul"); // 첫번째 서버 하위메뉴 등록
	$(".body-frame, .body").css({height:"auto","min-height":"auto"})
</script>