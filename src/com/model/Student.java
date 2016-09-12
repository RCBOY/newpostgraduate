package com.model;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by 1234ztc on 2016/5/24.
 */
public class Student {
    private int sid;
    private String snum;
    private String sname;
    private String ssex;
    private String state;
    private String stel;
    private String password;
    private Double total;
    private Major major;
    private Teacher teacher;
    private Assistant assistant;
    private Set<Harvest> harvest;

    public Student(int sid,String sname){
        this.sid=sid;
        this.sname=sname;
    }
    public Student(int sid,String sname,String ssex,String stel,Major major){
        this.sid=sid;
        this.sname=sname;
        this.ssex=ssex;
        this.stel=stel;
        this.major=major;

        }
    public Student(int sid,String snum,String sname,Major major,String state,double total){
        this.sid=sid;
        this.sname=sname;
        this.major=major;
        this.snum=snum;
        this.state=state;
        this.total=total;
    }
    public Student(){
    }
    public Student(int sid,double total,String state){
        this.sid=sid;
        this.total=total;
        this.state=state;
    }
    public Student(String snum,String sname,String ssex,String stel){
        this.snum=snum;
        this.sname=sname;
        this.ssex=ssex;
        this.stel=stel;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public void setSnum(String snum) {
        this.snum = snum;
    }

    public String getSnum() {
        return snum;
    }

    public void setAssistant(Assistant assistant) {
        this.assistant = assistant;
    }

    public Assistant getAssistant() {
        return assistant;
    }

    public void setState(String state) {
        this.state = state;
    }
    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public void setMajor(Major major) {
        this.major = major;
    }

    public void setHarvest(Set<Harvest> harvest) {
        this.harvest = harvest;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public void setSsex(String ssex) {
        this.ssex = ssex;
    }

    public Major getMajor() {
        return major;
    }

    public void setStel(String stel) {
        this.stel = stel;
    }

    public String getStel() {
        return stel;
    }

    public Integer getSid() {
        return sid;
    }

    public Set<Harvest> getHarvest() {
        return harvest;
    }
    public String getPassword() {
        return password;
    }

    public String getSname() {
        return sname;
    }

    public String getSsex() {
        return ssex;
    }

    public String getState() {
        return state;
    }

    public Teacher getTeacher() {
        return teacher;
    }
}
