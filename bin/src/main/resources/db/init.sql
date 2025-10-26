-- Drop existing tables (optional for development)
DROP TABLE IF EXISTS room_allocations;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;

-- Users
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(100) UNIQUE,
                       password VARCHAR(200),
                       role VARCHAR(20),
                       name VARCHAR(200),
                       reg_no VARCHAR(50),
                       nic VARCHAR(50),
                       mobile VARCHAR(50)
);

-- Rooms
CREATE TABLE rooms (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       room_number VARCHAR(50) UNIQUE,
                       building VARCHAR(100),
                       capacity INT,
                       status VARCHAR(20)
);

-- Allocations
CREATE TABLE room_allocations (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  room_id INT,
                                  student_id INT,
                                  allocated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  active BOOLEAN DEFAULT TRUE
);

-- Seed Admin & Warden
INSERT INTO users (username, password, role, name) VALUES
                                                       ('admin', HASHED('admin123'), 'ADMIN', 'System Admin'),
                                                       ('warden', HASHED('warden123'), 'WARDEN', 'Hostel Warden');

-- Seed Students (50 students)
INSERT INTO users (username, password, role, name, reg_no) VALUES
                                                               ('student1', HASHED('pass1'), 'STUDENT', 'Kasun Perera', 'SEU001'),
                                                               ('student2', HASHED('pass2'), 'STUDENT', 'Nirosha Fernando', 'SEU002'),
                                                               ('student3', HASHED('pass3'), 'STUDENT', 'Tharindu Jayasinghe', 'SEU003'),
                                                               ('student4', HASHED('pass4'), 'STUDENT', 'Dilani Wijesinghe', 'SEU004'),
                                                               ('student5', HASHED('pass5'), 'STUDENT', 'Sahan Kumara', 'SEU005'),
                                                               ('student6', HASHED('pass6'), 'STUDENT', 'Harsha Bandara', 'SEU006'),
                                                               ('student7', HASHED('pass7'), 'STUDENT', 'Chamari Rathnayake', 'SEU007'),
                                                               ('student8', HASHED('pass8'), 'STUDENT', 'Ruwanthi Gunasekara', 'SEU008'),
                                                               ('student9', HASHED('pass9'), 'STUDENT', 'Lakmal Senanayake', 'SEU009'),
                                                               ('student10', HASHED('pass10'), 'STUDENT', 'Nadeesha Silva', 'SEU010'),
                                                               ('student11', HASHED('pass11'), 'STUDENT', 'Kavindu Wickramasinghe', 'SEU011'),
                                                               ('student12', HASHED('pass12'), 'STUDENT', 'Ishara Madushani', 'SEU012'),
                                                               ('student13', HASHED('pass13'), 'STUDENT', 'Sanduni Herath', 'SEU013'),
                                                               ('student14', HASHED('pass14'), 'STUDENT', 'Chathura Ranasinghe', 'SEU014'),
                                                               ('student15', HASHED('pass15'), 'STUDENT', 'Sewwandi Rajapaksha', 'SEU015'),
                                                               ('student16', HASHED('pass16'), 'STUDENT', 'Nuwan Dissanayake', 'SEU016'),
                                                               ('student17', HASHED('pass17'), 'STUDENT', 'Rashmi Ekanayake', 'SEU017'),
                                                               ('student18', HASHED('pass18'), 'STUDENT', 'Dinuka Abeykoon', 'SEU018'),
                                                               ('student19', HASHED('pass19'), 'STUDENT', 'Thilina Gamage', 'SEU019'),
                                                               ('student20', HASHED('pass20'), 'STUDENT', 'Sajani Edirisinghe', 'SEU020'),
                                                               ('student21', HASHED('pass21'), 'STUDENT', 'Karthikeyan Raj', 'SEU021'),
                                                               ('student22', HASHED('pass22'), 'STUDENT', 'Priya Selvan', 'SEU022'),
                                                               ('student23', HASHED('pass23'), 'STUDENT', 'Arun Kumar', 'SEU023'),
                                                               ('student24', HASHED('pass24'), 'STUDENT', 'Meena Tharmalingam', 'SEU024'),
                                                               ('student25', HASHED('pass25'), 'STUDENT', 'Sathishwaran Nadarajah', 'SEU025'),
                                                               ('student26', HASHED('pass26'), 'STUDENT', 'Revathi Somasundaram', 'SEU026'),
                                                               ('student27', HASHED('pass27'), 'STUDENT', 'Vigneshwaran Pathmanathan', 'SEU027'),
                                                               ('student28', HASHED('pass28'), 'STUDENT', 'Anjali Yogarajah', 'SEU028'),
                                                               ('student29', HASHED('pass29'), 'STUDENT', 'Tharshan Sivarajah', 'SEU029'),
                                                               ('student30', HASHED('pass30'), 'STUDENT', 'Kavitha Arulpragasam', 'SEU030'),
                                                               ('student31', HASHED('pass31'), 'STUDENT', 'Mohamed Rizwan', 'SEU031'),
                                                               ('student32', HASHED('pass32'), 'STUDENT', 'Fathima Nazeera', 'SEU032'),
                                                               ('student33', HASHED('pass33'), 'STUDENT', 'Ibrahim Mujeeb', 'SEU033'),
                                                               ('student34', HASHED('pass34'), 'STUDENT', 'Ayesha Nafeesa', 'SEU034'),
                                                               ('student35', HASHED('pass35'), 'STUDENT', 'Nihal Ameer', 'SEU035'),
                                                               ('student36', HASHED('pass36'), 'STUDENT', 'Shabana Rafiq', 'SEU036'),
                                                               ('student37', HASHED('pass37'), 'STUDENT', 'Farhan Ismail', 'SEU037'),
                                                               ('student38', HASHED('pass38'), 'STUDENT', 'Zainab Hanifa', 'SEU038'),
                                                               ('student39', HASHED('pass39'), 'STUDENT', 'Ashfaq Nazeer', 'SEU039'),
                                                               ('student40', HASHED('pass40'), 'STUDENT', 'Nuzha Imran', 'SEU040'),
                                                               ('student41', HASHED('pass41'), 'STUDENT', 'Roshan De Silva', 'SEU041'),
                                                               ('student42', HASHED('pass42'), 'STUDENT', 'Sujatha Ramanathan', 'SEU042'),
                                                               ('student43', HASHED('pass43'), 'STUDENT', 'Imran Mohamed', 'SEU043'),
                                                               ('student44', HASHED('pass44'), 'STUDENT', 'Thushara Rajendran', 'SEU044'),
                                                               ('student45', HASHED('pass45'), 'STUDENT', 'Nadeesha Fathima', 'SEU045'),
                                                               ('student46', HASHED('pass46'), 'STUDENT', 'Yasmin Kumari', 'SEU046'),
                                                               ('student47', HASHED('pass47'), 'STUDENT', 'Ruwan Raj', 'SEU047'),
                                                               ('student48', HASHED('pass48'), 'STUDENT', 'Shanika Mohamed', 'SEU048'),
                                                               ('student49', HASHED('pass49'), 'STUDENT', 'Kavindya Nadarajah', 'SEU049'),
                                                               ('student50', HASHED('pass50'), 'STUDENT', 'Tharindu Ameer', 'SEU050');


