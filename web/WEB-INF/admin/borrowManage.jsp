<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-CN" class="ax-vertical-centered">
<head>
    <meta charset="UTF-8">
    <title>武汉理工大学图书馆管理系统后台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-admin-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-admin-theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/jQuery/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-dropdown.min.js"></script>

    <script src="${pageContext.request.contextPath}/ajax-lib/ajaxutils.js"></script>
    <script src="${pageContext.request.contextPath}/js/adminUpdateInfo.js"></script>
    <script src="${pageContext.request.contextPath}/js/adminUpdatePwd.js"></script>
    <script src="${pageContext.request.contextPath}/js/getBorrowInfo.js"></script>
    <script src="${pageContext.request.contextPath}/js/borrowBook.js"></script>
</head>


<script src="${pageContext.request.contextPath}/jQuery/jquery-3.1.1.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>


<body class="bootstrap-admin-with-small-navbar">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <button type="button" class="navbar-toggle"  data-target=".navbar-collapse">
            <script type="text/javascript">
                $(".navbar-toggle").click(function(){
                    $(".navbar-collapse").toggle();
                });
            </script>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/admin.jsp"><strong>WHUT图书管理系统</strong></a>
        <div class="navbar-collapse nav-collapse collapse navbar-header pull-right">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" data-hover="dropdown">欢迎您，<s:property value="#session.admin.name"/> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                        <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/adminLoginAction_logout.action">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <!-- left, vertical navbar & content -->
    <div class="row">
        <div id="wrapper">
            <div class="overlay"></div>

            <!-- Sidebar -->
            <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
                <ul class="nav sidebar-nav">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/bookManageAction_findBookByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 图书管理</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/bookTypeManageAction_findBookTypeByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 图书分类管理</a>
                    </li>
                    <li class="active">
                        <a href="${pageContext.request.contextPath}/admin/borrowManageAction_findBorrowInfoByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 图书借阅</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/backManageAction_findBackInfoByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 图书归还</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/borrowSearchAction_findBackInfoByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 借阅查询</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/forfeitManageAction_findForfeitInfoByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 逾期处理</a>
                    </li>
                    <s:if test="#session.admin.authorization.superSet==1"><!-- 对超级管理员和普通管理员进行权限区分 -->
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/adminManageAction_findAdminByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 管理员管理</a>
                    </li>
                    </s:if>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/readerManageAction_findReaderByPage.action"><i class="glyphicon glyphicon-chevron-right"></i> 读者管理</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/readerTypeManageAction_getAllReaderType.action"><i class="glyphicon glyphicon-chevron-right"></i> 系统设置</a>
                    </li>
                </ul>
            </nav>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
                    <span class="hamb-top"></span>
                    <span class="hamb-middle"></span>
                    <span class="hamb-bottom"></span>
                </button>
            </div>
            <!-- /#page-content-wrapper -->

            <script type="text/javascript">
                $(document).ready(function () {
                    var trigger = $('.hamburger'),
                        overlay = $('.overlay'),
                        isClosed = false;

                    trigger.click(function () {
                        hamburger_cross();
                    });

                    function hamburger_cross() {

                        if (isClosed == true) {
                            overlay.hide();
                            trigger.removeClass('is-open');
                            trigger.addClass('is-closed');
                            isClosed = false;
                        } else {
                            overlay.show();
                            trigger.removeClass('is-closed');
                            trigger.addClass('is-open');
                            isClosed = true;
                        }
                    }

                    $('[data-toggle="offcanvas"]').click(function () {
                        $('#wrapper').toggleClass('toggled');
                    });
                });
            </script>
        </div>
        <!-- /#wrapper -->

        <!-- content -->
        <div class="col-xs-12 col-lg-11 pull-right">
            <div class="row">
                <div class="col-lg-11">
                    <div class="panel panel-default bootstrap-admin-no-table-panel">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">借书</div>
                        </div>
                        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                            <form class="form-horizontal">
                                <div class="row">
                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="borrow_sno"><label
                                                class="text-danger">*&nbsp;</label>证件号</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="borrowReaderPaperNO"
                                                   name="borrowReaderPaperNO" type="text" value=""
                                                   placeholder="请输入读者证件号">
                                            <label class="control-label" for="borrow_sno" style="display: none"></label>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="borrow_bno"><label
                                                class="text-danger">*&nbsp;</label>图书ISBN号</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="borrowBookISBN" name="borrowBookISBN"
                                                   type="text" value="" placeholder="请输入借阅图书的ISBN号">
                                            <label class="control-label" for="borrow_bno" style="display: none"></label>
                                        </div>
                                    </div>

                                    <div class="col-lg-5 form-group">
                                        <label class="col-lg-4 control-label" for="borrow_bno"><label
                                                class="text-danger">*&nbsp;</label>读者密码</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="pwd" name="pwd" type="password" value=""
                                                   placeholder="请读者输入密码">
                                            <label class="control-label" for="borrow_bno" style="display: none"></label>
                                        </div>
                                    </div>


                                    <div class="col-lg-2 form-group">
                                        <button type="button" class="btn btn-primary" id="btn_borrow">借书</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row table-responsive">
                <div class="col-xs-11">
                    <table id="data_list" class="table table-hover table-bordered" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                            <th>借阅编号</th>
                            <th>图书ISBN号</th>
                            <th>图书名称</th>
                            <th>读者证件号</th>
                            <th>读者名称</th>
                            <th>借阅日期</th>
                            <th>截止还书日期</th>
                            <th>操作</th>
                        </tr>
                        </thead>


                        <!---在此插入信息-->
                        <s:if test="#request.pb.beanList!=null">
                            <s:iterator value="#request.pb.beanList" var="borrow">
                                <tbody>
                                <td><s:property value="#borrow.borrowId"/></td>
                                <td><s:property value="#borrow.book.ISBN"/></td>
                                <td><s:property value="#borrow.book.bookName"/> </td>
                                <td><s:property value="#borrow.reader.cardId"/></td>
                                <td><s:property value="#borrow.reader.name"/></td>
                                <td><s:date name="#borrow.borrowDate" format="yyyy-MM-dd" /></td>
                                <td><s:date name="#borrow.returnDate" format="yyyy-MM-dd" /></td>
                                <td>
                                    <button type="button" class="btn btn-warning btn-xs" data-toggle="modal"
                                            data-target="#findBorrowModal"
                                            onclick="getBorrowInfoById(<s:property value="#borrow.borrowId"/>)">查看
                                    </button>
                                </td>
                                </tbody>
                            </s:iterator>
                        </s:if>
                        <s:else>
                            <tbody>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            <td>暂无数据</td>
                            </tbody>
                        </s:else>

                    </table>


                    <s:if test="#request.pb!=null">

                        <%-- 定义页码列表的长度，5个长 --%>
                        <c:choose>
                            <%-- 第一条：如果总页数<=5，那么页码列表为1 ~ totaPage 从第一页到总页数--%>
                            <%--如果总页数<=5的情况 --%>
                            <c:when test="${pb.totaPage <= 5 }">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="${pb.totaPage }"/>
                            </c:when>
                            <%--总页数>5的情况 --%>
                            <c:otherwise>
                                <%-- 第二条：按公式计算，让列表的头为当前页-2；列表的尾为当前页+2 --%>
                                <c:set var="begin" value="${pb.pageCode-2 }"/>
                                <c:set var="end" value="${pb.pageCode+2 }"/>

                                <%-- 第三条：第二条只适合在中间，而两端会出问题。这里处理begin出界！ --%>
                                <%-- 如果begin<1，那么让begin=1，相应end=5 --%>
                                <c:if test="${begin<1 }">
                                    <c:set var="begin" value="1"/>
                                    <c:set var="end" value="5"/>
                                </c:if>
                                <%-- 第四条：处理end出界。如果end>tp，那么让end=tp，相应begin=tp-4 --%>
                                <c:if test="${end>pb.totaPage }">
                                    <c:set var="begin" value="${pb.totaPage-4 }"/>
                                    <c:set var="end" value="${pb.totaPage }"/>
                                </c:if>
                            </c:otherwise>
                        </c:choose>


                        <div class="pull-right"><!--右对齐--->
                            <ul class="pagination">
                                <li class="disabled"><a href="#">第<s:property
                                        value="#request.pb.pageCode"/>页/共<s:property value="#request.pb.totaPage"/>页</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/admin/borrowManageAction_${pb.url }pageCode=1">首页</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/admin/borrowManageAction_${pb.url }pageCode=${pb.pageCode-1 }">&laquo;</a>
                                </li><!-- 上一页 -->
                                    <%-- 循环显示页码列表 --%>
                                <c:forEach begin="${begin }" end="${end }" var="i">
                                    <c:choose>
                                        <%--如果是当前页则设置无法点击超链接 --%>
                                        <c:when test="${i eq pb.pageCode }">
                                            <li class="active"><a>${i }</a>
                                            <li>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a href="${pageContext.request.contextPath}/admin/borrowManageAction_${pb.url }pageCode=${i}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                    <%--如果当前页数没到总页数，即没到最后一页,则需要显示下一页 --%>
                                <c:if test="${pb.pageCode < pb.totaPage }">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/admin/borrowManageAction_${pb.url }pageCode=${pb.pageCode+1}">&raquo;</a>
                                    </li>
                                </c:if>
                                    <%--否则显示尾页 --%>
                                <li>
                                    <a href="${pageContext.request.contextPath}/admin/borrowManageAction_${pb.url }pageCode=${pb.totaPage}">尾页</a>
                                </li>
                            </ul>
                        </div>
                    </s:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!--------------------------------------查看的模糊框------------------------>
