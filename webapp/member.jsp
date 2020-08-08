<!-- 회원가입 폼  -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.gbhz.DB"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
	<title>회원가입-야적장임대마스터</title>
	<meta charset="UTF-8"/>
	<link rel="stylesheet" type="text/css" href="css/member.css"/>
	
	<script type="text/javascript">
		function openwindow(theURL, winName, features){
			form = document.userInfo;
			if(winName == "id_check"){
				if(!callBack(form.id, 6, 12)){
					return;
				}
				theURL = theURL + "?id=" + form.id.value;
			}
			window.open(theURL, winName, features);
		}
		
		function callBack(target, lmin, lmax){
			var Alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
			var Digit = '1234567890'
			var astr = Alpha + Digit;
			var i;
			var tValue = target.value;
			if(tValue.length<lmin || tValue.length>lmax){
				if(lmin==lmax){ alert('아이디는 ' + lmin + '글자 이상이어야 합니다.'); }
				else alert('아이디는 ' + lmin + '~' + lmax + '글자 이내로 입력하셔야 합니다.');
				target.focus();
				return false;
			}	
			if(astr.length > 1){
				for(i=0; i<tValue.length; i++){
					if(astr.indexOf(tValue.substring(i, i+1)) < 0){
						alert('아이디에 허용할 수 없는 문자가 입력되었습니다.');
						target.focus();
						return false;
					}
				}
			}
			return true;
		} 
	
		function checkValue(){
			if(document.userInfo.id.value==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(!document.userInfo.pwd.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(document.userInfo.pwd.value != document.userInfo.pwdCheck.value){
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}
			/* if(!callBack(form.pwd, 4, 12)){
				return;
			} */
			if(!document.userInfo.sname.value){
				alert("담당자 이름을 입력하세요.");
				return false;
			}
			if(!document.userInfo.phone.value){
				alert("담당자 연락처를 입력하세요.");
				return false;
			}
			if (document.userInfo.phone.value.indexOf("010") < 0) {
		        alert('번호 형식이 틀립니다. 010을 포함하여 작성해주세요.');
		        document.userInfo.email.focus();
		        return false;
		     }
			if (document.userInfo.phone.value.indexOf("-") < 0) {
		        alert('번호 형식이 틀립니다. -를 포함하여 작성해주세요.');
		        document.userInfo.email.focus();
		        return false;
		     }
			if(!document.userInfo.email.value){
				alert("담당자 이메일을 입력하세요.");
				return false;
			}
			if (document.userInfo.email.value.indexOf("@") < 0) {
		        alert('Email주소 형식이 틀립니다. @포함하여 작성해주세요.');
		        document.userInfo.email.focus();
		        return false;
		      }
		      if (document.userInfo.email.value.indexOf(".") < 0) {
		        alert('Email 도메인 주소가 틀립니다.');
		        document.userInfo.email.focus();
		        return false;
		      }
			if(!document.userInfo.workName.value){
				alert("업체명을 입력하세요.");
				return false;
			}
			if(!document.userInfo.licenseNumber.value){
				alert("사업자 등록번호를 입력하세요.");
				return false;
			}
			if(!document.userInfo.venderAddr.value){
				alert("업체 주소를 입력하세요.");
				return false;
			}
			if(!document.userInfo.workNumber.value){
				alert("업체 전화번호를 입력하세요.");
				return false;
			}
		}
	</script>
	<style type="text/css">
	
	</style>
</head>

<body>
<h1>야적장임대마스터</h1>
    <h2>-회원가입-</h2>
    <h3>기본 정보</h3>
    <form action="join.jsp" method="POST" name="userInfo" onsubmit="return checkValue()">
        <table class="tablef" width="1000px">            
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="id">아이디</label>
                </td>
                <td>
                    <input type="text" name="id" id="id" size="30">
                    <input type="button" id="check" value="중복확인" onClick="openwindow('id_check.jsp', 'id_check', 'width=330, height=200')">
                    (영문+숫자 6~12자리)
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="pwd">비밀번호</label>
                </td>
                <td>
                    <input type="password" name="pwd" id="pwd" size="30"> 
                    <br/>*영문 대소문자/숫자/특수문자를 혼용하여 2종류 6~12자
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="pwdCheck">비밀번호 확인</label>
                </td>
                <td>
                    <input type="password" name="pwdCheck" id="pwdCheck" size="30">
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="sname">담당자 이름</label>
                </td>
                <td>
                    <input type="text" name="sname" id="sname" size="30"> 
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="phone">담당자 연락처</label>
                </td>
                <td>
                    <input type="text" name="phone" id="phone" size="30" minlength="10" maxlength="13">
                	(010포함하여 입력해주세요.)
                </td>
                <!-- <td>
                    <select id="phone">
                        <option value=""></option>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="019">019</option>
                    </select>
                    -
                    <input type="text" name="phone" id="phone" size="4" maxlength="4"> -
                    <input type="text" name="phone" id="phone" size="4" maxlength="4">
                </td> -->
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="email">담당자 이메일</label>
                </td>
                <td>
                    <input type="text" name="email" id="email" size="35">
                </td>
            </tr>
        </table>

<!-----------------------------------------------업체 정보----------------------------------------------------->

    <h3 class="h3add">업체 정보</h3>
        <table class="tablef" width="1000px">
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="workName">업체명</label>
                </td>
                <td>
                    <input type="text" name="workName" id="workName" size="30"> 
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="licenseNumber">사업자 등록번호</label>
                </td>
                <td>
                	<input type="text" name="licenseNumber" id="licenseNumber" size="30" maxlength="25">
                </td>
                <!-- <td>
                    <input type="text" name="licenseNumber" id="licenseNumber" size="3" maxlength="3">
                    <input type="text" name="licenseNumber" id="licenseNumber" size="2" maxlength="2">
                    <input type="text" name="licenseNumber" id="licenseNumber" size="5" maxlength="5">
                </td> -->
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="licenseScan">사업자등록증</label>
                </td>
                <td>
                    <input type="file" name="licenseScan"> 
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="venderAddr">업체주소</label>
                </td>
                <td>
                    <input type="text" name="venderAddr" id="venderAddr" size="45">   
                </td>
            </tr>
            <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="workNumber">업체 전화 번호</label>
                </td>
                <td>
                	<input type="text" name="workNumber" id="workNumber" size="30" maxlength="11">
                </td>
                <!-- <td>
                    <select id="workNumber">
                        <option value=""></option>
                        <option value="031">031</option>
                        <option value="032">032</option>
                        <option value="042">042</option>
                    </select>
                    -
                    <input type="text" name="workNumber" id="workNumber" size="4" maxlength="4">-
                    <input type="text" name="workNumber" id="workNumber" size="4" maxlength="4">
                </td> -->
            </tr>
            <!-- <tr>
                <td bgcolor="#ececec" align="center">
                    <label for="sms">SMS수신</label>
                </td>
                <td>
                    <input type="radio" name="sms" checked>동의합니다.
                    <input type="radio" name="sms">동의하지 않습니다.
                </td>
            </tr> -->
        </table>
        <input type="hidden" name="id_check">
        <input class="btnclick" type="submit" id="join" value="회원가입">
    </form>
</body>
</html>