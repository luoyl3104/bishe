<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
  $(function () {

    initData();

  });

  function initData(page,content) {
      $.post("${app}/comment/queryByPage",{page:page,content:content},function (result) {
          $("#tbody").empty();
          $("#pager").empty();
          var comments = result.comments;
          if(comments.length == 0){
              alert("没有检索到结果哦~！");
          }else {
              $.each(comments,function (i, comment) {
                  var tr = $("<tr/>");
                  var nameTd = $("<td/>").text(comment.content);
                  var typeTd = $("<td/>").text(comment.user.username);
                  var sexTd = $("<td/>").text(comment.view.name);
                  var phoneTd = $("<td/>").text(comment.publishDate);
                  var delBtn = $("<button onclick='javascript:del("+comment.id+")'/>").addClass("btn btn-danger");
                  var delSpan = $("<span class='glyphicon glyphicon-remove' aria-hidden='true'/>");
                  delBtn.html(delSpan);
                  var optionTd = $("<td/>");
                  optionTd.append("&nbsp;").append(delBtn);
                  tr.append(nameTd).append(typeTd).append(sexTd).append(phoneTd).append(optionTd);
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
      $.post("${app}/comment/remove",{id:id},function () {
          alert("删除成功~！");
          initData();
      })
  }

  function search(page) {
      var content = $("#content").val();
      initData(page,content);
  }


</script>

<div class="page-header">
    <h1>评论管理</h1>
</div>
<ul class="nav nav-tabs">
    <li role="presentation" class="active"><a>评论列表</a></li>
</ul>

<div class="panel panel-default">

    <%--搜索框--%>
    <div class="panel-body">
        <div class="col-sm-10 col-sm-offset-4">
            <form class="form-inline">
                <div class="form-group">
                    <label for="content">请输入关键字</label>
                    <input type="text" placeholder="输入评论关键字即可" class="form-control" id="content" name="content">
                </div>
                <button type="button" class="btn btn-primary " onclick="javascript:search();">查询</button>
            </form>
        </div>
    </div>

    <!--表-->
    <table class="table table-bordered table-striped" id="commentTable">

        <thead>
        <tr>
            <th>评论内容</th>
            <th>评论发布者</th>
            <th>评论景点</th>
            <th>评论发表时间</th>
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