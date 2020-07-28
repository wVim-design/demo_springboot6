<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/2
  Time: 23:11
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
    #userRegForm{
        background-color: #bfc3c6;
        border-radius: 20px;
        text-align: center;

        margin: 0 auto;
        width: 30%;
        height: 480px;
        max-width: 400px;
        min-width: 350px;
        position: relative;
        top: 50%;
        margin-top: -240px;
    }


</style>
<body>
<form id="userRegForm" class="layui-form" lay-filter="userRegDiv" action="">
    <h1>前台用户注册</h1>
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
            <input type="text" name="account" lay-verify="account" autocomplete="off" placeholder="请输入账号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div  class="layui-input-inline">
            <input type="text" id="password" name="password" lay-verify="password"  placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-inline">
            <input type="text" name="confirm" lay-verify="comfirm"  placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <input type="radio" name="sex" value="男" title="男"  checked class="layui-input">
            <input type="radio" name="sex" value="女" title="女" class="layui-input">
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

    <div class="layui-form-item" style="margin-left: -90px">
        <div class="layui-input-block">
            <button  type="button" class="layui-btn" lay-submit="" lay-filter="submitBtn">提交</button>
            <button type="button" class="layui-btn layui-btn-normal" id="setVal">赋值样式</button>
            <button  type="button" class="layui-btn" id="return">返回</button>
        </div>
    </div>


</form>



<script>
    layui.use(["form","layer","jquery"],function () {
        var $ = layui.jquery;
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();

        //两种方式1.使用匿名函数，只要有return就不会提交。2.使用【正则+返回信息】，不符合正则就不提交。
        //除了非空验证外（如只需要lay-verify=required，lay-reqtext=非空提示文本）
        // layui-form还有number、phone、email、url、date、身份证以及结合上述几个规则的多规则验证方法。
        // 除此之外还可以使用lay-verify=“验证名”自定义验证，验证名和number等重复将会重写这些内置的验证方法。
        form.verify({
            name: function(value){
                if(value.length == 0){
                    return '昵称不能为空';
                }
            }
            ,account: function(value){
                if(value.length < 5){
                    return '账号至少得5位数';
                }
                //验证账号重复
                var flag = 1;
                $.ajax({
                    url:path+"/userController/accTest",
                    async:false,
                    data:{"account":value},
                    dataType:"text",
                    success:function(data5){
                        if(data5!=0){
                            flag=2;
                        }
                    },
                    error:function (xhr,textstatus) {
                        layer.alert("错误:"+textstatus, {icon: 2});
                        flag=3;
                    },
                });
                if(flag==2){
                    return '账号重复，无法注册';
                }else if(flag==3){
                    return "服务器错误，无法注册"
                }

            }
            ,password: [
                /^[\S]{3,6}$/
                ,'密码必须3到6位，且不能出现空格'
            ]
            ,comfirm: function(value){
                if(value!==$("#password").val()){
                    return '密码确认错误';
                }
            }
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

        //监听提交,只要设置了lay-submit=“”属性的button/input就会触发验证和submit事件函数，其本身设置的type属性也会触发。
        //注意不要将type设置为submit的button再加上lay-submit,否则将提交两次，不写url的提交将刷新页面。
        //最终由submit事件函数是否return false决定是否提交，其中submitBtn是提交按钮的lay-filter值。
        form.on('submit(submitBtn)', function(data){
            $.ajax({
                url:path+"/userController/register",
                async:true,
                data:{"user":JSON.stringify(data.field)},
                dataType:"text",
                success:function(data5){
                    if(data5==1){
                        layer.alert("注册成功", {icon: 6});
                    }else{
                        layer.alert("注册失败", {icon: 2});
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
            form.val('userRegDiv', {
                "name": "啊k"
                ,"account": "66666"
                ,"password": "123"
                ,"confirm": "123"
                ,"sex": "女"
                ,"phone": "123"
                ,"email": "123"
            });
        });

        $('#return').on('click', function(){
            location.href="${pageContext.request.contextPath}/user/userLoginPage.jsp";
        });




    })


</script>
<input id="path" value="${pageContext.request.contextPath}">
</body>
</html>
