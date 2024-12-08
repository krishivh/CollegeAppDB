package model;

public class User {
    private int userID;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phone;
    private String highSchool;
    private float gpa;

    public User() {}

    // Constructor to initialize all fields
    public User(int userID, String firstName, String lastName, String email, String password, String phone, String highSchool, float gpa) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.highSchool = highSchool;
        this.gpa = gpa;
    }

    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getHighSchool() {
        return highSchool;
    }

    public void setHighSchool(String highSchool) {
        this.highSchool = highSchool;
    }

    public float getGPA() {
        return gpa;
    }

    public void setGPA(float gpa) {
        this.gpa = gpa;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
