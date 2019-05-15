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

    <script>

        //安全退出
        function exit() {
            $.post("${app}/user/exit",null,function () {
                window.location.href="${app}/login.jsp";
            })
        }

        //初始化页面---展示信息
        function initData(page,viewName,viewProvince){
            $("#main").empty();
            $.post("${app}/view/show",{page:page,name:viewName,provinceId:viewProvince},function (result) {
                var views = result.views;
                var comments = result.comments;
                if(views.length==0){
                    alert("没有更多相关信息哦~~")
                }
                //console.log(views);
                //console.log(comments)
                var a = 1;
                $.each(views,function (i, view) {
                    var div1 = $("<div class='clo-lg-10'/>");
                    $("#main").append(div1);
                    var div2 = $("<div class='tn-list'/>");
                    div1.append(div2);
                    var div3 = $("<div class='tn-item clearfix'/>");
                    div2.append(div3);
                    var div4 = $("<div style='height: 10px'/>");
                    div3.append(div4);
                    var div5 = $("<div class='col-md-4'>");
                    var img1 = $("<img width='220px' height='150px'>").attr("src","${app}/uploadViews/"+view.picture);
                    div5.append(img1);
                    div3.append(div5);
                    var div6 = $("<div class='col-md-6'>");
                    div3.append(div6);
                    var dl = $("<dl/>");
                    div6.append(dl);
                    var dt = $("<dt/>").text(view.name);
                    dl.append(dt);
                    var dd = $("<dd/>");
                    var a1 = $("<a target='_blank'/>").text(view.des);
                    a1.prop("href","javascript:viewDetail("+view.id+")");
                    dd.append(a1);
                    dl.append(dd);
                    var div7 = $("<div class='tn-extra'/>")
                    div6.append(div7);
                    var span1 = $("<span class='tn-place'/>");
                    div7.append(span1)
                    var span2 = $("<span class='glyphicon glyphicon-map-marker' rel='nofollow'/>").text(view.province.name+", by: ");
                    span1.append(span2);
                    var span3 = $("<span class='tn-user'/>");
                    div7.append(span3);
                    var a2 = $("<a target='_blank' rel='nofollow'/>");
                    span3.append(a2);
                    var img2 = $("<img width='30px' height='16px'/>").attr("src","${app}/userAvatars/"+view.user.avatar);
                    a2.append(img2);
                    var span4 = $("<span/>").text("     "+view.user.username);
                    a2.append(span4);
                    var hr = $("<hr/>");
                    //div7.append(hr);
                    var div8 = $("<div class='col-md-6'/>")
                    div3.append(div8);
                    var h = $("<h3/>").text("评论区")
                    div8.append(h);
                    $.each(comments,function (i, comment) {
                        if(comment.view.id==view.id){
                            var span5 = $("<span/><br>").text(comment.user.username+" : "+comment.content);
                            div8.append(span5);
                        }
                    });
                    //div8.append(hr);
                    var form = $("<form/>");
                    div8.append(form);
                    var input = $("<input type='text' placeholder='追加评论'/>");
                    input.attr("id",a);
                    var span5 = $("<span/>").text("       ");
                    form.append(input);
                    form.append(span5);
                    var a3 = $("<a class='btn-primary' style='background: rgb(0, 142, 173); padding: 7px 8px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;width: 30px;'/>").text("--发送--");
                    a3.attr("href","javascript:submitComment("+view.id+","+a+")");
                    a++;
                    form.append(a3);
                    div1.append(hr);
                })
                //生成上一页、下一页
                $("#page").empty();
                //console.log(result.pageNow);
                var pageNow = result.pageNow;
                var pageTotal = result.pageTotal;
                /*
                  <li><a href="#">Previous</a></li>
                  <li><a href="#">Next</a></li>
                */
                var sli = $("<li/>");
                $("#page").append(sli);
                var sa = $("<a/>").attr("href","javascript:search("+(pageNow-1)+")");
                var s = $("<span/>").html("&laquo");
                sa.append(s);
                sli.append(sa);
                //上一页状态
                if(pageNow==1){
                    sli.addClass("disabled");
                    sa.removeAttr("href");
                }
                var nli = $("<li/>");
                $("#page").append(nli);
                var na = $("<a/>").attr("href","javascript:search("+(pageNow+1)+")");
                var n = $("<span/>").html("&raquo");
                na.append(n);
                nli.append(na);
                //下一页状态
                if(pageNow==pageTotal){
                    nli.addClass("disabled");
                    na.removeAttr("href");
                }
            });
        }

        //提交搜索
        function search(page){
            var name = $("#viewName").val();
            var provinceId = $("#viewProvince").val();
            initData(page,name,provinceId);
        }

        //提交评论
        function submitComment(id,a){
            var content = $("#"+a).val();
            $.post("${app}/comment/save",{content:content,viewId:id},function (result) {
                if(result.message){
                    $("#main").empty()
                    initData();
                }else {
                    alert("游客不能发表评论哦~~");
                }
            })
        }

        $(function () {

            initData();

            //图片 、下拉列表
            $.post("${app}/view/img",function (result) {
                var views = result.views;
                var provinces = result.provinces;
                $.each(views,function (i, view) {
                    var ul = $("<ul class='show-nav'/>");
                    $("#im").append(ul);
                    var a =$("<a/>");
                    ul.append(a);
                    var img = $("<img width='110px' height='62px'/>").attr("src","${app}/uploadViews/"+view.picture);
                    a.append(img);
                })
                $.each(provinces,function (i, province) {
                    var option = $("<option value='"+province.id+"'/>").text(province.name);
                    $("#viewProvince").append(option);
                })

            })


            //监听个人中心模态框打开
            $("#modUserInfo").on('show.bs.modal',function (e) {
                $("#userForm")[0].reset();//重置表单
                $("#pro").empty();
                $.post("${app}/user/mine",function (result) {
                    if (result.message){
                        //console.log(result.provinces);
                        //console.log(result.user);
                        var provinces = result.provinces;
                        var user = result.user;
                        $("#uid").val(user.id);
                        $("#img").attr("src","${app}/userAvatars/"+user.avatar);
                        $("#username").val(user.username);
                        $("#pwd").val(user.password);
                        if(user.sex == "男"){
                            var sexOption1 = $("<option value='男' selected>男</option>");
                            var sexOption2 = $("<option value='女'>女</option>");
                            $("#sex").append(sexOption1);
                            $("#sex").append(sexOption2);
                        }
                        if(user.sex == "女"){
                            var sexOption1 = $("<option value='男'>男</option>");
                            var sexOption2 = $("<option value='女' selected>女</option>");
                            $("#sex").append(sexOption1);
                            $("#sex").append(sexOption2);
                        }
                        $.each(provinces,function (i, province) {
                            if(user.province.id == province.id){
                                var proOption = $("<option value='"+province.id+"' selected>"+province.name+"</option>");
                                $("#pro").append(proOption);
                            }
                            if(user.province.id != province.id){
                                var proOption = $("<option value='"+province.id+"'>"+province.name+"</option>");
                                $("#pro").append(proOption);
                            }
                        });
                        $("#phone").val(user.phone);
                        $("#email").val(user.email);
                    } else {
                        $("#modUserInfo").modal('hide');
                        alert("您还未登录哦~~");
                    }
                })
            })

            //提交修改
            $("#userInfo").click(function () {
                $.post("${app}/user/update",$("#userForm").serialize(),function (result) {
                    if(result.update){
                        alert("修改个人信息成功~！");
                        //关闭模态框
                        $("#modUserInfo").modal('hide');
                    }else {
                        alert("用户名已存在，请重新修改~！");
                    }
                })
            });

            //监听发布信息模态框打开
            $("#modViewInfo").on('show.bs.modal',function (e) {
                $("#editForm")[0].reset();//重置表单
                $("#pd").empty();
                $.post("${app}/view/queryAllProvince",function (result) {
                    var provinces = result.provinces;
                    $.each(provinces,function (i, province) {
                        var option = $("<option value='"+province.id+"'>"+province.name+"</option>");
                        $("#pd").append(option);
                    })
                })
            });
            //发布信息
            $("#editViewInfo").click(function () {
                var formData = new FormData($("#editForm")[0]);
                $.ajax({
                    type:"post",
                    url:"${app}/view/addView",
                    data:formData,
                    cache: false,
                    async: false,
                    processData : false,
                    contentType : false,
                    success:function (result) {
                        if(result.message){
                            //隐藏模态框
                            $("#modViewInfo").modal("hide");
                            initData();
                        }else {
                            $("#modViewInfo").modal("hide");
                            alert("游客不能发布信息哦~~");
                        }
                    }
                })
            });
        });


        //与我相关
        function myView(page) {
            $.post("${app}/view/myView",{page:page},function (result) {
                if(result.message){
                    $("#main").empty();
                    var views = result.views;
                    var comments = result.comments;
                    //console.log(views);
                    //console.log(comments)
                    $.each(views,function (i, view) {
                        var div1 = $("<div class='clo-lg-10'/>");
                        $("#main").append(div1);
                        var div2 = $("<div class='tn-list'/>");
                        div1.append(div2);
                        var div3 = $("<div class='tn-item clearfix'/>");
                        div2.append(div3);
                        var div4 = $("<div style='height: 10px'/>");
                        div3.append(div4);
                        var div5 = $("<div class='col-md-4'>");
                        var img1 = $("<img width='220px' height='150px'>").attr("src","${app}/uploadViews/"+view.picture);
                        div5.append(img1);
                        div3.append(div5);
                        var div6 = $("<div class='col-md-6'>");
                        div3.append(div6);
                        var dl = $("<dl/>");
                        div6.append(dl);
                        var dt = $("<dt/>").text(view.name);
                        dl.append(dt);
                        var dd = $("<dd/>");
                        var a1 = $("<a target='_blank'/>").text(view.des);
                        a1.attr("href","javascript:viewDetail("+view.id+")");
                        dd.append(a1);
                        dl.append(dd);
                        var div7 = $("<div class='tn-extra'/>")
                        div6.append(div7);
                        var span1 = $("<span class='tn-place'/>");
                        div7.append(span1)
                        var span2 = $("<span class='glyphicon glyphicon-map-marker' rel='nofollow'/>").text(view.province.name+", by: ");
                        span1.append(span2);
                        var span3 = $("<span class='tn-user'/>");
                        div7.append(span3);
                        var a2 = $("<a target='_blank' rel='nofollow'/>");
                        span3.append(a2);
                        var img2 = $("<img width='30px' height='16px'/>").attr("src","${app}/userAvatars/"+view.user.avatar);
                        a2.append(img2);
                        var span4 = $("<span/>").text("     "+view.user.username);
                        a2.append(span4);
                        var hr = $("<hr/>");
                        //div7.append(hr);
                        var div8 = $("<div class='col-md-6'/>")
                        div3.append(div8);
                        var h = $("<h3/>").text("评论区")
                        div8.append(h);
                        $.each(comments,function (i, comment) {
                            if(comment.view.id==view.id){
                                var span5 = $("<span/><br>").text(comment.user.username+" : "+comment.content);
                                div8.append(span5);
                            }
                        });
                        //div8.append(hr);
                        var form = $("<form/>");
                        div8.append(form);
                        var input = $("<input type='text' placeholder='追加评论'/>");
                        var span5 = $("<span/>").text("       ");
                        form.append(input);
                        form.append(span5);
                        var a3 = $("<a href='javascript:' class='btn-primary' style='background: rgb(0, 142, 173); padding: 7px 8px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;width: 30px;'/>").text("--发送--");
                        form.append(a3);
                        div1.append(hr);
                    })
                    //清除上一页、下一页
                    $("#page").empty();
                }else {
                    alert("您还未登录哦~~");
                }
            });
        }

        //展示详情
        function viewDetail(id) {
            $.post("${app}/view/viewDetail",{viewId:id},function (result) {
                $("#main").empty();
                var view = result.view;
                var comments = result.comments;
                //console.log(views);
                //console.log(comments)
                var div1 = $("<div class='clo-lg-10'/>");
                $("#main").append(div1);
                var div2 = $("<div class='tn-list'/>");
                div1.append(div2);
                var div3 = $("<div class='tn-item clearfix'/>");
                div2.append(div3);
                var div4 = $("<div style='height: 10px'/>");
                div3.append(div4);
                var div5 = $("<div class='col-md-4'>");
                var img1 = $("<img width='220px' height='150px'>").attr("src","${app}/uploadViews/"+view.picture);
                div5.append(img1);
                div3.append(div5);
                var div6 = $("<div class='col-md-6'>");
                div3.append(div6);
                var dl = $("<dl/>");
                div6.append(dl);
                var dt = $("<dt/>").text(view.name);
                dl.append(dt);
                var dd = $("<dd/>");
                var a1 = $("<span target='_blank'/>").text(view.des);
                dd.append(a1);
                dl.append(dd);
                var div7 = $("<div class='tn-extra'/>")
                div6.append(div7);
                var span1 = $("<span class='tn-place'/>");
                div7.append(span1)
                var span2 = $("<span class='glyphicon glyphicon-map-marker' rel='nofollow'/>").text(view.province.name+", by: ");
                span1.append(span2);
                var span3 = $("<span class='tn-user'/>");
                div7.append(span3);
                var a2 = $("<a target='_blank' rel='nofollow'/>");
                span3.append(a2);
                var img2 = $("<img width='30px' height='16px'/>").attr("src","${app}/userAvatars/"+view.user.avatar);
                a2.append(img2);
                var span4 = $("<span/>").text("     "+view.user.username);
                a2.append(span4);
                var hr = $("<hr/>");
                //div7.append(hr);
                var div8 = $("<div class='col-md-6'/>")
                div3.append(div8);
                var h = $("<h3/>").text("评论区")
                div8.append(h);
                $.each(comments,function (i, comment) {
                    var span5 = $("<span/><br>").text(comment.user.username+" : "+comment.content);
                    div8.append(span5);
                });
                var form = $("<form/>");
                div8.append(form);
                var input = $("<input type='text' placeholder='追加评论'/>");
                var span5 = $("<span/>").text("       ");
                form.append(input);
                form.append(span5);
                var a3 = $("<a href='javascript:' class='btn-primary' style='background: rgb(0, 142, 173); padding: 7px 8px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;width: 30px;'/>").text("--发送--");
                form.append(a3);
                div1.append(hr);
                //清除上一页、下一页
                $("#page").empty();
            })
        }


    </script>



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
                    <li><a href="javascript:myView(1)">与我相关</a></li>
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
                    <li><a onclick="javascript:exit()">退出登录</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<!--主体-->
