package com.model;

/**
 * Created by 1234ztc on 2016/5/24.
 */

public class Major {
    private int mid;
    private String grade;
    private String profession;

    public Major(){

    }
    public  Major(String grade,String profession){
        this.grade=grade;
        this.profession=profession;
    }
    public void setGrade(String grade) {
        this.grade = grade;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public int getMid() {
        return mid;
    }

    public String getGrade() {
        return grade;
    }

    public String getProfession() {
        return profession;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Major that = (Major) o;

        if (mid != that.mid) return false;
        if (grade != null ? !grade.equals(that.grade) : that.grade != null) return false;
        if (profession != null ? !profession.equals(that.profession) : that.profession != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = mid;
        result = 31 * result + (grade != null ? grade.hashCode() : 0);
        result = 31 * result + (profession != null ? profession.hashCode() : 0);
        return result;
    }
}
