<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
  $(function () {
      //创建表格
      $("#commentTable").jqGrid({
          styleUI : 'Bootstrap',
          autowidth:true,
          url:"${app}/comment/queryByPage",
          datatype:"json",
          rowNum:3,
          pager:"#pager",
          viewrecords:true,
          colNames:["id","评论内容","评论发布者","评论景点","发布时间","支持数","操作"],
          colModel:[
              {name:"id", hidden:true},
              {name:"content"},
              {name:"user.username"},
              {name:"view.name"},
              {name:"publishDate"},
              {name:"sign"},
              {name:"options",
                  formatter:function(value,options,row){
                      var content = "  <a class='btn btn-primary' onclick=\"javasctipt:del(\'"+row.path+"'\,\'"+row.id+"'\)\">删除评论</a>";
                      return content;
                  }
              }
          ],
          sortname: 'view.name',
          grouping:true,
          groupingView : {
              groupField : ['view.name'],
              groupColumnShow : [false]
          }

      }).jqGrid();




  //删除
  function del(id) {
      $.post("${app}/comment/remove",{id:id},function () {
          $("#commentTable").jqGrid().trigger("reloadGrid");
          alert("删除成功~！");
      })
  }





  });




</script>

<div class="page-header">
    <h1>评论管理</h1>
</div>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a>评论列表</a></li>
</ul>

<div class="panel panel-default">
    <!--表-->
    <table class="table table-bordered table-striped" id="commentTable">
    </table>
</div>
<!--分页-->
<div id="pager" style="height: 50px"></div>
<div class="clearfix"></div>


</body>
</html>