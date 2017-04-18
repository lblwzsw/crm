package com.lwz.entity;

public class Employee {
    private Integer id;

    private String username;

    private String pass;

    private String nickname;

    private String realname;

    private Integer jobinfoId;

    private Integer departmentId;

    private String phoneNo;

    private String officeTel;

    private String workStatu;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Integer getJobinfoId() {
        return jobinfoId;
    }

    public void setJobinfoId(Integer jobinfoId) {
        this.jobinfoId = jobinfoId;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getOfficeTel() {
        return officeTel;
    }

    public void setOfficeTel(String officeTel) {
        this.officeTel = officeTel;
    }

    public String getWorkStatu() {
        return workStatu;
    }

    public void setWorkStatu(String workStatu) {
        this.workStatu = workStatu;
    }
}