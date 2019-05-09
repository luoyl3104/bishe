<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="app"/>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>景点信息后台管理</title>
    <link rel="stylesheet" href="./statics/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="./statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="./statics/boot/js/jquery-3.3.1.min.js"></script>
    <script src="./statics/boot/js/bootstrap.min.js"></script>
    <script src="./statics/jqgrid/js/trirand/jquery.jqGrid.min(1).js"></script>
    <script src="./statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script>

        $(function () {
            $(window).resize(function () {
                $("#picTable").setGridWidth($("#centerLayout").width());
            });
        });

    </script>

    <style>
        .page-header{
            margin-top: 0px;
            margin-bottom: 12px;
        }
        .page-header h1{
            margin-top: 0px;
        }
    </style>
</head>
<body>

<!--导航-->
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!--生成导航标题-->
        <div class="navbar-header">
            <a href="" class="navbar-brand">景点信息后台管理系统</a>
        </div>
        <!--生成导航内容-->
        <ul class="nav navbar-nav navbar-right">
            <li><a href="">您好:<span class="text-primary" style="color: #2aabd2">${sessionScope.admin.name}</span></a></li>
            <li><a href="${app}/admin/exit">退出登录<span class="glyphicon glyphicon-log-out" aria-hidden="true"></span></a></li>
        </ul>
    </div>
</nav>


<div class="container-fluid">
    <div class="row">
        <!--左栏-->
        <div class="col-md-2">
            <!--手风琴-->
                <div class="panel-group" id="panelgroup">
                <!--创建面板-->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <a href="#picture" data-toggle="collapse" data-parent="#accordion"><strong>景点信息模块</strong></a>
                        </div>
                    </div>
                    <div id="picture" class="panel-collapse collapse">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('${app}/view.jsp')">景点信息管理</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--创建另一个面板-->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <a href="#special" data-toggle="collapse" data-parent="#accordion" ><strong>评论模块</strong></a>
                        </div>
                    </div>
                    <div id="special" class="panel-collapse collapse">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('${app}/comment.jsp')">评论管理</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <a href="#chapter" data-toggle="collapse" data-parent="#accordion"><strong>用户模块</strong></a>
                        </div>
                    </div>
                    <div id="chapter" class="panel-collapse collapse">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('${app}/user.jsp')">用户管理</a></li>
                            </ul>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('${app}/userEcharts.jsp')">用户分布图</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--主体-->
        <div class="col-lg-10" id="centerLayout">

            <%--面板--%>
            <div class="panel panel-default">
                <div class="panel-heading">
                    欢迎登陆景点信息后台管理系统
                </div>
            </div>

            <%--巨幕--%>
            <div class="jumbotron">
                <img src="${app}/img/7e0e.jpg" alt="Responsive image" class="img-thumbnail">
            </div>

        </div>

    </div>
</div>

<!--底部-->
<div class="col-sm-5 col-sm-offset-4 ">
    <p class="center-block" style="font-size: 16px;text-align: center">zzu.luoyl@3104651846@qq.com</p>
</div>



</body>
</html>
