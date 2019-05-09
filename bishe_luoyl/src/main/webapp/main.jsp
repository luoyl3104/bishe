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
    <title>main</title>
    <link rel="stylesheet" href="${app}/statics/boot/css/bootstrap.min.css">
    <script src="${app}/statics/boot/js/jquery-3.3.1.min.js"></script>
    <script src="${app}/statics/boot/js/bootstrap.min.js"></script>
    <style>
        th, td {
            text-align: center;
        }

        tr td:not(:last-child) {
            padding-top: 17px !important;
        }

        .page-header {
            margin-top: 0px;
            margin-bottom: 10px;
        }

        .page-header h1 {
            margin-top: 0px;
        }

    </style>
</head>

<body>

<!--导航栏-->
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!--生成导航标题-->
        <div class="navbar-header">
            <a href="" class="navbar-brand">luoyl景点信息交流系统V1.0</a>
        </div>
        <!--生成导航内容-->
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                    <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#modUserInfo" data-toggle="modal">个人中心</a></li>
                </ul>
            </li>

            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="glyphicon glyphicon-camera" aria-hidden="true"></span>
                    <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#modViewInfo" data-toggle="modal">发布信息</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">退出登录</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<!--主体-->
<div class="container-fluid">
    <div class="row">
        <!--左栏-->
        <div class="col-md-2">

            <ul class="list-group">
                <a >欢迎:<img src="${app}/userAvatars/${sessionScope.user.avatar}">&nbsp;&nbsp;XXX${sessionScope.user.username}</a>
            </ul>
            <ul class="show-nav">
                <a><img height="62" width="110" src="https://b1-q.mafengwo.net/s13/M00/2D/96/wKgEaVzOn2yACMocAALG4FavNXI39.jpeg?imageMogr2%2Fthumbnail%2F%21108x67r%2Fgravity%2FCenter%2Fcrop%2F%21108x67%2Fquality%2F90"></a>
            </ul>
            <ul class="show-nav">
                <a><img src="https://n2-q.mafengwo.net/s13/M00/4C/01/wKgEaVzOOCuAXiUcAAGyAzoh6P088.jpeg?imageMogr2%2Fthumbnail%2F%21108x67r%2Fgravity%2FCenter%2Fcrop%2F%21108x67%2Fquality%2F90" height="62" width="110"></a>
            </ul>
            <ul class="show-nav">
                <a><img src="https://p3-q.mafengwo.net/s13/M00/74/D9/wKgEaVzIEOyAQ3ZyAAI8CSx_YP005.jpeg?imageMogr2%2Fthumbnail%2F%21108x67r%2Fgravity%2FCenter%2Fcrop%2F%21108x67%2Fquality%2F90" height="62" width="110"></a>
            </ul>
            <ul class="show-nav">
                <a><img src="https://n4-q.mafengwo.net/s13/M00/76/17/wKgEaVzIETaAVF8JAAPj3UZ8TbM75.jpeg?imageMogr2%2Fthumbnail%2F%21108x67r%2Fgravity%2FCenter%2Fcrop%2F%21108x67%2Fquality%2F90" height="62" width="110"></a>
            </ul>
            <ul class="show-nav">
                <a><img src="https://n4-q.mafengwo.net/s13/M00/23/B0/wKgEaVzH_tuATsW4AAJyuY-W1Rk74.jpeg?imageMogr2%2Fthumbnail%2F%21108x67r%2Fgravity%2FCenter%2Fcrop%2F%21108x67%2Fquality%2F90" height="62" width="110"></a>
            </ul>


        </div>

        <div class="col-lg-10">
            <div class="page-header">
                <h1>首页</h1>
            </div>
            <!--搜索框-->
            <div class="panel panel-default">
                <div class="panel-body">
                    <form class="form-inline">
                        <div class="form-group">
                            <label for="exampleInputName2">景点名称</label>
                            <input type="text" class="form-control" id="exampleInputName2" placeholder="">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail2">景点所在地</label>
                            <select class="form-control" id="exampleInputEmail2">
                                <option>---请选择---</option>
                                <option>2</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary ">查询</button>
                    </form>
                </div>
            </div>
            <!--主内容-->
            <div class="panel panel-default">

                <div>
                    <div class="tn-list">
                        <div class="tn-item clearfix">
                            <div style="height: 10px"></div>
                            <div class="col-md-4">
                                <a href="" target="_blank">
                                    <img class="" src="http://p3-q.mafengwo.net/s11/M00/58/81/wKgBEFst2JaAQWKDAAXU-mm31fA63.jpeg?imageMogr2%2Fthumbnail%2F%21220x150r%2Fstrip%2Fgravity%2FCenter%2Fcrop%2F%21220x150%2Fquality%2F90"
                                         style="display: inline;">
                                </a>
                            </div>
                            <div class="col-md-6">
                                <dl>
                                    <dt>苏州吃面指南|一个人吃下七家店十碗面，一口一口把苏州吃进胃里</dt>
                                    <dd>
                                        <a target="_blank">前些天，因为想吃一碗面，酥饼去了趟 苏州 结果吃了12345678碗还不想走 每天在 苏州 只做两件事 吃面 消化 吃面 消化··· 不是在吃面 那就应该是在去吃面的路上 觉得做一个一心一意吃面的...</a>
                                    </dd>
                                </dl>
                                <div class="tn-extra"><span class="tn-place"><i></i>
                                    <span class="glyphicon glyphicon-map-marker" rel="nofollow" data-type="2">苏州</span>，by
                                    </span>
                                    <span class="tn-user">
                                        <a href="/u/43842793.html" target="_blank" rel="nofollow">
                                            <img src="http://b3-q.mafengwo.net/s11/M00/71/C6/wKgBEFrCHK2APvTmAAB7w6OnbOU49.jpeg?imageMogr2%2Fthumbnail%2F%2116x16r%2Fgravity%2FCenter%2Fcrop%2F%2116x16%2Fquality%2F90">
                                            七个酥饼
                                        </a>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div>
                                    <h3>评论区</h3>
                                    <span>小明:楼主好品味</span>
                                </div>
                                <div>
                                    <form action="" method="post">
                                        <input type="text">
                                        <input type="submit" value="发送">
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                    <hr>
                </div>

                <div>
                    <div class="tn-list">
                        <div class="tn-item clearfix">
                            <div style="height: 10px"></div>
                            <div class="col-md-4">
                                <a href="" target="_blank">
                                    <img class="" src="http://p3-q.mafengwo.net/s11/M00/58/81/wKgBEFst2JaAQWKDAAXU-mm31fA63.jpeg?imageMogr2%2Fthumbnail%2F%21220x150r%2Fstrip%2Fgravity%2FCenter%2Fcrop%2F%21220x150%2Fquality%2F90"
                                         style="display: inline;">
                                </a>
                            </div>
                            <div class="col-md-6">
                                <dl>
                                    <dt>苏州吃面指南|一个人吃下七家店十碗面，一口一口把苏州吃进胃里</dt>
                                    <dd>
                                        <a target="_blank">前些天，因为想吃一碗面，酥饼去了趟 苏州 结果吃了12345678碗还不想走 每天在 苏州 只做两件事 吃面 消化 吃面 消化··· 不是在吃面 那就应该是在去吃面的路上 觉得做一个一心一意吃面的...</a>
                                    </dd>
                                </dl>
                                <div class="tn-extra"><span class="tn-place"><i></i>
                                    <span class="glyphicon glyphicon-map-marker" rel="nofollow" data-type="2">苏州</span>，by
                                    </span>
                                    <span class="tn-user">
                                        <a href="/u/43842793.html" target="_blank" rel="nofollow">
                                            <img src="http://b3-q.mafengwo.net/s11/M00/71/C6/wKgBEFrCHK2APvTmAAB7w6OnbOU49.jpeg?imageMogr2%2Fthumbnail%2F%2116x16r%2Fgravity%2FCenter%2Fcrop%2F%2116x16%2Fquality%2F90">
                                            七个酥饼
                                        </a>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div>
                                    <h3>评论区</h3>
                                    <span>小明:楼主好品味</span>
                                </div>
                                <div>
                                    <form action="" method="post">
                                        <input type="text">
                                        <input type="submit" value="发送">
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                    <hr>
                </div>


            </div>
            <!--分页-->
            <nav aria-label="Page navigation">
                <ul class="pager">
                    <li><a href="#">Previous</a></li>
                    <li><a href="#">Next</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>


