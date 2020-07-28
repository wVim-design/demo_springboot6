<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/7
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台用户管理</title>
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
        <div class="layui-col-md12 ">
            <div class="layui-card">
                <div class="layui-card-header">
                    后台用户管理
                </div>
                <div class="layui-card-body">
                    <table id="list" lay-filter="test"></table>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
<script>


    layui.use(['table','jquery'], function(){
        var $ = layui.jquery;
        var table = layui.table;

        table.render({
            elem: '#list'
            ,height: 350
            ,url: '${pageContext.request.contextPath}/adminController/findAdminList' //数据接口
            ,method:'get'
            ,request: {
                pageName: 'curPage' //改变页码的参数名称，默认：page，接在url后
                ,limitName: 'pageSize' //改变每页数据量的参数名，默认：limit，接在url后
            }
            ,page: { //可以是boolean值，也支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem,这两个参数需要将table模块的page设为false，单独使用laypage模块并render）
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip','refresh'] //自定义分页布局排版
                ,limit:6 //每页显示6条数据
                ,limits:[3,6,9,12,15,20]//可选每页分页数
                ,curr: 1 //设定初始在第 1 页
                ,groups: 3 //只显示 3 个连续页码
                ,first: '到首页' //显示首页
                ,last: '到尾页' //显示尾页
                ,theme: '#ccc75e'//主题颜色
            }
            ,response: {
                // statusName: 'status' //改变数据状态的字段名称，默认：code
                // ,statusCode: 200 //改变成功的状态码，默认：0
                // ,msgName: 'hint' //改变状态信息的字段名称，默认：msg
                // ,countName: 'total' //改变数据总数的字段名称，默认：count
                // ,dataName: 'rows' //改变数据列表的字段名称，默认：data
             }
            ,parseData: function(res){ //res 即为原始返回的数据
                console.log(res);
                return {
                    "code": res.code, //解析数据接口返回状态
                    "msg": "", //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data //解析数据列表[]
                };
            }
            ,cols: [[ //表头
                {field: 'id', title: 'id', width:160, sort: true}
                ,{field: 'account', title: '账号', width:160, sort: true}
                ,{field: 'name', title: '名称', width:160, sort: true}
                ,{field: 'roleName', title: '角色', width:160, sort: true}
            ]]
        });

    });
</script>
<input id="path" value="${pageContext.request.contextPath}">

</html>
