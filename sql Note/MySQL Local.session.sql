use fsm;

CREATE TABLE IF NOT EXISTS Admin (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    status ENUM('ACTIVE','NON_ACTIVE') DEFAULT 'ACTIVE'
);

CREATE TABLE IF NOT EXISTS Technician (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    last_location VARCHAR(100) ,
    status ENUM('ON_DUTY', 'TAKE_BREAK', 'OFF_DUTY','NON_ACTIVE') NOT NULL DEFAULT 'OFF_DUTY'
);

CREATE TABLE IF NOT EXISTS Skill (
    technician_id INT,
    item_id INT,
    PRIMARY KEY (technician_id, item_id)
);

CREATE TABLE IF NOT EXISTS Customer (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    password_hash VARCHAR(255),
    location VARCHAR(100),
    state VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Company (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    company_location VARCHAR(100) NOT NULL,
    company_ssn VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Cases (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT NOT NULL,
    type ENUM('warranty','non-warranty'),
    status ENUM('DRAFT','ASSIGNED','IN_PROGRESS','COMPLETE','CANCELED','PAID') NOT NULL,
    draft_status DATETIME,
    assigned_status DATETIME,
    progress_status DATETIME,
    complete_status DATETIME,
    canceled_status DATETIME,
    paid_status DATETIME NULL,
    priority ENUM('LOW','MEDIUM','HIGH','CRITICAL'),
    customer_id INT,
    admin_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(user_id),
    FOREIGN KEY (admin_id) REFERENCES Admin(user_id)
);

CREATE TABLE IF NOT EXISTS Technician_Case (
    technician_id INT,
    case_id INT,
    PRIMARY KEY (technician_id, case_id),
    FOREIGN KEY (technician_id) REFERENCES Technician(user_id),
    FOREIGN KEY (case_id) REFERENCES Cases(case_id)
);

-- CaseComment table for case detail messages
CREATE TABLE IF NOT EXISTS CaseComment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    case_id INT NOT NULL,
    user_id INT NOT NULL,
    user_role ENUM('admin','technician','customer') NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (case_id) REFERENCES Cases(case_id)
);

CREATE TABLE IF NOT EXISTS Item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL UNIQUE,
    price NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS Bill (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    case_id INT,
    FOREIGN KEY (case_id) REFERENCES Cases(case_id)
);

CREATE TABLE IF NOT EXISTS BillItem (
    bill_id INT,
    item_id INT,
    PRIMARY KEY (bill_id, item_id),
    FOREIGN KEY (bill_id) REFERENCES Bill(bill_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE IF NOT EXISTS Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    status ENUM('PENDING','COMPLETE','FAILED','REFUNDED'),
    pending_status DATETIME,
    complete_status DATETIME,
    failed_status DATETIME,
    refunded_status DATETIME,
    transaction_date DATETIME,
    bill_id INT,
    FOREIGN KEY (bill_id) REFERENCES Bill(bill_id)
);

--set starting number
ALTER TABLE company AUTO_INCREMENT = 0;
ALTER TABLE admin AUTO_INCREMENT = 1000000;
ALTER TABLE technician AUTO_INCREMENT = 2000000;
ALTER TABLE customer AUTO_INCREMENT = 3000000;
ALTER TABLE cases AUTO_INCREMENT = 4000000;
ALTER TABLE item AUTO_INCREMENT = 5000000;
ALTER TABLE bill AUTO_INCREMENT = 6000000;
ALTER TABLE payment AUTO_INCREMENT = 7000000;
ALTER TABLE casecomment AUTO_INCREMENT = 8000000;

--Drop Tables
--DROP TABLE IF EXISTS
    Payment,
    BillItem,
    Bill,
    Item,
    Technician_Case,
    Skill,
    Technician,
    Customer,
    Company,
    Cases,
    Admin;

-- ------------------------------------------------------------
-- Search helpers: View + Stored Procedure for cases
-- ------------------------------------------------------------

-- Consolidated view for case search across related tables
DROP VIEW IF EXISTS vw_case_search;
CREATE VIEW vw_case_search AS
SELECT
    c.case_id,
    c.description,
    c.type,
    c.status,
    c.priority,
    c.draft_status,
    c.assigned_status,
    c.progress_status,
    c.complete_status,
    c.canceled_status,
    c.paid_status,
    c.customer_id,
    cu.name       AS customer_name,
    c.admin_id,
    a.name        AS admin_name,
    a.email       AS admin_email,
    b.bill_id,
    b.amount      AS bill_amount,
    bi.item_id,
    i.item_name,
    GROUP_CONCAT(DISTINCT t.name ORDER BY t.name SEPARATOR ', ') AS technicians
FROM Cases c
LEFT JOIN Customer       cu ON cu.user_id = c.customer_id
LEFT JOIN Admin          a  ON a.user_id  = c.admin_id
LEFT JOIN Bill           b  ON b.case_id  = c.case_id
LEFT JOIN BillItem       bi ON bi.bill_id = b.bill_id
LEFT JOIN Item           i  ON i.item_id  = bi.item_id
LEFT JOIN Technician_Case tc ON tc.case_id = c.case_id
LEFT JOIN Technician     t  ON t.user_id  = tc.technician_id
GROUP BY
    c.case_id, c.description, c.type, c.status, c.priority,
    c.draft_status, c.assigned_status, c.progress_status, c.complete_status,
    c.canceled_status, c.paid_status, c.customer_id, cu.name,
    c.admin_id, a.name, a.email, b.bill_id, b.amount, bi.item_id, i.item_name;

-- Stored procedure: flexible search with optional filters
DROP PROCEDURE IF EXISTS sp_search_cases;
DELIMITER $$
CREATE PROCEDURE sp_search_cases(
    IN p_query         VARCHAR(255),   -- text query across id/description/customer/item/admin
    IN p_status        VARCHAR(20),    -- DRAFT/ASSIGNED/IN_PROGRESS/COMPLETE/CANCELED/PAID
    IN p_customer_id   INT,            -- filter by customer id
    IN p_technician_id INT             -- filter by technician id
)
BEGIN
    SELECT vw.*
    FROM vw_case_search vw
    WHERE (p_query IS NULL OR p_query = ''
                 OR CAST(vw.case_id AS CHAR) LIKE CONCAT('%', p_query, '%')
                 OR vw.description LIKE CONCAT('%', p_query, '%')
                 OR vw.customer_name LIKE CONCAT('%', p_query, '%')
                 OR vw.item_name LIKE CONCAT('%', p_query, '%')
                 OR vw.admin_name LIKE CONCAT('%', p_query, '%'))
        AND (p_status IS NULL OR p_status = '' OR vw.status = p_status)
        AND (p_customer_id IS NULL OR vw.customer_id = p_customer_id)
        AND (
            p_technician_id IS NULL
            OR EXISTS (
                SELECT 1
                FROM Technician_Case tc
                WHERE tc.case_id = vw.case_id AND tc.technician_id = p_technician_id
            )
        )
    ORDER BY vw.case_id DESC;
END $$
DELIMITER ;
