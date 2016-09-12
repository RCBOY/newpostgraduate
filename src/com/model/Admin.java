package com.model;

/**
 * Created by 1234ztc on 2016/5/24.
 */

public class Admin {
    private int id;
    private String acc_anum;
    private String apassword;
    private String name;
    private String tel;




    public void setAcc_anum(String acc_anum) {
        this.acc_anum = acc_anum;
    }

    public String getAcc_anum() {
        return acc_anum;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setApassword(String password) {
        this.apassword = password;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getName() {
        return name;
    }

    public int getId() {
        return id;
    }

    public String getApassword() {
        return apassword;
    }

    public String getTel() {
        return tel;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Admin that = (Admin) o;

        if (id != that.id) return false;
        if (apassword != null ? !apassword.equals(that.apassword) : that.apassword != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (tel != null ? !tel.equals(that.tel) : that.tel != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (apassword != null ? apassword.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (tel != null ? tel.hashCode() : 0);
        return result;
    }
}
