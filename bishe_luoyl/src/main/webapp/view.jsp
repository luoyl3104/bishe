<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {

        //创建表格
        $("#viewTable").jqGrid({
            styleUI : 'Bootstrap',
            autowidth:true,
            url:"${app}/view/queryView",
            datatype:"json",
            rowNum:3,
            pager:"#pager",
            viewrecords:true,
            colNames:["id","景点名称","点赞数","景点描述","景点图片","所在地","信息状态","图片存储路径","上传时间","上传者","操作"],
            colModel:[
                {name:"id", hidden:true},
                {name:"name"},
                {name:"score"},
                {name:"des",editable:true},
                {name:"picture",formatter:function(value,options,row){
                        var temp = "<img class='img-rounded' width='50px' height='30px' src='${app}/uploadViews/"
                        return temp + row.picture +"'/>"
                    }},
                {name:"province.name"},
                {name:"type",editable:true},
                {name:"path"},
                {name:"uploadDate"},
                {name:"user.username"},
                {name:"options",
                    formatter:function(value,options,row){
                        var content = " <a onclick=\"javasctipt:show(\'"+row.id+"'\)\"><span class=\"glyphicon glyphicon-search\" aria-hidden=\"true\"></span></a>   "+
                            "<a data-toggle='modal' onclick=\"javascript:edit(\'"+row.id+"'\,\'"+row.type+"'\)\"><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span></a>  "+
                            "<a onclick=\"javascript:del(\'"+row.id+"'\)\"><span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></a>";
                        return content;
                    }
                }
            ]
        }).jqGrid();

    });

    //删除
    function del(id) {
        $.post("${app}/view/remove",{id:id},function () {
            $("#viewTable").jqGrid().trigger("reloadGrid");
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
    function edit(id,type) {
        $.post("${app}/view/updateType",{id:id,type:type},function () {
            $("#viewTable").jqGrid().trigger("reloadGrid");
        })
    }





</script>

<div class="page-header">
    <h1>景点信息管理</h1>
</div>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a>景点信息列表</a></li>
</ul>

<div class="panel panel-default">
    <!--表-->
    <table class="table table-bordered table-striped" id="viewTable">
    </table>
</div>
<!--分页-->
<div id="pager" style="height: 50px"></div>
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
                        <label class="control-label col-xs-2">景点分数</label>
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