<form class="form-horizontal">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="findBorrowModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        查看借阅信息
                    </h4>
                </div>
                <div class="modal-body">

                    <!---------------------表单-------------------->
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">借阅编号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="borrowId"  readonly="readonly">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">借阅书籍ISBN号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="ISBN"  readonly="readonly">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">借阅书籍名称</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="bookName"  readonly="readonly">

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">借阅书籍类型</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="bookType"  readonly="readonly">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">读者证件号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="paperNO"  readonly="readonly">

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">读者名称</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="readerName"  readonly="readonly">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">读者类型</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="readerType"  readonly="readonly">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">逾期天数</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="overday"  readonly="readonly">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">操作管理员</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="admin"  readonly="readonly">

                        </div>
                    </div>


                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">归还状态</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="state"  readonly="readonly">

                        </div>
                    </div>


                    <!---------------------表单-------------------->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!--------------------------------------查看的模糊框------------------------>
<!-------------------------------------------------------------->

<form class="form-horizontal">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updatepwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">
                        修改密码
                    </h4>
                </div>

                <div class="modal-body">

                    <!--正文-->
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">原密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="oldPwd" placeholder="请输入原密码">
                            <label class="control-label" for="oldPwd" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">新密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="newPwd" placeholder="请输入新密码">
                            <label class="control-label" for="newPwd" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">确认密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="confirmPwd" placeholder="请输入确认密码">
                            <label class="control-label" for="confirmPwd" style="display: none"></label>
                        </div>
                    </div>
                    <!--正文-->


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" id="update_adminPwd">
                        修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!-------------------------------------------------------------->







<!-------------------------个人资料模糊框------------------------------------->

<form class="form-horizontal">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updateinfo" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="ModalLabel">
                        个人资料
                    </h4>
                </div>

                <div class="modal-body">

                    <!--正文-->
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">用户名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="username" placeholder="请输入您的用户名"
                                   value='<s:property value="#session.admin.username"/>'>
                            <label class="control-label" for="username" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">真实姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="name" placeholder="请输入您的真实姓名"
                                   value='<s:property value="#session.admin.name"/>'>
                            <label class="control-label" for="name" style="display: none"></label>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">联系号码</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="phone" placeholder="请输入您的联系号码"
                                   value='<s:property value="#session.admin.email"/>'>
                            <label class="control-label" for="phone" style="display: none"></label>
                        </div>
                    </div>

                    <!--正文-->


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" id="admin_updateInfo">
                        修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!-------------------------------------------------------------->


<div class="modal fade" id="modal_info" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="infoModalLabel">提示</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12" id="div_info"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btn_info_close" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>