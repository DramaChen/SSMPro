package com.cjl.crud.service;

import com.cjl.crud.bean.Employee;
import com.cjl.crud.bean.EmployeeExample;
import com.cjl.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ChenJunLin
 * @Date 2018/8/24-20:58
 */
@Service
public class EmployeeServiceImpl implements EmployeeService{

    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAllEmployee() {

        return employeeMapper.selectByExampleWithDept(null);

    }

    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }


    @Override
    public boolean checkUser(String name) {

        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(name);
        //根据条件查出符合条件的记录数
       int count= employeeMapper.countByExample(example);
        return count==0;
    }

    @Override
    public Employee getEmp(Integer id) {

        return  employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    @Override
    public void updateEmp(Employee employee) {

        employeeMapper.updateByPrimaryKeySelective(employee);

    }

    public void deleteEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
