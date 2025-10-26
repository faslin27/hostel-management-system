Hostel Management System

A Java-based Web Application for managing university hostel operations, built using Jakarta Servlets, JSP, and MySQL.
The system supports multiple user roles — Admin, Warden, and Student — to handle all aspects such as room allocation, fee management, complaints, and notice boards.

🚀 Features
👩‍💼 Admin

Manage hostel rooms (add, edit, update status).

Allocate and unallocate students to rooms.

Manage student records and view details.

Create and manage fee records.

View and respond to complaints (add notes when changing status).

Post notices for all users.

🧑‍🏫 Warden

View allocated rooms and student lists.

View complaints and update their status with remarks.

Read notices.

👨‍🎓 Student

View own room details and hostel information.

View and pay fees (status tracked by admin).

Submit complaints and view their resolution status.

View important notices posted by the admin.

🏗️ Project Architecture
HostelManagement/
│
├── src/main/java/com/seu/hostel/
│   ├── servlet/               # All servlets (RoomServlet, FeeServlet, ComplaintServlet, etc.)
│   ├── dao/                   # DAO interfaces & implementations (RoomDaoImpl, FeeDaoImpl, etc.)
│   ├── model/                 # POJO models (User, Room, Complaint, Fee, Notice)
│   ├── util/                  # Utilities (ConnectionManager, HashUtil)
│   ├── AppContextListener.java# Initializes DB and seeds data
│
├── src/main/webapp/
│   ├── admin/                 # Admin JSP pages (dashboard, rooms.jsp, fees.jsp, etc.)
│   ├── warden/                # Warden JSP pages
│   ├── student/               # Student JSP pages
│   ├── login.jsp              # Login page
│   ├── css/ & js/             # Static assets
│
├── db/
│   └── init.sql               # Optional SQL initialization (used for H2 or MySQL setup)
│
├── pom.xml                    # Maven dependencies
└── README.md

⚙️ Tech Stack
Component   Technology Used
Frontend    JSP, HTML5, CSS3, Bootstrap 5, JSTL
Backend Java 17, Jakarta Servlets, JSP
Database    MySQL 8+ (previously H2 for in-memory testing)
Build Tool  Maven
Server  Jetty / Tomcat
Security    SHA-256 password hashing
IDE Recommendation  IntelliJ IDEA / Eclipse
🧩 Dependencies (Maven)
<dependencies>
<!-- Servlet API -->
<dependency>
<groupId>jakarta.servlet</groupId>
<artifactId>jakarta.servlet-api</artifactId>
<version>6.0.0</version>
<scope>provided</scope>
</dependency>

    <!-- JSP + JSTL -->
    <dependency>
        <groupId>jakarta.servlet.jsp.jstl</groupId>
        <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
        <version>3.0.0</version>
    </dependency>
    <dependency>
        <groupId>org.glassfish.web</groupId>
        <artifactId>jakarta.servlet.jsp.jstl</artifactId>
        <version>3.0.1</version>
    </dependency>

    <!-- MySQL Connector -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <version>8.3.0</version>
    </dependency>

    <!-- Jetty for Local Run -->
    <dependency>
        <groupId>org.eclipse.jetty</groupId>
        <artifactId>jetty-maven-plugin</artifactId>
        <version>11.0.15</version>
    </dependency>
</dependencies>

🗄️ Database Setup (MySQL)
1. Create Database
   CREATE DATABASE hostel_management;
   USE hostel_management;

2. Run SQL Script

Execute your prepared SQL file (like hostel_management.sql) inside MySQL Workbench or CLI:

SOURCE /path/to/hostel_management.sql;

3. Update Connection Configuration

In /src/main/java/com/seu/hostel/util/ConnectionManager.java:

private static final String URL = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12804534?useSSL=false&serverTimezone=UTC";
private static final String USER = "sql12804534";
private static final String PASSWORD = "YOUR_DB_PASSWORD";

🧠 How It Works

User Authentication

Login credentials validated via UserDao.

Session stores the User object and role.

Role-based Navigation

Each dashboard (Admin/Warden/Student) is role-restricted.

Navigation handled in AuthFilter and JSP <c:choose>.

Room Allocation

Admin allocates rooms.

Database auto-updates capacity and status (VACANT/FULL).

Complaint Workflow

Student raises a complaint.

Warden/Admin can update status & add notes.

Notes and timestamps stored in DB.

Fee Management

Admin adds fee records for students.

Fee period (FIRST_HALF, SECOND_HALF) displayed as human-readable text.

Paid status updates tracked.

Notice Board

Admin posts notices visible to all users.

🧰 How to Run Locally
✅ Prerequisites

Java 17+

Maven 3.8+

MySQL Server

(Optional) Jetty or Tomcat

▶️ Steps
# 1. Clone the project
git clone https://github.com/faslin27/hostel-management-system.git
cd hostel-management

# 2. Configure your database in ConnectionManager.java

# 3. Build the project
mvn clean install

# 4. Run with Jetty
mvn jetty:run


Then open your browser and visit:
👉 http://localhost:8080/


🧭 Future Enhancements

Email notifications for complaint resolution.

Online payment gateway for fee payment.

Report generation (PDF/Excel).

Role-based audit logging.

Spring Boot version migration.

📜 License

This project is open-source and free to use under the MIT License.

Author: J.F.Faslin Janna
South Eastern University of Sri Lanka

