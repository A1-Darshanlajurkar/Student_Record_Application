package com.student;

public class Student {
    private int    id;
    private String name;
    private String rollNo;
    private String className;
    private String city;

    public Student() {}

    public Student(String name, String rollNo, String className, String city) {
        this.name      = name;
        this.rollNo    = rollNo;
        this.className = className;
        this.city      = city;
    }

    public int    getId()        { return id; }
    public String getName()      { return name; }
    public String getRollNo()    { return rollNo; }
    public String getClassName() { return className; }
    public String getCity()      { return city; }

    public void setId(int id)             { this.id = id; }
    public void setName(String name)      { this.name = name; }
    public void setRollNo(String rollNo)  { this.rollNo = rollNo; }
    public void setClassName(String c)    { this.className = c; }
    public void setCity(String city)      { this.city = city; }
}
