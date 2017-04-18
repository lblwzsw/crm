package com.lwz.entity;

import java.util.Date;

public class CustomInfo {
    private Integer id;

    private Integer cId;

    private Integer followManId;

    private String statu;

    private Date startDate;

    private Date lastFollowDate;

    private Date planDate;

    private String mark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getcId() {
        return cId;
    }

    public void setcId(Integer cId) {
        this.cId = cId;
    }

    public Integer getFollowManId() {
        return followManId;
    }

    public void setFollowManId(Integer followManId) {
        this.followManId = followManId;
    }

    public String getStatu() {
        return statu;
    }

    public void setStatu(String statu) {
        this.statu = statu;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getLastFollowDate() {
        return lastFollowDate;
    }

    public void setLastFollowDate(Date lastFollowDate) {
        this.lastFollowDate = lastFollowDate;
    }

    public Date getPlanDate() {
        return planDate;
    }

    public void setPlanDate(Date planDate) {
        this.planDate = planDate;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }
}