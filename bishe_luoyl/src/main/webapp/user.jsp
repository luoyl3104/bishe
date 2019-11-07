<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>

    $(function () {
        initData();
    });

    function initData(page,username,type) {
        $.post("${app}/user/queryByPage",{page:page,username:username,type:type},function (result) {
            $("#tbody").empty();
            $("#pager").empty();
            var users = result.users;
            if(users.length == 0){
                alert("没有检索到结果哦~！");
            }else {
                //console.log(users);
                $.each(users,function (i, user) {
                    var tr = $("<tr/>");
                    var img = $("<img class='img-rounded' align='center' width='50px' height='30px'>").attr("src","${app}/userAvatars/"+user.avatar);
                    var avatarTd = $("<td/>").html(img);
                    var nameTd = $("<td/>").text(user.username);
                    var sexTd = $("<td/>").text(user.sex);
                    var phoneTd = $("<td/>").text(user.phone);
                    var emailTd = $("<td/>").text(user.email);
                    var pceTd = $("<td/>").text(user.province.name);
                    var typeTd = $("<td/>").text(user.type);
                    var regTd = $("<td/>").text(user.registDate);
                    var optionTd = $("<td/>");
                    var btn = $("<button onclick='javascript:edit("+user.id+")'/>").text("修改用户状态").addClass("btn btn-primary");
                    optionTd.append(btn);
                    tr.append(avatarTd).append(nameTd).append(sexTd).append(phoneTd).append(emailTd).append(pceTd).append(typeTd).append(regTd).append(optionTd);
                    $("#tbody").append(tr);
                });

                //创建页数
                var totalPage = result.pageTotal;
                var pageNow = result.page;
                //生成上一页
                var s = $("<li/>");
                var ss = $("<a/>").attr("href","javascript:search("+(pageNow-1)+");");
                var a = $("<span/>").html("&laquo");
                ss.append(a);
                s.append(ss);
                //添加到页面
                $("#pager").append(s);
                //上一页状态
                if (pageNow==1){
                    s.addClass("disabled");
                    ss.removeAttr("href");
                }

                //生成下一页
                var nextPage = $("<li/>");
                var nextPagea = $("<a/>").attr("href","javascript:search("+(pageNow+1)+");");
                var nextPages = $("<span/>").html("&raquo");
                nextPagea.append(nextPages);
                nextPage.append(nextPagea);
                //添加到页面
                $("#pager").append(nextPage);
                //下一页状态
                if (pageNow==totalPage){
                    nextPage.addClass("disabled");
                    nextPagea.removeAttr("href");
                }
            }

        },"JSON");
    }

    function edit(id) {
        $.post("${app}/user/updateType",{id:id},function () {
            initData();
        })
    }

    function search(page) {
        var username = $("#username").val();
        var type = $("#type").val();
        initData(page,username,type);
    }

</script>

<div class="page-header">
    <h1>用户管理</h1>
</div>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a>用户列表</a></li>
    <li role="presentation" class="active"><a href="${app}/user/export">导出用户信息</a></li>
</ul>

<div class="panel panel-default">
    <%--搜索框--%>
    <div class="panel-body">
        <div class="col-sm-10 col-sm-offset-2">
            <form class="form-inline">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" class="form-control" id="username" name="username">
                </div>
                <div class="form-group">
                    <label for="type" class="control-label">激活状态</label>
                    <select name="status" class="form-control" id="type">
                        <option value="">---请选择---</option>
                        <option value="冻结">冻结</option>
                        <option value="激活">激活</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary " onclick="javascript:search();">查询</button>
            </form>
        </div>
    </div>
    <!--表-->
    <table class="table table-bordered table-striped" id="userTable">
        <thead>
        <tr>
            <th>头像</th>
            <th>用户名</th>
            <th>性别</th>
            <th>手机号</th>
            <th>Email</th>
            <th>所在地</th>
            <th>状态</th>
            <th>注册时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="tbody">

        </tbody>
    </table>
</div>
<!--分页-->
<nav aria-label="Page navigation" class="pull-right">
    <ul class="pagination" id="pager">

    </ul>
</nav>
<div class="clearfix"></div>


</body>
</html>