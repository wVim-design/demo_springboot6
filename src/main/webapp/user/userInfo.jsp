<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/16
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=no, minimum-scale=0.8, initial-scale=1,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/xadmin.js"></script>
</head>
<body>
<div>
    <div>

        <form id="userInfoForm" class="layui-form" lay-filter="userRegDiv" action="">
            <h1>个人中心</h1>
            <hr class="layui-bg-orange">
            <div class="layui-form-item">
                <label class="layui-form-label">昵称</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" lay-verify="required" autocomplete="off" placeholder="请输入昵称" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                    <input type="text" name="account"  class="layui-input" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码</label>
                <div  class="layui-input-inline">
                    <input type="text"  name="password" lay-verify="password"  placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline">
                    <input type="text" name="sex"  class="layui-input" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机</label>
                <div class="layui-input-inline">
                    <input type="text" name="phone" lay-verify="phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" name="email" lay-verify="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">积分</label>
                <div class="layui-input-inline">
                    <input type="text" name="score"  class="layui-input" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">等级</label>
                <div class="layui-input-inline">
                    <input type="text" name="levelName"  class="layui-input" disabled>
                </div>
            </div>

            <div class="layui-form-item" style="margin-left: -90px">
                <div class="layui-input-block">
                    <button  type="button" class="layui-btn" lay-submit="" lay-filter="submitBtn">提交修改</button>
                </div>
            </div>

        </form>
    </div>
</div>
<script>
    layui.use(['form','table','jquery','layer','laytpl','element'], function(){
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var element = layui.element;
        var path = $("#path").val();

        $(function () {
            $.ajax({
                url:path+"/userController/findUserInfo",
                async:false,
                type:"POST",
                dataType:"text",
                success:function(data5){
                    var userInfo = JSON.parse(data5);
                    $("#userInfoForm").find("input[name=name]").val(userInfo.name);
                    $("#userInfoForm").find("input[name=account]").val(userInfo.account);
                    $("#userInfoForm").find("input[name=password]").val(userInfo.password);
                    $("#userInfoForm").find("input[name=sex]").val(userInfo.sex);
                    $("#userInfoForm").find("input[name=phone]").val(userInfo.phone);
                    $("#userInfoForm").find("input[name=email]").val(userInfo.email);
                    $("#userInfoForm").find("input[name=levelName]").val(userInfo.levelName);
                    $("#userInfoForm").find("input[name=score]").val(userInfo.score);
                    form.render();
                },
            });
        });

        form.verify({
            name: function(value){
                if(value.length == 0){
                    return '昵称不能为空';
                }
            }
            ,password: [
                /^[\S]{3,6}$/
                ,'密码必须3到6位，且不能出现空格'
            ]
            // ,comfirm: function(value){
            //     if(value!==$("#password").val()){
            //         return '密码确认错误';
            //     }
            // }
            ,phone: function(value){
                if(!/^[\S]{3,6}$/.test(value)){
                    return '手机号必须3到6位，且不能出现空格';
                }
            }
            ,email: [
                /^[\S]{3,6}$/
                ,'邮箱必须3到6位，且不能出现空格'
            ]
        });

        form.on('submit(submitBtn)', function(data){
            alert(JSON.stringify(data.field))
            $.ajax({
                url:path+"/userController/modifyMeg",
                async:true,
                data:{"userInfo":JSON.stringify(data.field)},
                success:function(data5){
                    alert(data5);
                },
                error:function (xhr,textstatus) {
                    layer.alert("错误:"+textstatus, {icon: 2});
                },
            });
            return false;
        });

    })
</script>
<input id="path" value="${pageContext.request.contextPath}">

</body>
</html>
