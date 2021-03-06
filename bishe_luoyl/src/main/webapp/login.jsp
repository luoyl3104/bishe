<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8"%>
<c:set value="${pageContext.request.contextPath}" var="app"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
	<script src="${app}/statics/boot/js/jquery-3.3.1.min.js"></script>
<STYLE>
body{
	background: #ebebeb;
	font-family: "Helvetica Neue","Hiragino Sans GB","Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
	color: #222;
	font-size: 12px;
}
*{padding: 0px;margin: 0px;}
.top_div{
	background: #008ead;
	width: 100%;
	height: 400px;
}
.ipt{
	border: 1px solid #d3d3d3;
	padding: 10px 10px;
	width: 290px;
	border-radius: 4px;
	padding-left: 35px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	-webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
}
.ipt:focus{
	border-color: #66afe9;
	outline: 0;
	-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
	box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
}
.u_logo{
	background: url("${app}/statics/images/username.png") no-repeat;
	padding: 10px 10px;
	position: absolute;
	top: 43px;
	left: 40px;

}
.p_logo{
	background: url("${app}/statics/images/password.png") no-repeat;
	padding: 10px 10px;
	position: absolute;
	top: 12px;
	left: 40px;
}
a{
	text-decoration: none;
}
.tou{
	background: url("${app}/statics/images/tou.png") no-repeat;
	width: 97px;
	height: 92px;
	position: absolute;
	top: -87px;
	left: 140px;
}
.left_hand{
	background: url("${app}/statics/images/left_hand.png") no-repeat;
	width: 32px;
	height: 37px;
	position: absolute;
	top: -38px;
	left: 150px;
}
.right_hand{
	background: url("${app}/statics/images/right_hand.png") no-repeat;
	width: 32px;
	height: 37px;
	position: absolute;
	top: -38px;
	right: -64px;
}
.initial_left_hand{
	background: url("${app}/statics/images/hand.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -12px;
	left: 100px;
}
.initial_right_hand{
	background: url("${app}/statics/images/hand.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -12px;
	right: -112px;
}
.left_handing{
	background: url("${app}/statics/images/left-handing.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -24px;
	left: 139px;
}
.right_handinging{
	background: url("${app}/statics/images/right_handing.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -21px;
	left: 210px;
}

</STYLE>
     
<SCRIPT type="text/javascript">

	function login() {
        var username = $("#username").val();
        var password = $("#password").val();
        if(username==null||username==""){
            $("#error").html("用户名不能为空！");
            return false;
        }
        if(password==null||password==""){
            $("#error").html("密码不能为空！");
            return false;
        }
        $.post("${app}/user/login",{username:username,password:password},function (result) {
            if(result.message == "login success"){
                window.location.href="${app}/main.jsp";
            }else {
                $("#error").text(result.message);
            }
        })
    }

</SCRIPT>
</head>
<body>
<DIV class="top_div">
</DIV>
<form action="" method="post" >
	<DIV style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 280px; text-align: center;">
		<DIV style="width: 165px; height: 96px; position: absolute;">
			<DIV class="tou">
			</DIV>
			<DIV class="initial_left_hand" id="left_hand">
			</DIV>
			<DIV class="initial_right_hand" id="right_hand">
			</DIV>
		</DIV>
		<P style="padding: 30px 0px 10px; position: relative;">
			<SPAN class="u_logo"></SPAN>
			<INPUT id="username" name="username" class="ipt" type="text" placeholder="请输入用户名" value="${blogger.userName }">
	    </P>
		<P style="position: relative;">
			<SPAN class="p_logo"></SPAN>         
			<INPUT id="password" name="password" class="ipt"  type="password" placeholder="请输入密码" value="${blogger.password }">   
	  	</P>
		<div style="height: 10px">
			<span color="red" id="error"></span>
		</div>
		<DIV style="height: 20px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
			<P style="margin: 0px 35px 20px 45px;">
				<SPAN style="float: left;">景点信息交流系统</SPAN>
	        	<SPAN style="float: right;">
					<a href="javascript:login()" class="btn-primary" style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;width: 30px">&nbsp;登录&nbsp;</a>
				</SPAN>
			</P>
	    </DIV>
		<DIV style="height: 40px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">

			<P style="margin: 0px 35px 20px 45px;">
				<SPAN style="float: left;">您还不是本网站用户？</SPAN>
				<SPAN style="float: right;">
					<a href="${app}/register.jsp" class="btn-primary" style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;width: 30px">&nbsp;注册&nbsp;</a>
				</SPAN>
			</P>

		</DIV>

	</DIV>
</form>
<div style="text-align:center;padding-top: 30px">
	zzu.luoyulong © 2019  3104651846@qq.com
</div>
</body>
</html>