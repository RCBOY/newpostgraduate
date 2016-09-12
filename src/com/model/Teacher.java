package com.model;

/**
 * Created by 1234ztc on 2016/5/24.
 */

public class Teacher {
    private int tid;
    private String tname;
    private String ttel;
    private String acc_tnum;
    private String password;

    public void setAcc_tnum(String acc_tnum) {
        this.acc_tnum = acc_tnum;
    }

    public String getAcc_tnum() {
        return acc_tnum;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public void setTtel(String ttel) {
        this.ttel = ttel;
    }

    public int getTid() {
        return tid;
    }

    public String getPassword() {
        return password;
    }

    public String getTname() {
        return tname;
    }

    public String getTtel() {
        return ttel;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Teacher that = (Teacher) o;

        if (tid != that.tid) return false;
        if (tname != null ? !tname.equals(that.tname) : that.tname != null) return false;
        if (ttel != null ? !ttel.equals(that.ttel) : that.ttel != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = tid;
        result = 31 * result + (tname != null ? tname.hashCode() : 0);
        result = 31 * result + (ttel != null ? ttel.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        return result;
    }
}
