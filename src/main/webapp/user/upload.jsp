<%--
  Created by IntelliJ IDEA.
  User: wVim
  Date: 2020/7/20
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>文件上传</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=no, minimum-scale=0.8, initial-scale=1,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/admin/lib/layui/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.1.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/xadmin.js"></script>
</head>
<body>
<div>

<%--    <div class="layui-upload">--%>
<%--        <button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button>--%>
<%--        <button type="button" class="layui-btn" id="test9">开始上传</button>--%>
<%--    </div>--%>

    <div class="layui-upload">
        <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
        <div class="layui-upload-list">
            <table class="layui-table">
                <thead><tr>
                    <th>文件名</th>
                    <th>大小</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr></thead>
                <tbody id="demoList"></tbody>
            </table>
        </div>
        <button type="button" class="layui-btn" id="testListAction">开始上传</button>
    </div>

    </div>
<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label">密码</label>--%>
<%--        <div  class="layui-input-inline">--%>
<%--            <input type="text"  name="password" lay-verify="password"  placeholder="请输入" autocomplete="off" class="layui-input">--%>
<%--        </div>--%>
<%--    </div>--%>
<input type="hidden" id="downloadScore" >
</div>
<script>
    $(function () {
        var path = $("#path").val();
        window.suffixStr="";
        $.ajax({
            url:path+"/adminController/findFileType",
            async:false,
            type:"POST",
            dataType:"json",
            success:function(data5){
                console.log(data5);
                var tempArr = [];
                $(data5).get().forEach(function (item) {
                    if(item.status=="可选"){
                        tempArr.push(item.suffix);
                    }
                });
                suffixStr = tempArr.join("|");
                // alert(suffixStr);
            },
            error:function (xhr,textstatus) {
                alert("类型加载错误:"+textstatus, {icon: 2});
            },
        });
    })

    layui.use(['form','table','jquery','layer','laytpl','upload'], function(){
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var upload = layui.upload;
        var path = $("#path").val();


        upload.render({
            elem: '#testList'
            ,url: path+'/userController/upload' //改成您自己的上传接口
            ,accept: 'myFile'
            ,exts: suffixStr
            ,auto: false
            ,bindAction: '#testListAction'
            // ,data: {//需要上传的额外参数
            //     downloadScore: function(){
            //         return $('#downloadScore').val();
            //     }
            // }
            ,choose: function(obj){//选择后的回调
                obj.preview(function(index, myFile, result){//预读本地文件，如果是多文件，则会遍历，同时定义重传和删除的监听
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ myFile.name +'</td>'
                        ,'<td>'+ (myFile.size/1024).toFixed(1) +'kb</td>'
                        ,'<td>等待上传</td>'
                        ,'<td>'
                        ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                        ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                        ,'</td>'
                        ,'</tr>'].join(''));//jq对象

                    //单个重传，执行upload方法即为重传
                    tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, myFile);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delete files[index]; //删除对应的文件
                        tr.remove();
                        uploadListIns.config.elem.next()[0].value = ''; //清空 input myFile 值，以免删除后出现同名文件不可选
                    });

                    // demoListView.append(tr);
                });
            }
            ,before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。

                $('#downloadScore').val(layer.prompt("请指定该文件的下载积分","0"));
            }
            ,data: {//需要上传的额外参数
                downloadScore: function(){
                   return $('#downloadScore').val();
                }
            }
            ,done: function(res){
                console.log(res)
                if(res.code==0){
                    layer.msg('上传成功');
                }
            }
            ,error: function(){
                //演示失败状态，并实现重传
                layer.msg("上传失败");
            }
        });



        //多文件列表示例
        // var demoListView = $('#demoList');
        //
        // var uploadListIns = upload.render({
        //     elem: '#testList'
        //     ,url: path+'/userController/upload' //改成您自己的上传接口
        //     ,accept: 'myFile'
        //     ,exts: suffixStr
        //     ,multiple: true
        //     ,auto: false
        //     ,bindAction: '#testListAction'
        //     ,choose: function(obj){//选择后的回调
        //         var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
        //
        //         obj.preview(function(index, myFile, result){//预读本地文件，如果是多文件，则会遍历，同时定义重传和删除的监听
        //             var tr = $(['<tr id="upload-'+ index +'">'
        //                 ,'<td>'+ myFile.name +'</td>'
        //                 ,'<td>'+ (myFile.size/1024).toFixed(1) +'kb</td>'
        //                 ,'<td>等待上传</td>'
        //                 ,'<td>'
        //                 ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
        //                 ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
        //                 ,'</td>'
        //                 ,'</tr>'].join(''));//jq对象
        //
        //             //单个重传，执行upload方法即为重传
        //             tr.find('.demo-reload').on('click', function(){
        //                 obj.upload(index, myFile);
        //             });
        //
        //             //删除
        //             tr.find('.demo-delete').on('click', function(){
        //                 delete files[index]; //删除对应的文件
        //                 tr.remove();
        //                 uploadListIns.config.elem.next()[0].value = ''; //清空 input myFile 值，以免删除后出现同名文件不可选
        //             });
        //
        //             demoListView.append(tr);
        //         });
        //     }
        //     ,done: function(res, index, upload){//每个文件提交一次触发一次
        //         if(res.files.myFile){ //上传成功
        //             var tr = demoListView.find('tr#upload-'+ index);
        //             var tds = tr.children();
        //             tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
        //             tds.eq(3).html(''); //清空操作
        //             return delete this.files[index]; //删除文件队列已经上传成功的文件
        //         }
        //         this.error(index, upload);//上传失败调用error回调函数
        //     }
        //     ,error: function(index, upload){//上传失败
        //         var tr = demoListView.find('tr#upload-'+ index);
        //         var tds = tr.children();
        //         tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
        //         tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
        //     }
        // });








    })
</script>
<input id="path" value="${pageContext.request.contextPath}">

</body>
</html>
