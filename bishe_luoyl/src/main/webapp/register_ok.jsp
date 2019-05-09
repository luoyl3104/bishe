<%@page contentType="text/html;charset=utf-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>用户注册 - 当当网</title>
		<link href="${pageContext.request.contextPath }/front/css/login.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath }/front/css/page_bottom.css" rel="stylesheet" type="text/css" />
		<script src="${pageContext.request.contextPath }/statics/boot/js/jquery-3.3.1.min.js"></script>
	</head>
	<body>
		<div class="login_step">

		</div>


		<div class="login_success">
			<div class="login_bj">
				<div class="succ">
					<img src="${pageContext.request.contextPath}/img/login_success.jpg" />g
				</div>
				<h5>
					注册成功！
				</h5>
				<h6>
					请牢记您的用户名和密码！
				</h6>

				<ul>
					<li class="nobj">
						还有<strong><font color="red" id="aa"></font></strong>秒,回到登陆界面！！！
					</li>
				</ul>
				<script>
                    var count = 6;
                    var time = function(){
                        count--;
                        if(count == 0){
                            window.location.href="${pageContext.request.contextPath}/login.jsp";
                        }else{
                            $("#aa").html(count);
                            setTimeout(time,1000);
                        }
                    };
                    time();
				</script>
			</div>
		</div>

	</body>
</html>

