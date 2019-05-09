<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="app"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>景点信息后台管理中心</title>
			
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
	<link rel="icon" href="img/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="css/common.css" type="text/css">
	<link rel="stylesheet" href="css/login.css" type="text/css">
	<script type="text/javascript" src="script/jquery.js"></script>
	<script type="text/javascript" src="script/common.js"></script>
	<script type="text/javascript" src="script/jquery.validate.js"></script>
	<style>
		label.error{
			padding-left: 16px;
			padding-bottom: 2px;
			font-weight: bold;
			color: #EA5200;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			//点击更换验证码：
			$("#captchaImage").click(function(){//点击更换验证码
				$(this).attr("src","${app}/code/showCode?a="+Math.floor(Math.random()*100));
			});

			//提交表单
			$("#submitBtn").click(function () {
				$.post("${app}/admin/login",$("#loginForm").serialize(),function (result) {
					if(result.message == "success"){
					    //alert()
						location.href = "${app}/index.jsp";
					}else{
                        $("#span").text(result.message);
                    }
                },"JSON");
            });


            $.validator.setDefaults({
                submitHandler: function() {

                }
            });
			// 表单验证
			$().ready(function () {
                $("#loginForm").validate({
					rules:{
					    name:{
					        required:true,
                            minlength: 4
						},
						password:{
					        required:true,
							minlength: 6
						},
                        code:{
					        required:true,
                            remote:{
                                url:"${app}/admin/checkCode",
                                    type:"post",
                                    dataType:"json",
                                    data:{
                                            code:function () {
                                                return $('#code').val();
                                            }
                                }
                			}
						}
					},
                    messages:{
					    name:{
                            required:"请输入用户名",
                            minlength: "用户名至少由两个字符组成"
						},
						password:{
					        required:"请输入密码",
                            minlength: "密码长度至少为6位"
						},
                        code:{
                            required:"验证码不能为空",
                            remote: "验证码错误"
						}
					},

				})
            });


		});
	</script>
</head>
<body>
		<div class="login">
			<form id="loginForm" action="" method="post" >
				
				<table>
					<tbody>
						<tr>
							<td>&nbsp;</td>
							<th>
								<label for="name">用户名</label>
							</th>
							<td>
								<input type="text" id="name" name="name"  maxlength="20" data-tip="请输入您的邮箱" />
							</td>
					  </tr>
					  <tr>
						  <td>&nbsp;</td>
							<th>
								<label for="password">密&nbsp;&nbsp;&nbsp;码:</label>
							</th>
							<td>
								<input type="password" id="password" name="password"  maxlength="20" autocomplete="off"/>
							</td>
					  </tr>
					
						<tr>
							<td>&nbsp;</td>
							<th><label for="code">验证码</label></th>
							<td>
								<input type="text" id="code" name="code"  maxlength="4" autocomplete="off"/>
							</td>
							<td>
								<img id="captchaImage" class="captchaImage" src="${app}/code/showCode" title="点击更换验证码"/>
							</td>
						</tr>					
					<tr>
						<td>
							<span id="span" style="color: red"></span>
						</td>
						<td>
							&nbsp;
						</td>
						<th>
							&nbsp;
						</th>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<th>&nbsp;</th>
						<td>
							<input type="button" class="homeButton" value="" onclick="location.href='/'"><input type="button" id="submitBtn" class="loginButton" value="登录">
						</td>
					</tr>
				</tbody></table>
				<div class="powered">zzu.luoyulong@3104651846@qq.com</div>
			</form>
		</div>
</body>
</html>