<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.goldmsg.gmdoc.entity.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
    + request.getServerName() + ":" + request.getServerPort()
    + path + "/";
%>
    <head>
        <meta http-equiv="content-type" charset="utf-8" >
        <meta name="renderer" content="webkit" >
        <meta name="viewport" content="width=device-width,initial-scale=1.0" >
        <meta http-equiv="x-ua-compatible" content="IE=Edge,Chrome=1" >

        <title>消防文档管理系统</title>

        <!-- 引入bootstrap样式 -->
        <link href="<%=basePath%>content/css/bootstrap.min.css" rel="stylesheet" >

        <!-- 引入字体库 -->
        <link href="<%=basePath%>content/css/font-awesome.min.css" rel="stylesheet" >
        
        <!--引入CSS-->
		<link rel="stylesheet" type="text/css" href="<%=basePath%>content/uilib/webupload/webuploader.css">

        <!-- 自定义样式 -->
        <link href="<%=basePath%>content/css/sy.css" rel="stylesheet" >

        <link id="scrollUpTheme" rel="stylesheet" href="<%=basePath%>content/css/themes/pill.css">
        
        <link rel="stylesheet" type="text/css" href="<%=basePath%>content/upfile/uploadify.css">
        
        <link href="<%=basePath%>content/css/maneger.css" rel="stylesheet" >

        <!-- 引入jquery -->
        <script type="text/javascript" src="<%=basePath%>content/js/jquery-1.12.1.min.js"></script>
        
        <script type="text/javascript" src="<%=basePath%>content/upfile/jquery.uploadify.js"></script>

        <!-- 引入bootstrap脚本 -->
        <script src="<%=basePath%>content/js/bootstrap.js"></script>
        
        <!--引入JS-->
		<script type="text/javascript" src="<%=basePath%>content/uilib/webupload/webuploader.min.js"></script>

        <!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
        <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
        <!--[if lt IE 9]>
        	<script src="<%=basePath%>content/js/html5shiv.min.js"></script>
        	<script src="<%=basePath%>content/js/respond.min.js"></script>
        <![endif]-->

        <script src="<%=basePath%>content/js/jquery.scrollUp1.min.js"></script>
        
        <style>
        	.webuploader-pick{
        		padding: 15px 60px;
        		font-size:24px;
        	}
        </style>
    </head>

    <body>
    <!-- 头 -->
    <%@ include file="/WEB-INF/jsp/header.jsp" %>
    
    <!-- 内容 -->
    <div class="container" style="margin-top: 15px;">
        <div class="row">
            <div class="col-xs-12">
                <ol class="breadcrumb" style="width:400px;">
                    <li><a href="manage.action">文档管理</a></li>
                    <li><a href="upload.action" class="active">文档上传</a></li>
                </ol>
            </div>
            <div class="col-xs-12">
                <h2 style="color:#1aa79b;margin-top: 10px;">上传文档<small> 完成两步, 即可上传文档</small></h2>
            </div>

            <div class="col-xs-12" style="border:1px #cdcdcd solid;min-height: 500px;margin-left: 15px; margin-right: 15px;background-color: #fff;">
                <!--第一步-->
                <div class="container" id="onePage">
                    <div class="row">
                        <div class="col-xs-12 text-center upload-steps">
                            <div class="step-num" style="margin: 10px auto 0;">1</div>
                            <span class="steptip">选择文档</span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-lg-offset-3 text-center col-sm-8 col-sm-offset-2" style="border: 1px dashed #a1a1a1;background-color: #fafafa;height: 200px;padding-top: 50px;">
                            <form enctype="multipart/form-data;charset=utf-8">
                                <div id="queue" style="display: none;"></div>
                                <!--<input id="file_upload" name="file_upload" type="file" multiple="true">-->
                                <div id="picker"><i class="fa fa-sign-out"></i>选择文件</div>	
                            </form>
                            <p style="margin-top: 5px; font-size: 18px;">支持的文件格式: <i class="fa fa-file-word-o"></i>doc   <i class="fa fa-file-excel-o"></i>xls   <i class="fa fa-file-pdf-o"></i></i>pdf   <i class="fa fa-file-powerpoint-o"></i>ppt   <i class="fa fa-file-text-o"></i>text</p>
                        </div>
                    </div>
                </div>

                <!--第二步-->
                <div class="container pagehide" id="twoPage">
                    <div class="row">
                        <div class="col-xs-12 text-center upload-steps">
                            <div class="step-num" style="margin: 10px auto 0;">2</div>
                            <span class="steptip">补充信息</span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12" style="margin-left:-16px;border: 1px #cdcdcd solid;background-color: #fafafa; height: 90px;">
                            <p id="tip-updating" style="float: left;margin-top: 30px;">
                                <span id="span_upding" style="font-size: 20px;"><strong>正在上传文档, 请稍后...</strong><br></span>
                            </p>
                            <p id="tip-upsucess" style="float: left;margin-top: 20px;" class="pagehide">
                                <span style="font-size: 20px;"><strong>请补充文档信息, 完成上传</strong><br></span>
                                <span style="font-size: 15px;">审核通过后, 文档将显示在文档平台中</span>
                            </p>
                            <button id="btn_UpfileInfo" class="btn btn-info btn-lg" style="float: right; margin-top: 22px;"><i class="fa fa-sign-out"></i>确认上传</button>
                        </div>
                    </div>

                    <div class="row" style="padding-top: 30px;padding-bottom: 30px;">
                        <div class="col-md-8 col-md-offset-2">
                            <form class="form-horizontal" role="form">
                                <div class="form-group">
                                    <label for="doc_title" class="col-sm-2 control-label">* 标题</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="doc_title" placeholder="请输入文档标题">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="doc_mark" class="col-sm-2 control-label">  标签</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="doc_mark" placeholder="多个标签用逗号隔开">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="doc_select" class="col-sm-2 control-label">* 分类</label>
                                    <div class="col-sm-5">
                                        <select class="form-control" id="mainselect" name="mainselect"></select>
                                    </div>
                                    <div class="col-sm-5">
                                        <select class="form-control" id="midselect" name="midselect"></select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="doc_secrict" class="col-sm-2 control-label">保密等级</label>
                                    <div class="col-sm-5">
                                        <select class="form-control" id="doc_secrict" name="mainselect">
                                        	<option value="0" >公开</option>
                                        	<option value="1" >敏感</option>
                                        	<option value="2" >秘密</option>
                                        	<option value="3" >机密</option>
                                        	<option value="4" >绝密</option>                                        	
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!--第三步-->
                <div class="container pagehide" id="threePage">
                    <div class="row">
                        <div class="col-xs-12 text-center upload-steps">
                            <div class="step-num" style="margin: 10px auto 0;">3</div>
                            <span class="steptip">完成上传</span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 text-center" style="margin-left:-16px;border: 1px #cdcdcd solid;background-color: #fafafa; padding: 30px;">
                            <h3 style="font-size: 22px; margin-top: 0px;"><i class="fa fa-check-circle fa-lg"></i><strong> 文档上传成功~^_^~</strong><br></h3>
                            <h3 style="font-size: 15px;">审核通过后, 文档将显示在文档平台中</h3>
                            <a href="upload.action" id="btn_goUpfile" class="btn btn-info btn-lg"><i class="fa fa-sign-out"></i>继续上传</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer container-fluid" style="margin-top: 20px;padding-top:20px; padding-bottom: 20px; border-top: 5px solid #d33a3a;">
        <label style="width: 100%; color: #9d9d9d; font-size: 13px; text-align: center;">版权所有© 2016中华人民共和国公安局交通管理局</label><br/>
        <label style="width: 100%; color: #9d9d9d; font-size: 13px; text-align: center;">著作权号: 中华人民共和国国家版权局2011SR012287</label><br/>
        <label style="width: 100%; color: #9d9d9d; font-size: 13px; text-align: center;">技术支持: 广州市国迈科技有限公司 支持电话: 020-2839 8008</label><br/>
        <label style="width: 100%; color: #9d9d9d; font-size: 13px; text-align: center;">软件版本号: V2.2.0 发布日期: 2016-01-01</label><br/>
    </div>

    <!-- IE8 实现输入框未输入时显示提示语句 -->
	<script src="<%=basePath%>content/js/jquery.placeholder.js"></script>
