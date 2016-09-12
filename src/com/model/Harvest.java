package com.model;

import java.util.Date;
import java.sql.Timestamp;
import java.util.Set;

/**
 * Created by 1234ztc on 2016/5/24.
 */
public class Harvest {
    private int hid;
    private Date time;
    private String comment;
    private Student student;
    private Iterm iterms;
    private int mark;

    public  Harvest(){

    }
    public Harvest(int mark){
        this.mark=mark;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public void setIterms(Iterm iterms) {
        this.iterms = iterms;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Student getStudent() {
        return student;
    }

    public Integer getHid() {
        return hid;
    }

    public Iterm getIterms() {
        return iterms;
    }

    public String getComment() {
        return comment;
    }

    public Date getTime() {
        return time;
    }
}
