<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.goldmsg.gmdoc.entity.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
	<%
	  String path = request.getContextPath();
	  String basePath = request.getScheme() + "://"
	    + request.getServerName() + ":" + request.getServerPort()
	    + path + "/";
	 %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,Chrome=1">

    <title>消防文档管理系统</title>

    <link href="<%=basePath%>content/css/bootstrap.min.css" rel="stylesheet" >
    <link href="<%=basePath%>content/css/font-awesome.min.css" rel="stylesheet" >
    <link href="<%=basePath%>content/css/sy.css" rel="stylesheet" >
    <link href="<%=basePath%>content/css/maneger.css" rel="stylesheet" >
    <link href="<%=basePath%>content/uilib/artDialog/css/ui-dialog.css" rel="stylesheet">

	<!-- 引入jquery -->
    <script src="<%=basePath%>content/js/jquery-1.12.1.min.js"></script>

    <!-- 引入bootstrap脚本 -->
    <script src="<%=basePath%>content/js/bootstrap.js"></script>

    <!-- IE8 实现输入框未输入时显示提示语句 -->
    <script src="<%=basePath%>content/js/jquery.placeholder.js"></script>

    <!--[if lt IE 9]>
    	<script src="<%=basePath%>content/js/html5shiv.min.js"></script>
    	<script src="<%=basePath%>content/js/respond.min.js"></script>
    <![endif]-->
    
    <style>
		.table > tbody > tr{
            line-height: 32px;
        }
        
        .table > tbody > tr > td > a{
            padding: 0px 0px;
        }
        
        .table > tbody > tr > td{
        	vertical-align: middle;
		} 
	</style>
	
	<script type="text/javascript" src="<%=basePath%>content/uilib/artDialog/dist/dialog-min.js"></script>
    <script type="text/javascript" src="<%=basePath%>content/uilib/artDialog/util/dialogUtil.js"></script>
    
    <script>
    	icon_base_path = "<%=basePath%>content/uilib/artDialog/";
    </script>
    
    <script src="<%=basePath%>content/js/docmanage/docmanager.js"></script>
</head>
	<!-- 头 -->
	<%@ include file="/WEB-INF/jsp/header.jsp" %>
	
    <!-- 内容 -->
    <div class="container" style="margin-top: 15px;">
        <div class="row">
            <div class="col-lg-3 col-xs-12">
                <div style="background-color: #EDEDED; height: 42px;border: 1px solid #D1D1D1;">
                    <h5 style="padding-left: 5px;"><strong>文档分类</strong></h5>
                </div>

                <div style="background-color: #FFF;border: 1px solid #D1D1D1;border-top:none;">
                    <ul id="cato_list" class="list-unstyled list-classify">
                        <li><a href="#" class="classifyactive"><input type="text" value="-1" class="hidden"/><strong>所有分类</strong></a></li>
                        <c:forEach items="${catoList}" var="map" varStatus="i">
                        	<li><p><strong>${map.cato_name}</strong></p>
                        		<ul class="list-inline">
            			<c:choose>
			            	<c:when test="${empty map.children}">
			            		</ul>
			            	</c:when>
			            	<c:when test="${not empty map.children}">
			            		<c:forEach items="${map.children}" var="child">
						            <li><a href="#"><input type="text" value="${child.cato_id}" class="hidden"/>${child.cato_name}</a></li>
			            		</c:forEach> 
			            	</ul>
			            	</c:when>
				        </c:choose>
				        </li>
                        </c:forEach>
                   	</ul>
                </div>
            </div>

            <div class="col-lg-9 col-xs-12">
                <div style="background-color: #FFF; height: 60px;border: 1px solid #D1D1D1;margin-bottom: 10px;">
                    <a href="upload.action" class="btn btn-danger" style="margin-top: 12px; margin-left: 10px;">文档上传</a>
                </div>

                <div style="background-color: #FFF;border: 1px solid #D1D1D1;margin-bottom: 10px;">
                    <!--<div class="btn-group btn-group-justified" style="padding: 5px;" data-toggle="buttons">
                        <label class="btn btn-danger" style="margin-right:5px;">
                            <i class="fa fa-arrow-right"></i>
                            <input type="radio" name="options" id="option1"> 所有状态
                        </label>
                        <label class="btn btn-danger">
                            <input type="radio" name="options" id="option2"> 已发布
                        </label>
                        <label class="btn btn-danger">
                            <input type="radio" name="options" id="option3"> 审核中
                        </label>
                        <label class="btn btn-danger">
                            <input type="radio" name="options" id="option4"> 被回退
                        </label>
                    </div>-->

                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                                <th class="text-center" style="color: #949494;">文档标题</th>
                                <th class="text-center" style="color: #949494;">上传时间</th>
                                <th class="text-center" style="color: #949494;">状态</th>
                                <th class="text-center" style="color: #949494;">操作</th>
                            </thead>
                            <tbody id="tbody_list">
                                <!-- <tr>
                                    <td><i class="fa fa-file-word-o"></i> 社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-pdf-o"></i> 社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #FFD46F;">审核中</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i> 社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #ff0000;">被退回</td>
                                    <td class="text-center">
                                        <a href="#">查看</a>
                                        <a href="#">编辑</a>
                                        <a href="#">删除</a>
                                        <a href="#">更改分类</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i>社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #ff0000;">被退回</td>
                                    <td class="text-center">
                                        <a href="#">查看</a>
                                        <a href="#">编辑</a>
                                        <a href="#">删除</a>
                                        <a href="#">更改分类</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i> 社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i> 社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i> 社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i>社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i>社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i>社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i>社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr>
                                <tr>
                                    <td><i class="fa fa-file-word-o"></i>社会主义核心价值观</td>
                                    <td class="text-center">2016-03-28</td>
                                    <td class="text-center" style="color: #5CFF77;">已发布</td>
                                    <td class="text-center"><a href="#">查看</a></td>
                                </tr> -->
                            </tbody>
                        </table>
                    </div>
                    <div class="text-center">
                         <ul class="pager">
			                <li class="li-pre disabled"><a href="javascript:void(0);" id="pre-page">上一页</a></li>
			                <li class="li-next disabled"><a href="javascript:void(0);" id="next-page">下一页</a></li>
			            </ul>
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
</body>
</html>