<div class="container-fluid">
    <div class="row">
        <!--左栏-->
        <div class="col-md-2" id="im">

            <ul class="show-nav">
                <c:if test="${sessionScope.user ne null}">
                    <span>欢迎:<img width="30px" height="20px" src="${app}/userAvatars/${sessionScope.user.avatar}">&nbsp;&nbsp;${sessionScope.user.username}</span>
                </c:if>
                <c:if test="${sessionScope.user eq null}">
                    <a class="btn btn-warning" href="${app}/register.jsp">前往注册</a>
                </c:if>
            </ul>



        </div>

        <div class="col-lg-10">
            <div class="page-header">
                <h1>要玩的开心哦~</h1>
            </div>
            <!--搜索框-->
            <div class="panel panel-default">
                <div class="panel-body">
                    <form class="form-inline">
                        <div class="form-group">
                            <label for="viewName">景点名称</label>
                            <input type="text" class="form-control" id="viewName" placeholder="请输入景点名称">
                        </div>
                        <div class="form-group">
                            <label for="viewProvince">景点所在地</label>
                            <select class="form-control" id="viewProvince">
                                <option value="">--请选择景点所在地--</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="javascript:search(1);">查询</button>
                    </form>
                </div>
            </div>
            <!--主内容-->
            <div class="panel panel-default" id="main">



            </div>
            <%--连接，返回首页--%>
            <a href="javascript:initData(1,null,null)">返回首页</a>
        </div>
    </div>
</div>

<!--分页-->
<nav aria-label="Page navigation">
    <ul class="pager" id="page">

    </ul>
</nav>


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
                            <img id="img" width="50px" height="30px">
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

                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">所在地</label>
                        <div class="col-xs-8">
                            <select name="province.id" id="pro" style="width: 100px">

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
                            <select name="province.id" id="pd" style="width: 150px">

                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">星级</label>
                        <div class="col-xs-8">
                            <input name="score" type="radio" value="一星" checked="checked"/>一星
                            <input name="score" type="radio" value="二星"/>二星
                            <input name="score" type="radio" value="三星"/>三星
                            <input name="score" type="radio" value="四星"/>四星
                            <input name="score" type="radio" value="五星"/>五星
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