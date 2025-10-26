-- ===========================
-- CLEAN HOSTEL MANAGEMENT DB
-- ===========================

-- Drop tables in correct order
DROP TABLE IF EXISTS complaints;
DROP TABLE IF EXISTS room_allocations;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS notices;
DROP TABLE IF EXISTS visitors;


-- Users table
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

-- Rooms table
CREATE TABLE rooms (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       room_number VARCHAR(50) UNIQUE,
                       building VARCHAR(100),
                       capacity INT,
                       status VARCHAR(20)
);

-- Students table
CREATE TABLE students (
                          student_id INT AUTO_INCREMENT PRIMARY KEY,
                          user_id INT UNIQUE NOT NULL,
                          faculty VARCHAR(100),
                          course VARCHAR(100),
                          department VARCHAR(100),
                          hostel_name VARCHAR(100),
                          emergency_number VARCHAR(20),
                          address VARCHAR(255),
                          room_id INT NULL,
                          FOREIGN KEY (user_id) REFERENCES users(id),
                          FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- Room allocations table
CREATE TABLE room_allocations (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  room_id INT,
                                  student_id INT,
                                  allocated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  active BOOLEAN DEFAULT TRUE
);

-- Complaints table
CREATE TABLE IF NOT EXISTS complaints (
                                          id INT AUTO_INCREMENT PRIMARY KEY,
                                          title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    note VARCHAR(500) NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
    );



CREATE TABLE IF NOT EXISTS notices (
                                       id INT AUTO_INCREMENT PRIMARY KEY,
                                       title VARCHAR(200),
    description VARCHAR(1000),
    created_by VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS visitors (
                                       id INT AUTO_INCREMENT PRIMARY KEY,
                                       name VARCHAR(255),
    nic VARCHAR(100),
    contact VARCHAR(20),
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE fees (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      student_id INT,
                      fee_year INT,
                      period VARCHAR(20),
                      status VARCHAR(20) DEFAULT 'PENDING',
                      paid_at DATETIME,
                      FOREIGN KEY (student_id) REFERENCES users(id)
);


-- ===========================
-- Seed Admin & Warden
-- (Passwords will be hashed by AppContextListener in Java)
-- ===========================
INSERT INTO users (username, password, role, name, reg_no, nic, mobile) VALUES
                                                                            ('admin', HASHED('admin123'), 'ADMIN', 'Admin - Randula Perera', 'admin-as231', '1976934302V', '0740924321'),
                                                                            ('warden', HASHED('warden123'), 'WARDEN', 'Hostel Warden - Keerthi Silva', 'warden-ws456', '1982035435V', '0751234567');



-- ===========================
-- Seed 50 Student Accounts
-- ===========================
INSERT INTO users (username, password, role, name, reg_no, nic, mobile) VALUES
                                                                            ('SEU001',  HASHED('pass1'),  'STUDENT', 'Kasun Perera',           'SEU001', '199012301234', '0771234567'),
                                                                            ('SEU002',  HASHED('pass2'),  'STUDENT', 'Nirosha Fernando',       'SEU002', '199105401234', '0712345678'),
                                                                            ('SEU003',  HASHED('pass3'),  'STUDENT', 'Tharindu Jayasinghe',    'SEU003', '199212301234', '0759876543'),
                                                                            ('SEU004',  HASHED('pass4'),  'STUDENT', 'Dilani Wijesinghe',      'SEU004', '199305601234', '0764567890'),
                                                                            ('SEU005',  HASHED('pass5'),  'STUDENT', 'Sahan Kumara',           'SEU005', '199406701234', '0783456789'),
                                                                            ('SEU006',  HASHED('pass6'),  'STUDENT', 'Harsha Bandara',         'SEU006', '199507801234', '0722345678'),
                                                                            ('SEU007',  HASHED('pass7'),  'STUDENT', 'Chamari Rathnayake',     'SEU007', '199608901234', '0778765432'),
                                                                            ('SEU008',  HASHED('pass8'),  'STUDENT', 'Ruwanthi Gunasekara',    'SEU008', '199709001234', '0719876543'),
                                                                            ('SEU009',  HASHED('pass9'),  'STUDENT', 'Lakmal Senanayake',      'SEU009', '199810101234', '0751234567'),
                                                                            ('SEU010', HASHED('pass10'), 'STUDENT', 'Nadeesha Silva',         'SEU010', '199911201234', '0762345678'),
                                                                            ('SEU011', HASHED('pass11'), 'STUDENT', 'Kavindu Wickramasinghe', 'SEU011', '200012301234', '0784567890'),
                                                                            ('SEU012', HASHED('pass12'), 'STUDENT', 'Ishara Madushani',       'SEU012', '200105401234', '0723456789'),
                                                                            ('SEU013', HASHED('pass13'), 'STUDENT', 'Sanduni Herath',         'SEU013', '200212301234', '0776543210'),
                                                                            ('SEU014', HASHED('pass14'), 'STUDENT', 'Chathura Ranasinghe',    'SEU014', '200305601234', '0718765432'),
                                                                            ('SEU015', HASHED('pass15'), 'STUDENT', 'Sewwandi Rajapaksha',    'SEU015', '200406701234', '0752345678'),
                                                                            ('SEU016', HASHED('pass16'), 'STUDENT', 'Nuwan Dissanayake',      'SEU016', '200507801234', '0763456789'),
                                                                            ('SEU017', HASHED('pass17'), 'STUDENT', 'Rashmi Ekanayake',       'SEU017', '200608901234', '0785678901'),
                                                                            ('SEU018', HASHED('pass18'), 'STUDENT', 'Dinuka Abeykoon',        'SEU018', '200709001234', '0724567890'),
                                                                            ('SEU019', HASHED('pass19'), 'STUDENT', 'Thilina Gamage',         'SEU019', '200810101234', '0773456789'),
                                                                            ('SEU020', HASHED('pass20'), 'STUDENT', 'Sajani Edirisinghe',     'SEU020', '200911201234', '0717654321'),
                                                                            ('SEU021', HASHED('pass21'), 'STUDENT', 'Karthikeyan Raj',        'SEU021', '199012301234', '0758765432'),
                                                                            ('SEU022', HASHED('pass22'), 'STUDENT', 'Priya Selvan',           'SEU022', '199105401234', '0769876543'),
                                                                            ('SEU023', HASHED('pass23'), 'STUDENT', 'Arun Kumar',             'SEU023', '199212301234', '0781234567'),
                                                                            ('SEU024', HASHED('pass24'), 'STUDENT', 'Meena Tharmalingam',     'SEU024', '199305601234', '0722345678'),
                                                                            ('SEU025', HASHED('pass25'), 'STUDENT', 'Sathishwaran Nadarajah', 'SEU025', '199406701234', '0774567890'),
                                                                            ('SEU026', HASHED('pass26'), 'STUDENT', 'Revathi Somasundaram',   'SEU026', '199507801234', '0713456789'),
                                                                            ('SEU027', HASHED('pass27'), 'STUDENT', 'Vigneshwaran Pathmanathan','SEU027','199608901234','0752345678'),
                                                                            ('SEU028', HASHED('pass28'), 'STUDENT', 'Anjali Yogarajah',       'SEU028', '199709001234', '0763456789'),
                                                                            ('SEU029', HASHED('pass29'), 'STUDENT', 'Tharshan Sivarajah',     'SEU029', '199810101234', '0784567890'),
                                                                            ('SEU030', HASHED('pass30'), 'STUDENT', 'Kavitha Arulpragasam',   'SEU030', '199911201234', '0725678901'),
                                                                            ('SEU031', HASHED('pass31'), 'STUDENT', 'Mohamed Rizwan',         'SEU031', '200012301234', '0776789012'),
                                                                            ('SEU032', HASHED('pass32'), 'STUDENT', 'Fathima Nazeera',        'SEU032', '200105401234', '0717890123'),
                                                                            ('SEU033', HASHED('pass33'), 'STUDENT', 'Ibrahim Mujeeb',         'SEU033', '200212301234', '0758901234'),
                                                                            ('SEU034', HASHED('pass34'), 'STUDENT', 'Ayesha Nafeesa',         'SEU034', '200305601234', '0769012345'),
                                                                            ('SEU035', HASHED('pass35'), 'STUDENT', 'Nihal Ameer',            'SEU035', '200406701234', '0780123456'),
                                                                            ('SEU036', HASHED('pass36'), 'STUDENT', 'Shabana Rafiq',          'SEU036', '200507801234', '0721234567'),
                                                                            ('SEU037', HASHED('pass37'), 'STUDENT', 'Farhan Ismail',          'SEU037', '200608901234', '0772345678'),
                                                                            ('SEU038', HASHED('pass38'), 'STUDENT', 'Zainab Hanifa',          'SEU038', '200709001234', '0713456789'),
                                                                            ('SEU039', HASHED('pass39'), 'STUDENT', 'Ashfaq Nazeer',          'SEU039', '200810101234', '0754567890'),
                                                                            ('SEU040', HASHED('pass40'), 'STUDENT', 'Nuzha Imran',            'SEU040', '200911201234', '0765678901'),
                                                                            ('SEU041', HASHED('pass41'), 'STUDENT', 'Roshan De Silva',        'SEU041', '199012301234', '0786789012'),
                                                                            ('SEU042', HASHED('pass42'), 'STUDENT', 'Sujatha Ramanathan',     'SEU042', '199105401234', '0727890123'),
                                                                            ('SEU043', HASHED('pass43'), 'STUDENT', 'Imran Mohamed',          'SEU043', '199212301234', '0778901234'),
                                                                            ('SEU044', HASHED('pass44'), 'STUDENT', 'Thushara Rajendran',     'SEU044', '199305601234', '0719012345'),
                                                                            ('SEU045', HASHED('pass45'), 'STUDENT', 'Nadeesha Fathima',       'SEU045', '199406701234', '0750123456'),
                                                                            ('SEU046', HASHED('pass46'), 'STUDENT', 'Yasmin Kumari',          'SEU046', '199507801234', '0761234567'),
                                                                            ('SEU047', HASHED('pass47'), 'STUDENT', 'Ruwan Raj',              'SEU047', '199608901234', '0782345678'),
                                                                            ('SEU048', HASHED('pass48'), 'STUDENT', 'Nadeera Jasmin',         'SEU048', '199807861234', '0791234567'),
                                                                            ('SEU049', HASHED('pass49'), 'STUDENT', 'Kathir Raj',             'SEU049', '19960831234',  '0702385678'),
                                                                            ('SEU050', HASHED('pass50'), 'STUDENT', 'jason perrea',           'SEU050', '19964831234',  '0712935677');

-- ===========================
-- Seed Hostel Rooms
-- ===========================
INSERT INTO rooms (room_number, building, capacity, status) VALUES
                                                                ('B1-101', 'Building 1', 4, 'VACANT'),
                                                                ('B1-102', 'Building 1', 4, 'VACANT'),
                                                                ('B1-103', 'Building 1', 4, 'VACANT'),
                                                                ('B1-104', 'Building 1', 3, 'VACANT'),
                                                                ('B1-105', 'Building 1', 2, 'VACANT'),
                                                                ('B2-201', 'Building 2', 5, 'VACANT'),
                                                                ('B2-202', 'Building 2', 5, 'VACANT'),
                                                                ('B2-203', 'Building 2', 4, 'VACANT'),
                                                                ('B2-204', 'Building 2', 3, 'VACANT'),
                                                                ('B2-205', 'Building 2', 2, 'VACANT'),
                                                                ('B3-301', 'Building 3', 6, 'VACANT'),
                                                                ('B3-302', 'Building 3', 6, 'VACANT'),
                                                                ('B3-303', 'Building 3', 5, 'VACANT'),
                                                                ('B3-304', 'Building 3', 4, 'VACANT'),
                                                                ('B3-305', 'Building 3', 3, 'VACANT');


-- ===========================
-- Seed 50 Student Accounts
-- ===========================
-- Faculty of Computing
INSERT INTO students (user_id, faculty, course, department, hostel_name, emergency_number, address, room_id) VALUES
                                                                                                                 ((SELECT id FROM users WHERE username='SEU001'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234001', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU002'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234002', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU003'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234003', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU004'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234004', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU005'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234005', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU006'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234006', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU007'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234007', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU008'),  'Faculty of Engineering', 'civil Engineering', 'civil Engineering', 'Hostel A', '0771234008', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU009'),  'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234009', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU010'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234010', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU011'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234011', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU012'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234012', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU013'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234013', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU014'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234014', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU015'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234015', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU016'), 'Faculty of Technology ', 'ICT', 'ICT', 'Hostel A', '0771234016', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU017'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234017', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU018'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234018', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU019'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234019', 'Colombo', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU020'), 'Faculty of Technology', 'ICT', 'ICT', 'Hostel A', '0771234020', 'Colombo', NULL);

-- Faculty of Management
INSERT INTO students (user_id, faculty, course, department, hostel_name, emergency_number, address, room_id) VALUES
                                                                                                                 ((SELECT id FROM users WHERE username='SEU021'), 'Faculty of Management', 'BBA', 'Management', 'Hostel B', '0774567021', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU022'), 'Faculty of Management', 'BBA', 'Accounting', 'Hostel B', '0774567022', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU023'), 'Faculty of Management', 'BBA', 'Accounting', 'Hostel B', '0774567023', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU024'), 'Faculty of Management', 'BBA', 'Finance', 'Hostel B', '0774567024', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU025'), 'Faculty of Management', 'BBA', 'Accounting', 'Hostel B', '0774567025', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU026'), 'Faculty of Management', 'BBA', 'Accounting', 'Hostel B', '0774567026', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU027'), 'Faculty of Management', 'BCOM', 'Accountancy', 'Hostel B', '0774567027', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU028'), 'Faculty of Management', 'BCOM', 'Accountancy', 'Hostel B', '0774567028', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU029'), 'Faculty of Management', 'BCOM', 'Accountancy', 'Hostel B', '0774567029', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU030'), 'Faculty of Management', 'MIT', 'MIT', 'Hostel B', '0774567030', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU031'), 'Faculty of Management', 'MIT', 'MIT', 'Hostel B', '0774567031', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU032'), 'Faculty of Management', 'MIT', 'MIT', 'Hostel B', '0774567032', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU033'), 'Faculty of Management', 'MIT', 'MIT', 'Hostel B', '0774567033', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU034'), 'Faculty of Management', 'MIT', 'MIT', 'Hostel B', '0774567034', 'Kandy', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU035'), 'Faculty of Management', 'MIT', 'MIT', 'Hostel B', '0774567035', 'Kandy', NULL);