<%--     <script src="<%=basePath%>content/js/docmanage/docupfile.js"></script> --%>
    
    <script>
    	var contextPath = '${pageContext.request.contextPath}';
		var basePath    = "<%=basePath%>";
	    var seesionID   = "${pageContext.session.id}";
        var state = 'pending';
        var uploader;
	
	    $(document).ready(function(){
	    	//initSWF(basePath, seesionID);
	    	
	    	navSelect(1);
	    	
	    	$('input, textarea').placeholder();
	    	
	    	$('#doc_title').keypress(function(e){	
				var specialKey = "\\\/:*?\"< >|";
				var key;
				if(window.event){
				  	key = e.keyCode; 
				} 
				else if(e.which){ 
					key = e.which; 
				} 
		  
				var realkey = String.fromCharCode(key);
				
				if(specialKey.indexOf(realkey) >= 0)
					return false;
			});
	    	
	    	uploader = WebUploader.create({
		        resize: false, // 不压缩image
		        swf: basePath+'content/uilib/webupload/Uploader.swf',// swf文件路径
		        server: '../doc/upfile.action',// 文件接收服务端。 
		        pick: '#picker',// 选择文件的按钮。可选。内部根据当前运行是创建，可能是input元素，也可能是flash.

		        accept: {
		            title: '文档',
		            extensions: 'doc,xls,docx,xlsx,pdf,ppt,pptx',
		            mimeTypes: '.doc,.xls,.docx,.xlsx,.pdf,.ppt,.pptx'
		        }
		    });
		    
    		// 当有文件添加进来的时候
		    uploader.on( 'fileQueued', function( file ) {
		        var point = file.name.lastIndexOf("."); 
			    var filename = file.name.substr(0, point); 
				$("#doc_title").val(filename);    
				$("#onePage").addClass("pagehide");
				$("#twoPage").removeClass("pagehide");
				
				uploader.upload();
		    });

		    // 文件上传过程中创建进度条实时显示。
		    uploader.on( 'uploadProgress', function( file, percentage ) {
		    	$('#span_upding').val("正在上传文档，请稍候..."+percentage*100+" %");
		    });

		    uploader.on( 'uploadSuccess', function( file ) {
		        $("#tip-updating").addClass("pagehide");
				$("#tip-upsucess").removeClass("pagehide");
				
				$(this).prop('disabled', false);
		    });

		    uploader.on( 'uploadError', function( file ) {
		        $('#span_upding').val("文档上传失败，请检查网络是否通畅并重试！");
		    });

		    uploader.on( 'uploadComplete', function( file ) {
		    });

		    uploader.on( 'all', function( type ) {
		        if ( type === 'startUpload' ) {
		            state = 'uploading';
		            $(this).prop('disabled', true);
		        } else if ( type === 'stopUpload' ) {
		            state = 'paused';
		        } else if ( type === 'uploadFinished' ) {
		            state = 'done';
		        }
		    });
	    });
		
		function navSelect(index)
		{
		    $("#nar_mian").children().removeClass("nav-current");
		    $("#nar_mian").children("li:eq("+index+")").addClass("nav-current");
		}

        $("#btn_UpfileInfo").click(function () {
        	if($("#doc_title").val().length == 0){
    			alert("请先填写标题");
    			$("#doc_title").focus();
    			return;
    		}
        	
        	if(!$("#midselect").val()){
    			alert("请选择一个子分类");
    			$("#midselect").focus();
    			return;
    		}
        	
        	$("#btn_UpfileInfo").button('处理中');
        	
        	var pData = {
	    			"doc_title": $("#doc_title").val(),
	    			"doc_label": $("#doc_mark").val(),
	    			"cato_id"  : parseInt($("#midselect").val()), 
	    			"security_level" : parseInt($("#doc_secrict").val())
	            }; 
	        
	        $.ajax({
	            url : contextPath + "/doc/commit.action",
	            type : "post",
	            contentType: "application/json",
	            data : JSON.stringify(pData),
	            async : false,
	            cache : false,
	            error : function(msg) {
	            	alert("error");
	            },
	            success : function(msg)
	            {
	            	$("#doc_title").val("");   
	            	$("#doc_mark").val("");
		        	$("#onePage").addClass("pagehide");
		        	$("#twoPage").addClass("pagehide");
		        	$("#threePage").removeClass("pagehide");
		            $("#tip-updating").removeClass("pagehide");
		        	$("#tip-upsucess").addClass("pagehide");
	            },
	            complete : function() {
	            	$("#btn_UpfileInfo").button('reset');
	            }
	        });   	
        }); 
        
        $("#btn_goUpfile").click(function () {
        	$("#onePage").removeClass("pagehide");
        	$("#twoPage").addClass("pagehide");
        	$("#threePage").addClass("pagehide");
        });
        
        
        window.onbeforeunload = function(){
			   if($("#twoPage").hasClass("pagehide"))
		   		   return;
			   else
				   return "必您确定要退出页面吗？";
		   }
        
        window.onunload= function(){
            if($("#twoPage").hasClass("pagehide"))
                return;
            else
                $.get(contextPath+"/doc/cancel.action");
        }
        
	    var threeSelectData = {cato_name:"请选择", cato_id:-1, children:{cato_name:"请选择", cato_id:-1}};
    	$.ajax({
    	        url : basePath + "/cato/myCatoList.action",
    	        type : "get",
    	        data : null,
    	        async : false,
    	        error : function() {
    	            alert("服务器出错~");
    	        },
    	        cache : false,
    	        success : function(msg) 
    	        {
    	            if (msg.headers.ret == 0)
    	            	threeSelectData = msg.body;
    	        }
    	    });
   		 
    	var defaults = {
    		s1:'mainselect',
    		s2:'midselect',
    	};

    	$(function(){
    		threeSelect(defaults);
    	});

    	function threeSelect(config)
    	{
    		var $s1=$("#"+config.s1);
    		var $s2=$("#"+config.s2);
    		var v1=config.v1?config.v1:null;
    		var v2=config.v2?config.v2:null;
    		$.each(threeSelectData,function(k,v){
    			appendOptionTo($s1,k,v,v1);
    		});
    		
    		$s1.change(function(){
    			$s2.html("");
    			if(this.selectedIndex==-1)
    				return;
    			
    			var s1_curr_val = this.options[this.selectedIndex].value;
    			
    			$.each(threeSelectData, function(k,v)
    			{
    				if(s1_curr_val==v.cato_id)
    				{
    					if(v.children)
    					{
    						$.each(v.children,function(k,v)
    						{
    							appendOptionTo($s2,k,v,v2);
    						});
    					}
    				}
    			});
    		
    			if($s2[0].options.length==0){
    				appendOptionTo($s2,"...","",v2);
    			}
    		}).change();
    		
    		function appendOptionTo($o,k,v,d)
    		{
    			var $opt=$("<option>").text(v.cato_name).val(v.cato_id);
    			
    			if(v==d)
    			{
    				$opt.attr("selected", "selected")
    			}
    			
    			$opt.appendTo($o);
    		}
    	}
	    </script>
    </body>
</html>