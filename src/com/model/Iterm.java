package com.model;

import java.util.Date;

/**
 * Created by 1234ztc on 2016/5/24.
 */

public class Iterm {
    private int iid;
    private String iname;
    private Integer mark;
    private String type;
    private Date time;
    private int hid;
    private  String comment;
    public Iterm(int mark){
        this.mark=mark;
    }
    public Iterm(){

    }
    public Iterm(int iid,String iname,int mark,String type,String comment,Date time,int hid){
        this.mark=mark;
        this.iid=iid;
        this.type=type;
        this.iname=iname;
        this.time=time;
        this.hid=hid;
        this.comment=comment;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getHid() {
        return hid;
    }

    public void setHid(int hid) {
        this.hid = hid;
    }

    public Date getTime() {
        return time;
    }
    public void setTime(Date time) {
        this.time = time;
    }

    public void setIid(int iid) {
        this.iid = iid;
    }

    public void setIname(String iname) {
        this.iname = iname;
    }

    public void setMark(Integer mark) {
        this.mark = mark;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getIid() {
        return iid;
    }

    public Integer getMark() {
        return mark;
    }

    public String getIname() {
        return iname;
    }

    public String getType() {
        return type;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Iterm that = (Iterm) o;

        if (iid != that.iid) return false;
        if (iname != null ? !iname.equals(that.iname) : that.iname != null) return false;
        if (mark != null ? !mark.equals(that.mark) : that.mark != null) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = iid;
        result = 31 * result + (iname != null ? iname.hashCode() : 0);
        result = 31 * result + (mark != null ? mark.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        return result;
    }
}
