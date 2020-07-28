<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/12
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>文件类型设置</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=no, minimum-scale=1, initial-scale=1,target-densitydpi=low-dpi">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/xadmin.js"></script>
</head>
<body style="background-color: #bfdff6">
<div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">首页</a>
            <a href="">演示</a>
            <a><cite>导航元素</cite></a>
          </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新"><i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">
                    文件类型管理
                </div>
                <div class="layui-card-body ">
                    <form class="layui-form" lay-filter="typeForm">
                        <div class="layui-inline"  style="height: 50px" id="checkboxDiv">
                        </div>
                    </form>
                    <button class="layui-btn layui-inline" type="button"  lay-submit="" lay-filter="go">提交</button>
                    <button class="layui-btn layui-inline" onclick="xadmin.open('添加类型','${pageContext.request.contextPath}/admin/type-add.jsp',600,400)"><i class="layui-icon"></i>增加类型</button>
                    <button class="layui-btn layui-inline" onclick="selectAll()">全选/全不选</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<script>
    //定义全选/全不选事件函数
    function selectAll() {

        if($("#checkboxDiv").find('input:first-child').prop("checked")==true){
            console.log(JSON.stringify($("#checkboxDiv").children('input').get()))
            $("#checkboxDiv").find('input').prop("checked",false);
        }else{
            $("#checkboxDiv").find('input').prop("checked",true);
        }
    }

    layui.use(['form','jquery','layer'], function(){
        var $ = layui.jquery;
        var form = layui.form;
        var layer = layui.layer;

        var path = $("#path").val();

        form.on('submit(go)', function(data){
            var arr = [];
            $("#checkboxDiv").children('input').get().forEach(function (item) {
                var temp = {id:$(item).val(),status:null};
                if($(item).prop('checked')){
                    temp.status='可选';
                }else{
                    temp.status='不可选';
                }
                arr.push(temp);
            });
            $.ajax({
                url:path+"/adminController/changeTypeStatus",
                async:false,
                type:"POST",
                data:{json:JSON.stringify(arr)},
                dataType:"text",
                success:function(data5){
                    if(data5==1)
                    layer.msg("操作成功",{time:1000});
                },
                error:function (xhr,textstatus) {
                    layer.alert("错误:"+textstatus, {icon: 2});
                },
            });
            return false;
        });

        $(function () {
            $.ajax({
                url:path+"/adminController/findFileType",
                async:false,
                type:"POST",
                dataType:"json",
                success:function(data5){
                    console.log(data5);
                    $(data5).get().forEach(function (item) {
                        $("#checkboxDiv").append("<input type='checkbox' name='type' lay-skin='primary' value='"+item.id+"'"+" title='"+item.suffix+"'>");
                        if(item.status=='可选'){
                            $("#checkboxDiv").children('input:last-child').prop("checked",true);
                        }
                    })
                    form.render();
                },
                error:function (xhr,textstatus) {
                    layer.alert("错误:"+textstatus, {icon: 2});
                },
            });
        });

    });

</script>
<input id="path" value="${pageContext.request.contextPath}">
</html>