-- Seed Hostel Rooms (at least 60 beds, shuffled capacity and buildings)
INSERT INTO rooms (room_number, building, capacity, status) VALUES
                                                                ('B1-101','Building 1',4,'VACANT'),
                                                                ('B1-102','Building 1',4,'VACANT'),
                                                                ('B1-103','Building 1',4,'VACANT'),
                                                                ('B1-104','Building 1',3,'VACANT'),
                                                                ('B1-105','Building 1',2,'VACANT'),
                                                                ('B2-201','Building 2',5,'VACANT'),
                                                                ('B2-202','Building 2',5,'VACANT'),
                                                                ('B2-203','Building 2',4,'VACANT'),
                                                                ('B2-204','Building 2',3,'VACANT'),
                                                                ('B2-205','Building 2',2,'VACANT'),
                                                                ('B3-301','Building 3',6,'VACANT'),
                                                                ('B3-302','Building 3',6,'VACANT'),
                                                                ('B3-303','Building 3',5,'VACANT'),
                                                                ('B3-304','Building 3',4,'VACANT'),
                                                                ('B3-305','Building 3',3,'VACANT');

-- Total beds = 60 (sum of capacities)
-- optional SQL init script

-- Complaints Table
CREATE TABLE IF NOT EXISTS complaints (
                                          id INT AUTO_INCREMENT PRIMARY KEY,
                                          student_id INT,
                                          title VARCHAR(200),
    description VARCHAR(1000),
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id)
    );
