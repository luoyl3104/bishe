<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=utf-8" isELIgnored="false"%>
<c:set value="${pageContext.request.contextPath}" var="app"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>注册中心</title>
		<link href="${pageContext.request.contextPath }/front/css/login.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath }/front/css/page_bottom.css" rel="stylesheet" type="text/css" />
		<script src="${pageContext.request.contextPath }/statics/boot/js/jquery-3.3.1.min.js"></script>
		<script type="text/javascript">
			$(function(){
                //异步提交
                $("#submit").click(function () {

                    var a = 0;
                    //密码验证
                    var password=$("#pwd").val();
                    var password1=/^[A-Za-z0-9]{6,20}/;
                    if(password.length==0){
                        $("#error2").html("密码不可以为空");
                        a++;
                    }else if(!password1.test(password)){
                        $("#error2").html("请按要求输入6-20位的密码");
                        a++;
                    }else{
                        $("#error2").html("输入正确");
                    }
                    //昵称验证
                    var name=$("#username").val();
                    var name1 = /^[a-z0-9\u4e00-\u9fa5]{4,20}/;
                    if(name.length==0){
                        $("#error3").html("用户名不可以为空");
                        a++;
                    }else if(!name1.test(name)){
                        $("#error3").html("请按要求输入4~20位的昵称");
                        a++;
                    }else{
                        $("#error3").html("输入正确");
                    }
                    //重复密码验证
                    var repassword = $("#repwd").val();
                    if(password != repassword){
                        $("#error4").html("两次密码不一致");
                        a++;
                    }else{
                        $("#error4").html("输入正确");
                    }
                    if(a != 0){
                        return false;
                    }

                    var formData = new FormData($("#editForm")[0]);
                    $.ajax({
                        type:"post",
                        url:"${app}/user/register",
                        data:formData,
                        cache: false,
                        async: false,
                        processData : false,  //必须false才会避开jQuery对 formdata 的默认处理
                        contentType : false,
                        success:function (result) {
                            if(result.success){
                                alert()
                                window.location.href="${app}/register_ok.jsp";
                            }else {
                                $("#nameInfo").text("用户名已存在，请重新输入~~");
                            }

                        }
                    })
                });

			    
			});

		</script>
	</head>
	<body>

		<div class="login_step">

		</div>
		<div class="fill_message" style="color:blue;">
			<form id="editForm" name="ctl00" enctype="multipart/form-data" method="post">
				<h2>
					请填写您的个人信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</h2>
				<table class="tab_login" >
					<tr>
						<td valign="top" class="w1">
							设置您的用户名：
						</td>
						<td>
							<input name="username"  type="text" id="username" class="text_input" />
							<div class="text_left" id="nickNameValidMsg">
								<p>
									您的用户名可以由小写英文字母、中文、数字组成，
								</p>
								<p>
									长度4－20个字符，一个汉字为两个字符。
								</p>
								<div id="error3" style="display:inline;color:red;"></div>
								<span id="nameInfo" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							设置您的头像：
						</td>
						<td>
							&nbsp;&nbsp;<input name="aaa" type="file" id="aa"/>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							设置您的密码：
						</td>
						<td>
							<input name="password" type="password" id="pwd" class="text_input" />
							<div class="text_left" id="passwordValidMsg">
								<p>
									您的密码可以由大小写英文字母、数字组成，长度6－20位。
								</p>
								 <div id="error2" style="display:inline;color:red;"></div>
								<span id="passwordInfo"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							再次输入您设置的密码：
						</td>
						<td>
							<input name="password1" type="password" id="repwd" class="text_input"/>
							<div class="text_left" id="repeatPassValidMsg">
								<div id="error4" style="display:inline;color:red;"></div>
								<span id="password1Info"></span>
							</div>
							
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							选择您的性别：
						</td>
						<td>
							&nbsp;
							<select name="sex" style="width: 100px;height: 25px;">
								<option value="男">男</option>
								<option value="女">女</option>
							</select>

						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							选择您的所在地：
						</td>
						<td>
							&nbsp;
							<select name="province.id" style="width: 100px;height: 25px;">
								<c:forEach items="${requestScope.provinces}" var="pro">
									<option value="${pro.id}">${pro.name}</option>
								</c:forEach>
							</select>

						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							请输入您的手机号：
						</td>
						<td>
							<input name="phone" type="text" id="phone" class="text_input"/>
							<div class="text_left" id="phoneMsg">
							<p>
								请输入有效的手机号，以方便我们将来联系您。
							</p>

								<div id="error5" style="display:inline;color:red;"></div>
								<span id="msg"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							请填写您的Email地址：
						</td>
						<td>
							<input name="email"  type="text" id="email" class="text_input"/>
							<div class="text_left" id="emailValidMsg">
								<p>
									请填写有效的Email地址。
								</p>
								<div id="error1" style="display:inline;color:red;"></div>
								<span id="emailInfo"></span>
							</div>
						</td>
					</tr>
				</table>
				<div class="login_in">
					<button id="submit" class="btn-default">&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;册&nbsp;&nbsp;&nbsp;&nbsp;</button>
				</div>
			</form>
		</div>

	</body>
</html>

