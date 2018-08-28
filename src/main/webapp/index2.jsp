<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.11.3.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>



<!-- 员工修改模态框 -->
<div class="modal fade" id="empEditModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalEdit">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_Name_input"  class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emp_Email_input" class="col-sm-2 control-label">Email </label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="Email_Edit_input" placeholder="Email@cjl.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emp_Email_input" class="col-sm-2 control-label">Gender </label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_edit_input" value="1" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_edit_input" value="0"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emp_Email_input" class="col-sm-2 control-label">Gender </label>
                        <div class="col-sm-4">
                            <!--提交部门ID-->
                            <select id="build_depts_edit" class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_edit_btn" >编辑</button>
            </div>
        </div>
    </div>
</div>



<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_Name_input"  class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_Name_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emp_Email_input" class="col-sm-2 control-label">Email </label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="emp_Email_input" placeholder="Email@cjl.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emp_Email_input" class="col-sm-2 control-label">Gender </label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="1" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="emp_Email_input" class="col-sm-2 control-label">Gender </label>
                        <div class="col-sm-4">
                            <!--提交部门ID-->
                            <select  class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn" >保存</button>
            </div>
        </div>
    </div>
</div>



<!-- 搭建显示页面Bootrap -->
<div class="container" >
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 两个按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn" >新增</button>
            <button class="btn btn-danger" id="emp_del_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>EmpName</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>DeptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <!-- 分页信息 -->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_num_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    //保存总记录数、保存当前页
    var totalRecord ,nowRecord;
    //全局保存保存按钮状态
    var  ajax_flag;


    //1、页面加载完成后，直接区发送一个ajax请求，要到分页数据
    $(function () {
       to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                //1、解析员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条
                build_page_dev(result);

            }
        });
    }

    function build_emps_table(result) {
        //清空当前表单
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var  gender=item.gender == '1'?"男":"女";
            var empGenderTd=$("<td></td>").append(gender);
            var empEmailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);
            /*
             * <button class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
             编辑</button>
             * */
            var editBtn=$("<button></button>")
                        .addClass("btn btn-primary btn-sm edit_btn")
                        .append("<span></span>").addClass("glyphicon glyphicon-pencil")
                        .append("编辑");
            //为编辑按钮添加自定义属性
            editBtn.attr("edit-id",item.empId);
            /*
            * <button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除</button>
            * */
            var delBtn=$("<button></button>")
                        .addClass("btn btn-danger btn-sm delete_btn")
                        .append("<span></span>").addClass("glyphicon glyphicon-trash")
                        .append("删除");
            //为按钮添加自定义属性，表示当前删除ID
            delBtn.attr("del-id",item.empId);
            var EditDel=$("<td></td>").append(editBtn).append("  ").append(delBtn)
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(empGenderTd)
                            .append(empEmailTd).append(deptNameTd).append(EditDel)
                .appendTo("#emps_table tbody");
        });
    }
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
            result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
        totalRecord=result.extend.pageInfo.total;
        nowRecord=result.extend.pageInfo.pageNum;
    }

    function build_page_dev(result) {
        $("#page_num_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var PrivPageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            PrivPageLi.addClass("disabled");
        }else {
            //为元素添加点击翻页事件
            firstPageLi.click(function () {
                to_page(1);
            });
            PrivPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var NextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var LastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage==false){
            NextPageLi.addClass("disabled");
            LastPageLi.addClass("disabled");
        }else{
            NextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            LastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(PrivPageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum==item){
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(NextPageLi).append(LastPageLi);
        var navElv=$("<nav></nav>").append(ul);
        navElv.appendTo("#page_num_area");

    }

    //完整的表单重置方法
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
        $(ele).find("*").removeClass("glyphicon glyphicon-ok glyphicon glyphicon-remove")

    }
    // 处理新增模态框按钮请求
    $("#emp_add_model_btn").click(function () {

        //清除表单数据（表单完整充值（表单的数据、表单的样式））
        reset_form("#empAddModel form");

        //先发Ajax请求获取部门
        getDepts("#empAddModel select");
        //弹出模态框
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });

    //查出所有部门信息


    //校验表单数据
    function validate_add_form() {

        //1、拿到要用的校验数据，使用正则
        //校验用户名
        var empName = $("#emp_Name_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            //lert("用户名可以是2-5位中文或者6-16位英文和数字组合");
            show_validate_msg("#emp_Name_input", "error", "前端：用户名可以是2-5位中文或者6-16位英文和数字组合");
            return false;
        } else {
            show_validate_msg("#emp_Name_input", "success", "");
        }

        //校验邮箱
        var emailName=$("#emp_Email_input").val();
        var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(emailName)){
           // alert("邮箱格式不正确！");
            show_validate_msg("#emp_Email_input","error","前端：邮箱格式不正确！");
            return false;
        }else {
            show_validate_msg("#emp_Email_input","success","");
        }
        return true;
    }

    //显示校验结果信息函数
    function show_validate_msg(ele,status,msg) {
        //清除当前元素状态
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").removeClass("glyphicon glyphicon-ok");
        $(ele).next("span").removeClass("glyphicon glyphicon-remove");
        $(ele).next("span").text("");
        if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").addClass("glyphicon glyphicon-remove").text(msg);
        } else if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").addClass("glyphicon glyphicon-ok").text(msg);
        }
    }

    function Ajax_checkUser(name){
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+name,
            type:"POST",
            success:function (result){
                if (result.code==100){
                    show_validate_msg("#emp_Name_input","success","check 用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                    ajax_flag="success";
                }else{
                    show_validate_msg("#emp_Name_input","error","check:"+result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                    ajax_flag="error";
                }
            }
        });
    };

    //绑定用户名输入框事件
    $("#emp_Name_input").change(function(){
       var empName=this.value;
        //发送ajax请求校验用户名是否可用
        Ajax_checkUser(empName);
    });





    /*
    * 保存员工方法
    * 1、先对要提交给服务器的数据校验
    * 2、发送ajax请求提交数据到服务器
    * */
    $("#emp_save_btn").click(function () {
        //1、先对模态框中填写的表单数据进行校验
        if(!validate_add_form()){
            return false;
        }
        //
        if( ajax_flag=="error"  ){
            Ajax_checkUser($("#emp_Name_input").val());
            return false;
        }
        //2、发送Ajax请求保存员工
       $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function (result) {
                if(result.code==100){
                    alert(result.msg);
                    //1、员工保存成功后关闭模态框
                    $("#empAddModel").modal('hide');
                    //2、来到最后一页，显示刚才保存的数据
                    to_page(totalRecord);
                }else{
                    //有哪个字段的错误信息就显示哪个字段的，默认正常情况为undefined
                    if(undefined != result.extend.Error.email){
                        show_validate_msg("#emp_Email_input","error",result.extend.Error.email);
                    }
                    if(undefined != result.extend.Error.empName){
                        show_validate_msg("#emp_Name_input", "error",result.extend.Error.empName);
                    }
                }


           }
        });
    });

    $(document).on("click",".edit_btn",function () {
        //查出部门
        getDepts("#empEditModel select");
        //查出用户信息
        getEmp($(this).attr("edit-id"));
        //3、把员工的id传递给更新按钮
        $("#emp_edit_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empEditModel").modal({
            backdrop:"static"
        });
    });


    function getDepts(ele) {
        //清空下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                // $("#build_depts_tb").append()
                $.each(result.extend.depts,function (index,item) {
                    var optionEle=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    };

    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empDate=result.extend.employee;
                $("#empName_static").text(empDate.empName);
                $("#Email_Edit_input").val(empDate.email);
                $("#empEditModel input[name=gender]").val([empDate.gender]);
                $("#empEditModel select").val([empDate.dId]);
            }
        });
    };

    //更新按钮
    $("#emp_edit_btn").click(function () {
        //验证邮箱是否合法
        //1、校验邮箱
        var emailName=$("#Email_Edit_input").val();
        var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(emailName)){
            // alert("邮箱格式不正确！");
            show_validate_msg("#Email_Edit_input","error","前端：邮箱格式不正确！");
            return false;
        }else {
            show_validate_msg("#Email_Edit_input","success","");
        }

        //2、发送ajax请求，保存更新数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empEditModel form").serialize(),
          //  data:$("#empEditModel form").serialize()+"&_method=PUT",
            success:function (result) {
                //alert(result.msg);
                //1、关闭对话框
                $("#empEditModel").modal("hide");
                //2、回到本页面
                to_page(nowRecord);
            }
        });

    });


    //单个删除模块
    $(document).on("click",".delete_btn",function () {
        //1、弹出是否确认删除对话框
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        var empId=$(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if(confirm("确认删除【"+empName+"】吗?")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    //alert(result.msg);
                    to_page(nowRecord);
                }
            });
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function () {

       $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是否5个
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("check_all").prop("checked",flag);

    });


    //点击全部删除，则批量删除
    $("#emp_del_all_btn").click(function () {

        var empNames="";
        var del_idstr="";
       $.each($(".check_item:checked") ,function () {
         empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
         del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
       });
       var newNames=empNames.substring(0,empNames.length-1);
       var ids=del_idstr.substring(0,del_idstr.length-1);
       if (confirm("确认删除【"+newNames+"】吗?")){
            $.ajax({
               url:"${APP_PATH}/emp/"+ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(nowRecord);
                }
            });
       }
    });
</script>
</body>
</html>