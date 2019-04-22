<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<c:set value="${pageContext.request.contextPath}" var="app"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>员工管理系统</title>
    <link rel="stylesheet" href="${app}/statics/boot/css/bootstrap.min.css">
    <%--引入jqgrid中主题css--%>
    <link rel="stylesheet" href="${app}/statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <%--引入js文件--%>
    <script src="${app}/statics/boot/js/jquery-3.3.1.min.js"></script>
    <script src="${app}/statics/boot/js/bootstrap.min.js"></script>
    <script src="${app}/statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="${app}/statics/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
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
            <a href="" class="navbar-brand">员工管理系统<small>V1.0</small></a>
        </div>
        <!--生成导航内容-->
        <ul class="nav navbar-nav navbar-right">
            <li><a href="">欢迎:<span class="text-primary">小黑黑</span></a></li>
            <li><a href="">退出登录<span class="glyphicon glyphicon-log-out" aria-hidden="true"></span></a></li>
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
                            <a href="#aa" data-toggle="collapse" data-parent="#accordion">用户管理</a>
                        </div>
                    </div>

                    <div id="aa" class="panel-collapse collapse">
                        <div class="panel-body">
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/ems/ems.jsp')">用户列表</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--创建另一个面板-->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <!--使用连接完成折叠效果-->
                            <a href="#bb" data-toggle="collapse" data-parent="#panelgroup" ><h5>类别管理</h5></a>
                        </div>
                    </div>
                    <div class="panel-collapse collapse active" id="bb">
                        <div class="panel-body" >
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('')">类别列表</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <!--使用连接完成折叠效果-->
                            <a href="#cc" data-toggle="collapse" data-parent="#panelgroup" ><h5>图书管理</h5></a>
                        </div>
                    </div>
                    <div class="panel-collapse collapse active" id="cc">
                        <div class="panel-body" >
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('')">图书列表</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <!--使用连接完成折叠效果-->
                            <a href="#dd" data-toggle="collapse" data-parent="#panelgroup" ><h5>订单管理</h5></a>
                        </div>
                    </div>
                    <div class="panel-collapse collapse active" id="dd">
                        <div class="panel-body" >
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="javascript:$('#centerLayout').load('')">订单列表</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!--主体-->
        <div class="col-lg-10" id="centerLayout">
            <!--巨幕-->
            <div class="jumbotron">
                <h1>Hello, world!</h1>
                <p>...</p>
                <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
            </div>
            <!--警告框-->
            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4>Oh snap! You got an error!</h4>
                <p>Change this and that and try again. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.</p>
                <p>
                    <button type="button" class="btn btn-danger">Take this action</button>
                    <button type="button" class="btn btn-default">Or do this</button>
                </p>
            </div>
            <!--进图条-->
            <ul class="list-group">
                <li class="list-group-item">
                    <p>系统状态</p>
                </li>
                <li class="list-group-item">
                    <p>内存使用率:40%</p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                            <span class="sr-only">40% Complete (success)</span>
                        </div>
                    </div>
                    <p>CPU使用率:20%</p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                            <span class="sr-only">20% Complete</span>
                        </div>
                    </div>
                    <p>内存使用率:40%</p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                            <span class="sr-only">60% Complete (warning)</span>
                        </div>
                    </div>
                    <p>内存使用率:40%</p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-danger progress-bar-striped" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                            <span class="sr-only">80% Complete (danger)</span>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>

</body>
</html>