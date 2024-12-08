package model;

public class Colleges {
    private int collegeID;
    private String name;
    private String location;
    private float yearFounded;
    private float averageGPA;

    // Constructor
    public Colleges(int collegeID, String name, String location, int yearFounded, float averageGPA) {
        this.collegeID = collegeID;
        this.name = name;
        this.location = location;
        this.yearFounded = yearFounded;
        this.averageGPA = averageGPA;
    }

    // Getters and Setters
    public int getCollegeID() {
        return collegeID;
    }

    public void setCollegeID(int collegeID) {
        this.collegeID = collegeID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setYearFounded(float yearFounded) {
        this.yearFounded = yearFounded;
    }
    public Object getYearFounded() {
        return yearFounded;
    }

    public void setAverageGPA(float averageGPA) {
        this.averageGPA = averageGPA;
    }
    public Object getAverageGPA() {
        return averageGPA;
    }


}