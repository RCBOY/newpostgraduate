package com.model;

/**
 * Created by 1234ztc on 2016/5/24.
 */

public class Assistant {
    private int aid;
    private String acc_num;
    private String aname;
    private String password;
    private String atel;

    public void setAcc_num(String acc_num) {
        this.acc_num = acc_num;
    }

    public String getAcc_num() {
        return acc_num;
    }

    public void setAid(int aid) {
        this.aid = aid;
    }

    public void setAname(String aname) {
        this.aname = aname;
    }

    public void setAtel(String atel) {
        this.atel = atel;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getAid() {
        return aid;
    }

    public String getAname() {
        return aname;
    }

    public String getAtel() {
        return atel;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Assistant that = (Assistant) o;

        if (aid != that.aid) return false;
        if (aname != null ? !aname.equals(that.aname) : that.aname != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (atel != null ? !atel.equals(that.atel) : that.atel != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = aid;
        result = 31 * result + (aname != null ? aname.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (atel != null ? atel.hashCode() : 0);
        return result;
    }
}
