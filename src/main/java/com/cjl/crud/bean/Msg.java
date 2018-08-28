package com.cjl.crud.bean;

import java.util.HashMap;
import java.util.Map;


public class Msg {

	private int Code;
	private String msg;
	private Map<String, Object> extend=new HashMap<String,Object>();
	
	public static Msg success2() {
		Msg result1=new Msg();
		result1.setCode(100);
		result1.setMsg("查询成功");
		return result1;
	}
	
	public static Msg fail() {
		Msg result=new Msg();
		result.setCode(200);
		result.setMsg("查询失败");
		return result;
	}
	public int getCode() {
		return Code;
	}
	public void setCode(int code) {
		Code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	public Msg add(String key,Object value) {
		this.extend.put(key, value);
		return this;
	}
	
}
