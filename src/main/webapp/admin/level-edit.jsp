<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/13
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.2</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/xadmin.js"></script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form" lay-filter="formTest">
            <div class="layui-form-item layui-hide">
                <label for="id" class="layui-form-label">等级id</label>
                <div class="layui-input-inline"><input type="text" id="id" name="id" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="name" class="layui-form-label">等级名称</label>
                <div class="layui-input-inline"><input type="text" id="name" name="name" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="upRatio" class="layui-form-label">上传比例</label>
                <div class="layui-input-inline"><input type="text" id="upRatio" name="upRatio" lay-verify="required|number" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="downRatio" class="layui-form-label">下载比例</label>
                <div class="layui-input-inline"><input type="text" id="downRatio" name="downRatio" lay-verify="required|number" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="maxScore" class="layui-form-label">最大值</label>
                <div class="layui-input-inline"><input type="text" id="maxScore" name="maxScore" lay-verify="integer" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                 <label for="minScore" class="layui-form-label">最小值</label>
                 <div class="layui-input-inline"><input type="text" id="minScore" name="minScore" lay-verify="integer" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <button type="button" class="layui-btn" lay-filter="edit" lay-submit="">确认修改</button>
            </div>
        </form>
    </div>
</div>
<script>
    layui.use(['form', 'layer','jquery'], function() {
        var $ = layui.jquery;
        var form = layui.form;
        var  layer = layui.layer;
        var path =$("#path").val();

        form.verify({
            integer: function(value){ //value：表单的值、item：表单的DOM对象
                if(!/^(0|[1-9]\d*)$/.test(value)){
                    return '分数必须是非负整数';
                }
            },
        });

        //监听提交
        form.on('submit(edit)', function(data) {
            console.log(JSON.stringify(data.field));
            $.ajax({
                url:path+"/adminController/editLevel",
                async:false,
                type:"POST",
                data:{json:JSON.stringify(data.field)},
                dataType:"text",
                success:function(data5){
                    console.log(data5);
                    if(data5==1){
                        layer.alert("修改成功", {icon: 6}, function() {
                            //关闭当前frame
                            xadmin.close();
                            // 可以对父窗口进行刷新
                            xadmin.father_reload();
                        });
                    }
                },
                error:function (xhr,textstatus) {
                    layer.alert("错误:"+textstatus, {icon: 2});
                },
            });
            return false;
         });

        $(function () {
            form.val("formTest", {
                "id": parent.tempData.id
                ,"name": parent.tempData.name
                ,"upRatio":  parent.tempData.upRatio
                ,"downRatio":  parent.tempData.downRatio
                ,"maxScore": parent.tempData.maxScore
                ,"minScore": parent.tempData.minScore
            });

        })

    });
</script>

</body>
<input id="path" value="${pageContext.request.contextPath}">
</html>
