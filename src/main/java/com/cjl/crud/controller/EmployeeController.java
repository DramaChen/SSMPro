package com.cjl.crud.controller;

import com.cjl.crud.bean.Employee;
import com.cjl.crud.bean.Msg;
import com.cjl.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.jws.WebParam;
import javax.validation.Valid;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ChenJunLin
 * @Date 2018/8/24-20:57
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

//测试 Git
    //单个 批量 二合一
    //删除单个员工对象
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            List<Integer> del_ids=new ArrayList<>();
            String[] str_ids=ids.split("-");
            for (String id:str_ids){
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success2();
    }


    //保存修改员工
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT )
    public  Msg saveEmp(Employee employee){
        System.out.println("将要更新的数据："+employee);

        employeeService.updateEmp(employee);
        return Msg.success2();
    }

    //根据id查询员工
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
       Employee employee= employeeService.getEmp(id);
       return Msg.success2().add("employee",employee);
    }


    /*
    * 员工保存
    * 1、支持JSR303校验
    * 2、导入Hiberate-Validator
    * */

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        Map map=new HashMap();
        if(result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error:fieldErrors){
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("Error",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success2();
        }

    }

    /*
    * 检查用户名是否可用
    * */
    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String userName){
        String regName="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!userName.matches(regName)){
            return Msg.fail().add("va_msg","用户名可以是6-16位英文和数字组合或者2-5位中文");
        }

        boolean b =employeeService.checkUser(userName);
        if (b){
            return Msg.success2();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }


    @RequestMapping(value = "/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
        PageHelper.startPage(pn, 6);
        List<Employee> employees=employeeService.getAllEmployee();
        //连续显示的页数 5
        PageInfo<Employee> page=new PageInfo<Employee>(employees,5);
        return Msg.success2().add("pageInfo", page);
    }


    @RequestMapping("/hello")
    public String testEmployee(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

        PageHelper.startPage(pn,6);
        List<Employee> employees=employeeService.getAllEmployee();
        PageInfo<Employee> page=new PageInfo<Employee>(employees,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }

}
