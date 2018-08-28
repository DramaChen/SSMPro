package com.cjl.crud.controller;

import com.cjl.crud.bean.Department;
import com.cjl.crud.bean.Msg;
import com.cjl.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author ChenJunLin
 * @Date 2018/8/25-14:17
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDeptsWithJson(){

        List<Department> departments=departmentService.getAllDepartment();

        return Msg.success2().add("depts",departments);
    }
}
