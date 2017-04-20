package com.lwz.entity;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

@Alias("value=consult_record")
public class ConsultRecord {
    private Integer id;

    private Integer cId;

    private Integer consultManId;

    private String consultStatu;

    @DateTimeFormat(pattern="yyyy-MM-dd")  
    @JsonFormat(pattern="yyyy-MM-dd")
    private Date consultDate;

    private String result;

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

    public Integer getConsultManId() {
        return consultManId;
    }

    public void setConsultManId(Integer consultManId) {
        this.consultManId = consultManId;
    }

    public String getConsultStatu() {
        return consultStatu;
    }

    public void setConsultStatu(String consultStatu) {
        this.consultStatu = consultStatu;
    }

    public Date getConsultDate() {
        return consultDate;
    }

    public void setConsultDate(Date consultDate) {
        this.consultDate = consultDate;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

	@Override
	public String toString() {
		return "ConsultRecord [id=" + id + ", cId=" + cId + ", consultManId=" + consultManId + ", consultStatu="
		        + consultStatu + ", consultDate=" + consultDate + ", result=" + result + "]";
	}
    
}