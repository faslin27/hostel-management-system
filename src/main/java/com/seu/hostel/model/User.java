package com.seu.hostel.model;

public class User {
    private int id;
    private String username;
    private String password;
    private String role;
    private String name;
    private String regNo;
    private String nic;
    private String mobile;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getRegNo() { return regNo; }
    public void setRegNo(String regNo) { this.regNo = regNo; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", name='" + name + '\'' +
                ", regNo='" + regNo + '\'' +
                ", nic='" + nic + '\'' +
                ", mobile='" + mobile + '\'' +
                '}';
    }
}
