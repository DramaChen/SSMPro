package com.cjl.crud.service;

import com.cjl.crud.bean.Department;
import com.cjl.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ChenJunLin
 * @Date 2018/8/25-14:18
 */
@Service
public class DepartmentServiceImpl implements  DepartmentService{

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAllDepartment() {
        return departmentMapper.selectByExample(null);
    }
}
