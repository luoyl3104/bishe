<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {

        initData();

        $.post("${app}/view/queryAllProvince",function (result) {
            var provinces = result.provinces;
            $.each(provinces,function (i, province) {
                var option = $("<option value='"+province.id+"'/>").text(province.name);
                $("#viewProvince").append(option);
            })
        })


    });


    function initData(page,name,provinceId) {
        $.post("${app}/view/queryView",{page:page,name:name,provinceId:provinceId},function (result) {
            $("#tbody").empty();
            $("#pager").empty();
            var views = result.views;
            if(views.length == 0){
                alert("没有检索到结果哦~！");
            }else {
                //console.log(users);
                $.each(views,function (i, view) {
                    var tr = $("<tr/>");
                    var img = $("<img class='img-rounded' align='center' width='50px' height='30px'>").attr("src","${app}/uploadViews/"+view.picture);
                    var avatarTd = $("<td/>").html(img);
                    var nameTd = $("<td/>").text(view.name);
                    var pwdTd = $("<td width='300px'/>").text(view.des);
                    var typeTd = $("<td/>").text(view.type);
                    var sexTd = $("<td/>").text(view.province.name);
                    var phoneTd = $("<td/>").text(view.user.username);
                    var emailTd = $("<td/>").text(view.uploadDate);
                    var optionTd = $("<td/>");
                    var editBtn = $("<button onclick='javascript:edit("+view.id+")'/>").addClass("btn btn-warning");
                    var editSpan = $("<span class='glyphicon glyphicon-pencil' aria-hidden='true'/>");
                    editBtn.html(editSpan);
                    var delBtn = $("<button onclick='javascript:del("+view.id+")'/>").addClass("btn btn-danger");
                    var delSpan = $("<span class='glyphicon glyphicon-remove' aria-hidden='true'/>");
                    delBtn.html(delSpan);
                    var showBtn = $("<button onclick='javascript:show("+view.id+")'/>").addClass("btn btn-primary");
                    var showSpan = $("<span class='glyphicon glyphicon-search' aria-hidden='true'/>");
                    showBtn.html(showSpan);
                    optionTd.append(editBtn).append("&nbsp;").append(delBtn).append("&nbsp;").append(showBtn);
                    tr.append(avatarTd).append(nameTd).append(pwdTd).append(typeTd).append(sexTd).append(phoneTd).append(emailTd).append(optionTd);
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


    //删除
    function del(id) {
        $.post("${app}/view/remove",{id:id},function () {
            alert("删除成功！");
            initData();
        })
    }

    //展示详情
    function show(id) {
        //模态框打开
        $("#showInfo").modal("show");
        $("#showFrom")[0].reset();//重置表单
        $.post("${app}/view/queryOne",{id:id},function(result){
            $("#id1").val(result.id);
            $("#name1").val(result.name);
            $("#score").val(result.score);
            $("#user").val(result.user.username);
            $("#des1").val(result.des);
            $("#address").val(result.province.name);
            $("#type1").val(result.type);
            $("#date").val(result.uploadDate);
            $("#img").attr("src","${app}/uploadViews/"+result.picture)
        });
    }

    //修改状态
    function edit(id) {
        $.post("${app}/view/updateType",{id:id},function () {
            initData();
        })
    }

    function search(page) {
        var name = $("#name").val();
        var provinceId = $("#viewProvince").val();
        initData(page,name,provinceId);
    }



</script>

<div class="page-header">
    <h1>景点信息管理</h1>
</div>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a>景点信息列表</a></li>
</ul>

<div class="panel panel-default">

    <%--搜索框--%>
    <div class="panel-body">
        <div class="col-sm-10 col-sm-offset-2">
            <form class="form-inline">
                <div class="form-group">
                    <label for="name">景点名称</label>
                    <input type="text" class="form-control" id="name" placeholder="景点名称中关键字即可">
                </div>
                <div class="form-group">
                    <label for="viewProvince" class="control-label">景点所在地</label>
                    <select name="status" class="form-control" id="viewProvince">
                        <option value="">----------请选择----------</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary " onclick="javascript:search();">查询</button>
            </form>
        </div>
    </div>

    <!--表-->
    <table class="table table-bordered table-striped" id="viewTable">
        <thead>
        <tr>
            <th>景点图片</th>
            <th>景点名称</th>
            <th>景点描述</th>
            <th>景点状态</th>
            <th>景点所在地</th>
            <th>信息发布者</th>
            <th>信息发布时间</th>
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


<%--展示信息详情--%>
<div class="modal fade" id="showInfo" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" disabled="true">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">信息详情</h4>
            </div>
            <div class="modal-body">
                <form  id="showFrom" class="form-horizontal" enctype="multipart/form-data" method="post">

                    <div class="form-group">
                        <label class="control-label col-xs-2">id</label>
                        <div class="col-xs-8">
                            <input type="text" name="id" id="id1" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点名称</label>
                        <div class="col-xs-8">
                            <input type="text" name="name" id="name1" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点图片</label>
                        <div class="col-xs-8">
                            <img src="" id="img" width="200px" height="130px" class="img-rounded">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">所在地</label>
                        <div class="col-xs-8">
                            <input type="text" id="address" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点星级</label>
                        <div class="col-xs-8">
                            <input type="text" id="score" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">信息发布者</label>
                        <div class="col-xs-8">
                            <input type="text" name="author" id="user" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点描述</label>
                        <div class="col-xs-8">
                            <input type="text" name="des" id="des1" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">景点状态</label>
                        <div class="col-xs-8">
                            <input type="text" name="type" id="type1" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-2">信息上传时间</label>
                        <div class="col-xs-8">
                            <input type="text" name="date" id="date" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>