<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
  $(function () {
      //创建表格
      $("#empTable").jqGrid({
          styleUI : 'Bootstrap',
          caption:"员工信息表",
          autowidth:true,
          url:"",
          datatype:"json",
          rowNum:2,
          pager:"#pager",
          viewrecords:true,
          editurl:"",
          colNames:["id","姓名","年龄","生日","操作"],
          colModel:[
              {name:"id"},
              {name:"name",editable:true},
              {name:"age",editable:true},
              {name:"bir",editable:true},
              {name:"options",
                formatter:function(value,options,row){
                    var content = "<a class='btn btn-primary' onclick=\"javascript:edit('"+row.id+"')\">修改</a>  "+
                                    "<a class='btn btn-danger' onclick=\"javascript:del('"+row.id+"')\">删除</a>";
                    return content;
                }
              }
          ]
      }).jqGrid("navGrid","#pager",{edit:true,add:true,del:true,search:true,refresh:true});
      //绑定save单击事件
      $("#save").click(function(){
          saveInfo();
      });
      //编辑一行
      $("#edit").click(function () {
          var gr = $("#empTable").jqGrid('getGridParam', 'selrow');
          if (gr != null)
              $("#empTable").jqGrid('editGridRow', gr, {
                  height : 300,
                  reloadAfterSubmit : true
              });
          else
              alert("请选择一行!!!!");
      });

      //删除一行
      $("#del").click(function(){
          var gr = $("#empTable").jqGrid('getGridParam', 'selrow');
          if (gr != null)
              $("#empTable").jqGrid('delGridRow', gr, {
                  reloadAfterSubmit : true
              });
          else
              alert("请选择一行,去删除!!!");
      });
  });
  //封装修改方法
  function edit(id){
      $("#empTable").jqGrid('editGridRow', id, {
          height : 300,
          reloadAfterSubmit : true
          });
  }
  //封装添加方法
  function saveInfo(){
      $("#empTable").jqGrid('editGridRow', "new", {
          height : 300,
          reloadAfterSubmit : true
      });
  }
  //封装删除方法
    function del(id){
        $("#empTable").jqGrid('delGridRow', id, {
            reloadAfterSubmit : true
        });
    }
</script>

<div class="page-header">
    <h1>用户管理</h1>
</div>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a>用户列表</a></li>
    <li role="presentation"><a data-toggle="modal" onclick="javascript:saveInfo();">添加用户</a></li>
</ul>

<!--搜索框-->
<div class="panel panel-default">
    <div class="panel-body">
        <div class="col-sm-10 col-sm-offset-2">
            <form class="form-inline">
                <div class="form-group">
                    <label for="exampleInputName2">姓名</label>
                    <input type="text" class="form-control" id="exampleInputName1" name="name">
                </div>
                <div class="form-group">
                    <label for="exampleInputName2">年龄</label>
                    <input type="text" class="form-control" id="exampleInputName2" name="age">
                </div>
                <div class="form-group">
                    <label for="status" class="control-label">激活状态</label>
                    <select name="status" class="form-control" id="status">
                        <option value="">---请选择---</option>
                        <option value="冻结">冻结</option>
                        <option value="激活">激活</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary " onclick="javascript:findPage(1);">查询</button>
            </form>
        </div>
    </div>
    <!--员工列表-->
    <table class="table table-bordered table-striped" id="empTable">
    </table>
</div>
<!--分页-->
<div id="pager"></div>
<div class="clearfix"></div>


<!--警告框-->
<div class="alert alert-success alert-dismissible" style="display: none;" id="succ">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>
    </button>
    <strong>删除成功！</strong>
</div>
<div class="alert alert-danger alert-dismissible" style="display: none;" id="danger">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>
    </button>
    <strong>删除失败:</strong>java.lang.RuntimeEception:无效数字.
</div>


</body>
</html>