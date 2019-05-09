<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {
        //创建表格
        $("#userTable").jqGrid({
            styleUI : 'Bootstrap',
            autowidth:true,
            url:"${app}/user/queryByPage",
            datatype:"json",
            rowNum:2,
            pager:"#pager",
            viewrecords:true,
            colNames:["id","头像","用户名","密码","性别","手机号","Email","所在地","状态","注册时间","操作"],
            colModel:[
                {name:"id",hidden:true},
                {name:"avatar",formatter:function(value,options,row){
                        var temp = "<img class='img-rounded' width='50px' height='30px' src='${app}/uploadAvatars/"
                        return temp + row.avatar +"'/>"
                    }},
                {name:"username"},
                {name:"password"},
                {name:"sex"},
                {name:"phone"},
                {name:"email"},
                {name:"province.name"},
                {name:"type"},
                {name:"registDate"},
                {name:"options",
                    formatter:function(value,options,row){
                        var content = "<a class='btn btn-primary' onclick=\"javascript:edit(\'"+row.id+"'\,\'"+row.type+"'\)\">修改用户状态</a>  ";
                        return content;
                    }
                }
            ]
        }).jqGrid();
    });

    function edit(id,type) {
        $.post("${app}/user/update",{id:id,type:type},function (result) {
            $("#userTable").jqGrid().trigger("reloadGrid");
        })
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

    <!--表-->
    <table class="table table-bordered table-striped" id="userTable">
    </table>
</div>
<!--分页-->
<div id="pager" style="height: 50px"></div>
<div class="clearfix"></div>


</body>
</html>