<!--模态框-->
<%--个人信息--%>
<div class="modal fade" id="modUserInfo" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">个人信息</h4>
            </div>
            <div class="modal-body">
                <form  id="userForm" class="form-horizontal" enctype="multipart/form-data" method="post">
                    <input type="hidden" name="id" id="uid">
                    <div class="form-group">
                        <label class="control-label col-xs-2">用户头像</label>
                        <div class="col-xs-8">
                            <img src="${app}/userAvatars/1.gif">
                            <input type="file" name="file" id="pic" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">用户名</label>
                        <div class="col-xs-8">
                            <input type="text" name="username" id="username" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">密码</label>
                        <div class="col-xs-8">
                            <input type="text" name="password" id="pwd" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">性别</label>
                        <div class="col-xs-8">
                            <select name="sex" id="sex" style="width: 60px">
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">所在地</label>
                        <div class="col-xs-8">
                            <select name="provinceId" id="pro" style="width: 100px">
                                <option value="">北京</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">电话</label>
                        <div class="col-xs-8">
                            <input type="text" name="phone" id="phone" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">Email</label>
                        <div class="col-xs-8">
                            <input type="text" name="email" id="email" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="userInfo">保存</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<%--发布消息--%>
<div class="modal fade" id="modViewInfo" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">编辑景点信息</h4>
            </div>
            <div class="modal-body">
                <form  id="editForm" class="form-horizontal" enctype="multipart/form-data" method="post">
                    <input type="hidden" name="id" id="id"/>

                    <div class="form-group">
                        <label class="control-label col-xs-2">景点名称</label>
                        <div class="col-xs-8">
                            <input type="text" name="name" id="name" class="form-control">
                        </div>
                    </div>
                    <div class="form-group" id="a">
                        <label class="control-label col-xs-2">景点图片</label>
                        <div class="col-xs-8">
                            <input type="file" name="file" id="file" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点描述</label>
                        <div class="col-xs-8">
                            <textarea name="des" id="des" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点所在地</label>
                        <div class="col-xs-8">
                            <select name="provinceId" id="pd" style="width: 100px">
                                <option value="">北京</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">星级</label>
                        <div class="col-xs-8">
                            <input name="sign" type="radio" checked="checked"/>一星
                            <input name="sign" type="radio" />二星
                            <input name="sign" type="radio" />三星
                            <input name="sign" type="radio" />四星
                            <input name="sign" type="radio" />五星
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="editViewInfo">发布</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>