package com.cjl.crud.service;

import com.cjl.crud.bean.Employee;

import java.util.List;

/**
 * @author ChenJunLin
 * @Date 2018/8/24-20:57
 */
public interface EmployeeService {

    public List<Employee> getAllEmployee();

    public  void saveEmp(Employee employee);

    public boolean checkUser(String name);

    public Employee getEmp(Integer id);

    public void updateEmp(Employee employee);

    public void deleteEmp(Integer id);

    public void deleteBatch(List<Integer> ids);
}
