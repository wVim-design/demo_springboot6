<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/21
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的上传列表</title>
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
<%--    <form class="layui-form" lay-filter="formTest">--%>
<%--        <div class="layui-block">--%>
<%--            <input type="text" name="name"  placeholder="请输入文件名称" autocomplete="off" class="layui-input" style="width: 600px;border: solid black 1px;margin: 20px auto;display: inline;text-align: left">--%>
<%--            <button type="button"  class="layui-btn" title="搜索(鼠标放上去的提示)" lay-submit=""  lay-filter="go" style="border: solid black 1px;display: inline">搜索</button>--%>
<%--        </div>--%>
<%--    </form>--%>
    <table id="list" lay-filter="test" style="background-color: rgba(255,255,225,0.3);border: solid black 1px"></table>
</div>




<script>
    layui.use(['form','table','jquery','layer','laytpl','laydate'], function(){
        var $ = layui.jquery;
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        var laydate = layui.laydate;
        var laytpl = layui.laytpl;
        var statusParams = null;//保存状态的数值-文字键值对

        var path = $("#path").val();




        var tableIns = table.render({
            elem: '#list'//容器id
            ,id:'idTest'//结合checkStatus使用
            ,height: 350
            ,url: '${pageContext.request.contextPath}/userController/findMyFileList' //数据接口
            ,method:'get'
            ,where: {}//查询条件
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
                statusParams=res.paramsList;//res的一个自定义的属性
                return {
                    "code": res.code, //解析数据接口返回状态
                    "msg": "", //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data //解析数据列表[]
                };
            }
            ,cols: [[ //表头
                { width:40, type:'checkbox'}//选择列，有选中的行才能通过checkStatus得到值
                ,{field: 'id', title: 'ID', width:80, sort: true}
                ,{field: 'name', title: '文件名称', width:180, sort: true}
                // ,{field: 'userName', title: '上传者', width:100, sort: true}
                ,{field: 'uploadTime', title: '上传时间', width:160, sort: true}
                ,{field: 'suffix', title: '文件类型', width:120, sort: true}
                ,{field: 'downloadTimes', title: '下载次数', width:120, sort: true}
                ,{field: 'downloadRank', title: '下载排名', width:120, sort: true}
                ,{field: 'statusName', title: '状态', width:100, sort: true}
                // ,{field: 'operation', title: '操作', width:250, sort: true,align:'center',toolbar: '#barDemo'}
            ]]
        });

        // form.on('submit(go)',function (data) {
        //     //可设定异步数据接口的所有参数，如果不进行任何设置原参数会被保留，相当于做一次表格刷新
        //     // 如果设置的参数和原参数冲突将会覆盖
        //     // 翻页只会修改curr参数，不会修改其它任何参数
        //     tableIns.reload({
        //         where: {
        //             name: data.field.name
        //             ,startTime: data.field.startTime
        //             ,endTime: data.field.endTime
        //             ,typeId: $("select[name=type]").children(":selected").val()
        //         }
        //         ,page: {
        //             curr: 1 //重新从第 1 页开始
        //         }
        //     });
        //     return false;
        // });


        // table.on('tool(test)', function(obj){ //注：tool 显示是工具条的事件名，test 是 table的lay-filter=属性值
        //     var data = obj.data; //获得当前行数据
        //     var layEvent = obj.event; //获得 lay-event 对应的自定义事件名（也可以是表头的 event 参数对应的事件名）
        //     var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
        //
        //     if(layEvent!='下载'){
        //         var statusId = null;
        //         for(var i=0;i<statusParams.length;i++){
        //             if(statusParams[i].name==layEvent){
        //                 statusId=statusParams[i].value;
        //                 break;
        //             }
        //         }
        //
        //         $.ajax({
        //             url:path+"/adminServlet?methodName=changeFileStatus",
        //             async:false,
        //             type:"POST",
        //             data:"id="+data.id+"&statusId="+statusId,
        //             dataType:"text",
        //             success:function(data5){
        //                 console.log(data5);
        //                 if(data5!="成功"){
        //                     layer.msg("操作失败",{time:1000});
        //                 }else{
        //                     layer.msg("操作成功",{time:1000});
        //                     tableIns.reload();
        //                 }
        //             },
        //             error:function (xhr,textstatus) {
        //                 layer.alert("错误:"+textstatus, {icon: 2});
        //             },
        //         });
        //     }
        //
        // });
        //
        //
        //
        // $(function () {
        //     $.ajax({
        //         url:path+"/adminServlet?methodName=findFileType",
        //         async:false,
        //         type:"POST",
        //         datatype:"text",
        //         success:function(data5){
        //             $("select[name=type]").append("<option value=''>文件类型</option>")
        //             JSON.parse(data5).forEach(function (item) {
        //                 $("select[name=type]").append("<option value='"+item.id+"'>"+item.suffix+"</option>")
        //             });
        //             form.render();
        //         },
        //     });
        // })

    });
</script>

</body>
</html>