-- Faculty of Science
INSERT INTO students (user_id, faculty, course, department, hostel_name, emergency_number, address, room_id) VALUES
                                                                                                                 ((SELECT id FROM users WHERE username='SEU036'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890036', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU037'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890037', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU038'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890038', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU039'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890039', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU040'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890040', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU041'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890041', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU042'), 'Faculty of Applied Science', 'CS', 'Computer Science', 'Hostel C', '0777890042', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU043'), 'Faculty of Applied Science', 'CS', 'Computer Science', 'Hostel C', '0777890064', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU044'), 'Faculty of Applied Science', 'CS', 'Computer Science', 'Hostel C', '0777890068', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU045'), 'Faculty of Islamic studies and Arabic', 'Arabic', 'Arabic', 'Hostel C', '0777890049', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU046'), 'Faculty of Applied Science', 'BS', 'Biological Science', 'Hostel C', '0777890090', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU047'), 'Faculty of Arts and culture', 'IT', 'IT', 'Hostel C', '0777890031', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU048'), 'Faculty of Islamic studies and Arabic', 'Arabic', 'Arabic', 'Hostel C', '0777890052', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU049'), 'Faculty of Arts and culture', 'Social Science', 'Social Science', 'Hostel C', '0777890010', 'Galle', NULL),
                                                                                                                 ((SELECT id FROM users WHERE username='SEU050'), 'Faculty of Applied Science', 'BSc', 'Computer Science', 'Hostel C', '0777890091', 'Galle', NULL);