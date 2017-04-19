package com.lwz.entity;

import java.util.Date;

public class Custom {
    private Integer id;

    private String name;

    private String education;

    private String phoneNo;

    private Integer qq;

    private String email;

    private String customStatu;

    private Date createDate;

    private String inviteName;

    private CustomInfo customInfo;
    
    public CustomInfo getCustomInfo() {
		return customInfo;
	}

	public void setCustomInfo(CustomInfo customInfo) {
		this.customInfo = customInfo;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public Integer getQq() {
        return qq;
    }

    public void setQq(Integer qq) {
        this.qq = qq;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCustomStatu() {
        return customStatu;
    }

    public void setCustomStatu(String customStatu) {
        this.customStatu = customStatu;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getInviteName() {
        return inviteName;
    }

    public void setInviteName(String inviteName) {
        this.inviteName = inviteName;
    }
}