package com.seu.hostel.model;

import java.time.LocalDateTime;

public class Visitor {
    private int id;
    private String name;
    private String nic;
    private String contact;
    private LocalDateTime visitDate;

    // getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public LocalDateTime getVisitDate() { return visitDate; }
    public void setVisitDate(LocalDateTime visitDate) { this.visitDate = visitDate; }
}
