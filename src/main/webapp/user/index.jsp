<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/14
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>文档共享系统</title>
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/index_files/global.css" media="all">
    <link id="layuicss-skincodecss" rel="stylesheet" href="${pageContext.request.contextPath}/user/index_files/code.css" media="all">
<%--    <link rel="preload" href="${pageContext.request.contextPath}/user/index_files/f.txt" as="script">--%>
<%--    <script type="text/javascript" src="${pageContext.request.contextPath}/user/index_files/f.txt"></script>--%>
    <script src="${pageContext.request.contextPath}/user/layui/layui.js"></script>
</head>
<style>
    #k1{
        height: 864px;
        background-image: url('${pageContext.request.contextPath}/user/bg1.jpg');
        background-repeat: no-repeat;
    }
    #k2 *{
        background-color: transparent;
        text-align: center;
    }
</style>

<body class="site-home" id="LAY_home" >
<div class="layui-header header header-index">
    <div class="layui-main">
        <a class="logo" href="" style="font-size: 20px;color: #01AAED">文档共享平台</a>
        <ul class="layui-nav" lay-shrink="all" lay-filter="navi" style="text-align: right">
            <li class="layui-nav-item layui-this"><a href="javascript:;">文件搜索/下载</a></li>
            <li class="layui-nav-item"><a href="javascript:;">文件上传</a></li>
            <li class="layui-nav-item"><a href="javascript:;">我的上传列表</a></li>
            <li class="layui-nav-item"><a href="javascript:;">积分明细</a></li>
            <li class="layui-nav-item"><a href="javascript:;">我的信息</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">个人中心</a>
                <dl class="layui-nav-child layui-anim layui-anim-upbit" style="left: auto; right: -22px; text-align: center;"> <!-- 二级菜单 -->
                    <dd><a href="javascript:;">我的账户</a></dd>
                    <dd><a href="javascript:;">注销</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>

<div class="layui-fluid" id="k1">
    <div><iframe src="" id="myIframe" style="width: 100%;height: 500px"></iframe></div>
<%--    <div class="layui-row layui-col-offset1">--%>
<%--        <div class="layui-col-md11" id="k2" style="margin-top: 100px;he">--%>
<%--            --%>
<%--        </div>--%>
<%--    </div>--%>
</div>


</body>
<script>
    layui.use(['form','table','jquery','layer','laytpl','element'], function(){
        var $ = layui.jquery;
        var layer = layui.layer;
        var element = layui.element;
        var path = $("#path").val();

        element.on('nav(navi)', function(elem){
            // console.log(elem.innerHTML);
            // console.log(elem.innerText);
            if($(elem).text()=="文件搜索/下载"){
                $("#myIframe").attr("src","${pageContext.request.contextPath}/user/file-list.jsp") ;
            }else if($(elem).text()=="文件上传"){
                $("#myIframe").attr("src","${pageContext.request.contextPath}/user/upload.jsp") ;
            }else if($(elem).text()=="我的上传列表"){
                $("#myIframe").attr("src","${pageContext.request.contextPath}/user/upload-list.jsp");
            }else if($(elem).text()=="积分明细"){
                $("#myIframe").attr("src","${pageContext.request.contextPath}/user/score-list.jsp") ;
            } else if($(elem).text()=="我的信息"){
                $("#myIframe").attr("src","${pageContext.request.contextPath}/user/userInfo.jsp") ;
            }
        });

        $(function () {
            $("#myIframe").attr("src","${pageContext.request.contextPath}/user/file-list.jsp");
        })
    })
</script>
<input id="path" value="${pageContext.request.contextPath}">
</html>
