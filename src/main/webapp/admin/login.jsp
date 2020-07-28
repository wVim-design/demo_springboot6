<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/4
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台登录-X-admin2.2</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=no, minimum-scale=1, initial-scale=1,target-densitydpi=low-dpi">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/lib/layui/css/layui.css"><%--用。。有时候行有时不行--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/lib/layui/layui.js" charset="utf-8"></script>
    <!--[if lt IE 9]>
    <![endif]-->
</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">管理员登录</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form" >
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">

        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="button">
        <hr class="hr20" >
    </form>
</div>

<script charset="UTF-8">
    layui.use(['form','layer'], function(){
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();
        form.on('submit(login)', function(data){
            $.ajax({
                url:path+"/adminController/login",
                async:false,
                type:"POST",
                data:"account="+data.field.username+"&password="+data.field.password,
                dataType:"text",
                success:function(data5){
                    console.log(data5);
                    if(data5==2){
                        layer.alert("登陆成功", {icon: 6});
                        location.href='${pageContext.request.contextPath}/admin/index.jsp';
                    }else{
                        layer.alert("登陆失败", {icon: 2});
                    }
                },
                error:function (xhr,textstatus) {
                    layer.alert("错误:"+textstatus, {icon: 2});
                }
            });


        });

    });


</script>
<input id="path" value="${pageContext.request.contextPath}">
</body>
</html>
