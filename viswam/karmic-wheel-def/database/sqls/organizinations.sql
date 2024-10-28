-- create a table for organization_types
CREATE TABLE organization_types (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert the following data into the organization_types table
-- Independent Worker
-- GIVRS
-- Family
-- Group of People
-- Industry
-- Industry Segment
-- Micro
-- Small
-- Medium
-- Enterprise
-- MNC
-- Organization Department
-- Vendor
-- Client
-- Community
-- Government
-- NGO
-- NPO
-- create insert statements for the organization_types table
INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Independent Worker',
        'A person who works independently'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    ('GIVRS', 'A person who gives');

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Family',
        'A group of people related by blood or marriage'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Group of People',
        'A group of people working together'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Industry',
        'A group of companies working in the same sector'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    ('Industry Segment', 'A segment of an industry');

INSERT INTO
    organization_types (name, description)
VALUES
    ('Micro', 'A small organization');

INSERT INTO
    organization_types (name, description)
VALUES
    ('Small', 'A small organization');

INSERT INTO
    organization_types (name, description)
VALUES
    ('Medium', 'A medium organization');

INSERT INTO
    organization_types (name, description)
VALUES
    ('Enterprise', 'A large organization');

INSERT INTO
    organization_types (name, description)
VALUES
    ('MNC', 'A multinational corporation');

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Organization Department',
        'A department within an organization'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Vendor',
        'A company that supplies goods or services'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Client',
        'A company that buys goods or services'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    (
        'Community',
        'A group of people living in the same area'
    );

INSERT INTO
    organization_types (name, description)
VALUES
    ('Government', 'A government organization');

INSERT INTO
    organization_types (name, description)
VALUES
    ('NGO', 'A non-governmental organization');

INSERT INTO
    organization_types (name, description)
VALUES
    ('NPO', 'A non-profit organization');

-- create table organizations
CREATE TABLE organizations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    organization_type_id INT NOT NULL,
    parent_organization_id INT,
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    postal_code VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    INDEX (id),
    FOREIGN KEY (organization_type_id) REFERENCES organization_types(id),
    FOREIGN KEY (parent_organization_id) REFERENCES organizations(id)
);

-- create a table for reference material with columns
-- Reference
-- orginization_id
-- Author Name
-- Language
-- Reference URL
-- User ID
-- Password
-- Notes
CREATE TABLE reference_material (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(255) NOT NULL,
    organization_id INT NOT NULL,
    author_name VARCHAR(255),
    language VARCHAR(255),
    reference_url VARCHAR(255),
    user_id VARCHAR(255),
    password VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    INDEX (id),
    FOREIGN KEY (organization_id) REFERENCES organizations(id)
);