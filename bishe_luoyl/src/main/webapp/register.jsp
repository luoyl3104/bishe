<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set value="${pageContext.request.contextPath}" var="app"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>注册中心</title>
	<style type="text/css">
		body{padding-top: 30px}
		#web{margin: 0 auto; width: 400px}
		.title{font-size: 18px; padding-left: 25px; border-left: solid #999 1px; margin-bottom: 40px}
		.form_item{width:398px; height: 52px; border:solid #ddd 1px; position: relative;}
		.form_item label{width:90px; height:52px; line-height: 52px; float: left;padding-left: 20px; font-size: 14px; color: #666}
		.form_item .code{position: absolute; right: 0; top: 0; text-align: center;}
		.form_item input{border:0; font-size: 14px; width: 190px; height: 19px; padding-bottom: 11px; padding-left: 20px; padding-top: 16px}
		.input-tip{color:#c5c5c5; height: 27px; font-size: 12px; padding-top: 5px}
		.input-tip span{height: 22px; line-height: 22px}

		button, #btn{width:100%; height: 54px; color:#fff; background-color: #e22; border:0; font-size: 16px; font-family: "微软雅黑"}

		a{
			text-decoration:none;
		}


	</style>
	<script src="${app}/statics/boot/js/jquery-3.3.1.min.js"></script>
	<script src="${app}/statics/boot/js/bootstrap.min.js"></script>

	<script type="text/javascript">

		$(function () {
            $.post("${app}/view/queryAllProvince",function (result) {
                var provinces = result.provinces;
                $.each(provinces,function (i, province) {
                    var option = $("<option value='"+province.id+"'/>").text(province.name);
                    $("#provinceSel").append(option);
                })
            })

            var uname_reg = /^[\u4e00-\u9fa5]{4,20}$|^[\dA-Za-z_\-]{4,20}$/;
            var uname_ok = false;
            // 用户名输入框获取焦点
            $("#uname").focus(function(){
                $(this).css("outline", "none");
                $(this).attr("placeholder", "");
                $(this).parent().css("border-color", "#999");
                $("#uname_error").css("color", "#c5c5c5");
                $("#uname_error").html("支持中文, 字母, 数字, \"-\", \"_\", 的组合, 4-20个字符");
            });
            $("#uname").blur(function(){
                if ($(this).val() == "") {
                    $(this).attr("placeholder", "您的账户名和登录名");
                    $("#uname_error").html("");
                    uname_ok = false;
                } else if ($(this).val().length < 4 || $(this).val().length > 20) {
                    // 长度不对
                    $("#uname_error").html("长度只能在4-20个字符之间");
                    $("#uname_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    uname_ok = false;
                } else if (!$(this).val().match(uname_reg)) {
                    // 有特殊字符
                    $("#uname_error").html("格式错误, 仅支持中文, 字母, 数字, \"-\", \"_\"的组合");
                    $("#uname_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    uname_ok = false;
                } else {
                    uname_ok = true;
                }
            });

            var pwd_reg = /^(?![A-Z]+$)(?![a-z]+$)(?!\d+$)(?![\W_]+$)\S{6,20}$/;
            var pwd_ok = false;
            // 密码输入框获取焦点
            $("#pwd").focus(function(){
                $(this).css("outline", "none");
                $(this).attr("placeholder", "");
                $(this).parent().css("border-color", "#999");
                $("#pwd_error").css("color", "#c5c5c5");
                $("#pwd_error").html("建议使用字母, 数字和符号两种及以上的组合, 6-20个字符");
            });
            $("#pwd").blur(function(){
                if ($(this).val() == "") {
                    $(this).attr("placeholder", "建议至少使用两种字符组合");
                    $("#pwd_error").html("");
                    pwd_ok = false;
                } else if ($(this).val().length < 6 || $(this).val().length > 20) {
                    // 长度不对
                    $("#pwd_error").html("长度只能在6-20个字符之间");
                    $("#pwd_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    pwd_ok = false;
                } else if (!$(this).val().match(pwd_reg)) {
                    // 不是两种及以上的组合
                    $("#pwd_error").html("有被盗风险, 建议使用字母, 数字和符号两种及以上组合");
                    $("#pwd_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    pwd_ok = false;
                } else {
                    pwd_ok = true;
                }
            });

            // 再次密码输入框获取焦点
            var confirm_pwd_ok = false;
            $("#confirm_pwd").focus(function(){
                $(this).css("outline", "none");
                $(this).attr("placeholder", "");
                $(this).parent().css("border-color", "#999");
                $("#confirm_pwd_error").css("color", "#c5c5c5");
                $("#confirm_pwd_error").html("请再次输入密码");
            });
            $("#confirm_pwd").blur(function(){
                if ($(this).val() == "") {
                    $(this).attr("placeholder", "请再次输入密码");
                    $("#confirm_pwd_error").html("");
                    confirm_pwd_ok = false;
                } else if ($(this).val() != $("#pwd").val()) {
                    // 再次输入的密码不一致
                    $("#confirm_pwd_error").html("两次输入的密码不一致");
                    $("#confirm_pwd_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    confirm_pwd_ok = false;
                } else {
                    confirm_pwd_ok = true;
                }
            });

            // 手机号码输入框获取焦点
            var phone_reg = /^1[3|4|5|7|8]\d{9}$/;
            var phone_ok = false;
            $("#phone").focus(function(){
                $(this).css("outline", "none");
                $(this).attr("placeholder", "");
                $(this).parent().css("border-color", "#999");
                $("#phone_error").css("color", "#c5c5c5");
                $("#phone_error").html("验证完成后, 可以使用该手机登录和找回密码");
            });
            $("#phone").blur(function(){
                if ($(this).val() == "") {
                    $(this).attr("placeholder", "建议使用常用手机");
                    $("#phone_error").html("");
                    phone_ok = false;
                } else if ($(this).val().length != 11) {
                    // 长度不对
                    $("#phone_error").html("格式有错");
                    $("#phone_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    phone_ok = false;
                } else if (!$(this).val().match(phone_reg)) {
                    // 输入的不是手机号码
                    $("#phone_error").html("格式有错");
                    $("#phone_error").css("color", "red");
                    $(this).parent().css("border-color", "red");
                    phone_ok = false;
                } else {
                    phone_ok = true;
                }
            });

			$("#btn").click(function () {

                if (uname_ok && pwd_ok && confirm_pwd_ok && phone_ok) {
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
                            //console.log(result);
                            if(result.regist == 1){
                                window.event.returnValue=false;
                                window.location.href="${app}/register_ok.jsp";
                            }
                            if(result.regist == 2){
                                $("#uname_error").css("color","red").text("用户名已存在，请重新输入~~");
                            }
                        }
                    })
                }else {
                    alert('信息输入不完整, 请核对');
                    return false;
                }

            })


        });






	</script>

</head>
<body>


<body>
<div id="web">
	<form action="" method="post" enctype="multipart/form-data" id="editForm">
		<div class="form_item">
			<label>&nbsp;用  户  名&nbsp;</label>
			<input type="text" value="" placeholder="您的账户名和登录名" id="uname" name="username" />
		</div>
		<div class="input-tip">
			<span id="uname_error"></span>
		</div>

		<div class="form_item">
			<label>设 置 头 像</label>
			<input type="file" value="" id="avatar" name="aaa" />
		</div>
		<div class="input-tip">
			<span ></span>
		</div>
		<div class="form_item">
			<label>设 置 密 码</label>
			<input type="password" value="" placeholder="建议至少使用两种字符组合" id="pwd" name="password" />
		</div>
		<div class="input-tip">
			<span id="pwd_error"></span>
		</div>
		<div class="form_item">
			<label>确 认 密 码</label>
			<input type="password" value="" placeholder="请再次输入密码" id="confirm_pwd" />
		</div>
		<div class="input-tip">
			<span id="confirm_pwd_error"></span>
		</div>
		<div class="form_item">
			<label>设 置 性 别</label>
			<input name="sex" type="radio" checked value="男"/>男
			<input name="sex" type="radio" value="女"/>女
		</div>
		<div class="input-tip">
			<span id="sex_error"></span>
		</div>
		<div class="form_item">
			<label>设置所在地</label>
			<div style="margin:auto;width: 200px;margin-top:3.5%;">
				<select style="width: 150px;height: 20px" name="province.id" id="provinceSel">

				</select>
			</div>
		</div>
		<div class="input-tip">
			<span id="prc_error"></span>
		</div>
		<div class="form_item">
			<label>中国 + 86</label>
			<input type="text" value="" placeholder="请输入正确格式手机号" id="phone" name="phone" />
		</div>
		<div class="input-tip">
			<span id="phone_error"></span>
		</div>
		<div class="form_item">
			<label> 邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱 </label>
			<input type="text" value="" placeholder="请输入常用邮箱" id="email" name="email"/>
			<label class="code"></label>
		</div>
		<div class="input-tip">
			<span id="code_error"></span>
		</div>

		<a><button type="button" id="btn">立即注册</button></a>

		<div class="input-tip">
			<span></span>
		</div>
	</form>
</div>
</body>




</body>
</html>