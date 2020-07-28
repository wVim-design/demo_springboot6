<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/2
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/user/layui/layui.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/layui/css/layui.css">
    <meta name="viewport" content="width=device-width,user-scalable=no, minimum-scale=1, initial-scale=1,target-densitydpi=low-dpi">
</head>
<style>
    body{
        width: 100%;
        height: 100%;
    }
    #userLoginForm{
        background-color: #bfc3c6;
        border-radius: 20px;
        text-align: center;

        margin: 0 auto;
        width: 30%;
        height: 220px;
        max-width: 400px;
        min-width: 350px;
        position: relative;
        top: 50%;
        margin-top: -110px;
    }


</style>
<body>
<form id="userLoginForm" class="layui-form" lay-filter="userLoginDiv" action="">
    <h1>前台用户登陆</h1>
    <hr class="layui-bg-orange">
    <div class="layui-form-item">
        <label class="layui-form-label">账号</label>
        <div class="layui-input-inline">
            <input type="text" name="account" lay-verify="required" lay-reqtext="账号不能为空" autocomplete="off" placeholder="请输入账号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div  class="layui-input-inline">
            <input type="text" id="password" name="password" lay-verify="required" lay-verify="密码不能为空"  placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item" style="margin-left: -97px">
        <div class="layui-input-block">
            <button  type="button" class="layui-btn" lay-submit="" lay-filter="submitBtn">登陆</button>
            <button type="button" class="layui-btn layui-btn-normal" id="setVal">赋值样式</button>
            <button  type="button" class="layui-btn" id="return">去注册</button>
        </div>
    </div>


</form>



<script>
    layui.use(["form","layer","jquery"],function () {
        var $ = layui.jquery;
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();


        form.on('submit(submitBtn)', function(data){
            $.ajax({
                url:path+"/userController/login",
                async:true,
                type:"get",
                data:"account="+data.field.account+"&password="+data.field.password,
                dataType:"text",
                success:function(data5){
                    console.log(data5);
                    if(data5==2){
                        // layer.alert("登陆成功", {icon: 6});
                        location.href="${pageContext.request.contextPath}/user/index.jsp";
                    }else{
                        layer.alert("登陆失败", {icon: 2});
                    }
                },
                error:function (xhr,textstatus) {
                    layer.alert("错误:"+textstatus, {icon: 2});
                },
            });
            return false;
        });

        //表单赋值，其中userRegDiv是表单的lay-filter值
        $('#setVal').on('click', function(){
            form.val('userLoginDiv', {
                "account": "1001"
                ,"password": "1001"
            });
        });

        $('#return').on('click', function(){
            location.href="${pageContext.request.contextPath}/user/userRegPage.jsp";
        });




    })


</script>



<input id="path" value="${pageContext.request.contextPath}">
</body>
</html>
