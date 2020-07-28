<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/9
  Time: 23:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台主页面</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=no, minimum-scale=1, initial-scale=1,target-densitydpi=low-dpi">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/xadmin.js"></script>
    <script>
        // 是否开启刷新记忆tab功能
        // var is_remember = false;
    </script>
</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="./index.jsp">后台主页面</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
    </div>
<%--    <ul class="layui-nav left fast-add" lay-filter="">--%>
<%--        <li class="layui-nav-item">--%>
<%--            <a href="javascript:;">+新增</a>--%>
<%--            <dl class="layui-nav-child">--%>
<%--                <!-- 二级菜单 -->--%>
<%--                <dd>--%>
<%--                    <a onclick="xadmin.open('最大化','http://www.baidu.com','','',true)">--%>
<%--                        <i class="iconfont">&#xe6a2;</i>弹出最大化</a></dd>--%>
<%--                <dd>--%>
<%--                    <a onclick="xadmin.open('弹出自动宽高','http://www.baidu.com')">--%>
<%--                        <i class="iconfont">&#xe6a8;</i>弹出自动宽高</a></dd>--%>
<%--                <dd>--%>
<%--                    <a onclick="xadmin.open('弹出指定宽高','http://www.baidu.com',500,300)">--%>
<%--                        <i class="iconfont">&#xe6a8;</i>弹出指定宽高</a></dd>--%>
<%--                <dd>--%>
<%--                    <a onclick="xadmin.add_tab('在tab打开','member-list.html')">--%>
<%--                        <i class="iconfont">&#xe6b8;</i>在tab打开</a></dd>--%>
<%--                <dd>--%>
<%--                    <a onclick="xadmin.add_tab('在tab打开刷新','member-del.html',true)">--%>
<%--                        <i class="iconfont">&#xe6b8;</i>在tab打开刷新</a></dd>--%>
<%--            </dl>--%>
<%--        </li>--%>
<%--    </ul>--%>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">admin</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="xadmin.open('个人信息','http://www.baidu.com')">个人信息</a></dd>
                <dd>
                    <a onclick="xadmin.open('切换帐号','http://www.baidu.com')">切换帐号</a></dd>
                <dd>
                    <a href="./login.html">退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index">
            <a href="/">前台首页</a></li>
    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <c:if test="${not empty sessionScope.menuList}">
                <c:forEach var="i" items="${sessionScope.menuList}" >
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="${i.name}">&#xe6b8;</i>
                            <cite>${i.name}</cite>
                            <i class="iconfont nav_right">&#xe697;</i>
                        </a>
                        <ul class="sub-menu">
                            <c:forEach var="j" items="${i.menus}">
                                <li>
                                    <a onclick="xadmin.add_tab('${j.name}','${pageContext.request.contextPath}${j.url}')">
                                        <i class="iconfont">&#xe6a7;</i>
                                        <cite>${j.name}</cite>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
</div>
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
        </ul>
        <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
            <dl>
                <dd data-type="this">关闭当前</dd>
                <dd data-type="other">关闭其它</dd>
                <dd data-type="all">关闭全部</dd>
            </dl>
        </div>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='./welcome.html' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->

</body>


</html>
