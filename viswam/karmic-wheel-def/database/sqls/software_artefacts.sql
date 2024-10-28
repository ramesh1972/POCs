-- create mysql table for software_artefact_types
CREATE TABLE software_artefact_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- create insert statement for software_artefact_types for
-- Software Artefact
-- Software Evaluated
-- Software Trialed
-- Software Prototype
-- Software 3rd Party
-- Website
-- Mobile App
-- Desktop App
-- Widget
-- CLI
-- Script
-- Software System
-- Software Product
-- Software Service
-- Software Tool
-- Software SDK
-- Sotware Open Source SDK
-- Data Store
-- Data Record
-- Component
-- Module
-- Library
-- Framework
-- Software Collection Group
-- Template
-- Pattern
INSERT INTO
    software_artefact_types (name, description)
VALUES
    (
        'Software Artefact',
        'A software artefact is a software product, service, tool, system, or component that is created as a result of a software development process.'
    ),
    (
        'Software Evaluated',
        'A software artefact that has been evaluated.'
    ),
    (
        'Software Trialed',
        'A software artefact that has been trialed.'
    ),
    (
        'Software Prototype',
        'A software artefact that is a prototype.'
    ),
    (
        'Software 3rd Party',
        'A software artefact that is a 3rd party software product.'
    ),
    (
        'Website',
        'A software artefact that is a website.'
    ),
    (
        'Mobile App',
        'A software artefact that is a mobile app.'
    ),
    (
        'Desktop App',
        'A software artefact that is a desktop app.'
    ),
    (
        'Widget',
        'A software artefact that is a widget.'
    ),
    (
        'CLI',
        'A software artefact that is a command line interface.'
    ),
    (
        'Script',
        'A software artefact that is a script.'
    ),
    (
        'Software System',
        'A software artefact that is a software system.'
    ),
    (
        'Software Product',
        'A software artefact that is a software product.'
    ),
    (
        'Software Service',
        'A software artefact that is a software service.'
    ),
    (
        'Software Tool',
        'A software artefact that is a software tool.'
    ),
    (
        'Software SDK',
        'A software artefact that is a software development kit.'
    ),
    (
        'Software Open Source SDK',
        'A software artefact that is an open source software development kit.'
    ),
    (
        'Data Store',
        'A software artefact that is a data store.'
    ),
    (
        'Data Record',
        'A software artefact that is a data record.'
    ),
    (
        'Component',
        'A software artefact that is a component.'
    ),
    (
        'Module',
        'A software artefact that is a module.'
    ),
    (
        'Library',
        'A software artefact that is a library.'
    ),
    (
        'Framework',
        'A software artefact that is a framework.'
    ),
    (
        'Software Collection Group',
        'A software artefact that is a collection group.'
    ),
    (
        'Template',
        'A software artefact that is a template.'
    ),
    (
        'Pattern',
        'A software artefact that is a pattern.'
    );

-- create table for software_artefact_evolution_stages
CREATE TABLE software_artefact_evolution_stages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    stage_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- create insert statements for the following artefact stages
-- Ideate
-- Seed Thought
-- Pre Metric Collection
-- Conceptualize
-- Requirement Elaboration
-- Design
-- Effort Estimation
-- Team Formation
-- Plan
-- Dev Not Started
-- Dev In Progress
-- Dev In Review
-- Dev Completed
-- Quality Test
-- User Acceptance Test
-- Release
-- Sanity Test
-- Monitor
-- Support
-- Post Metric Collection
-- Report Generation
-- Analysis
-- Customer Suggestion Collection
-- Feedback Loop
-- Enhancment Request
-- Evolution in Transition 
-- Artefact Freeze
-- Artefact Decommissioned
-- Artefact Retired
-- Artefact Replaced
INSERT INTO
    software_artefact_evolution_stages (name, description, stage_order)
VALUES
    (
        'Ideate',
        'The stage where the idea is conceived.',
        1
    ),
    (
        'Seed Thought',
        'The stage where the thought is seeded.',
        2
    ),
    (
        'Pre Metric Collection',
        'The stage before metric collection.',
        3
    ),
    (
        'Conceptualize',
        'The stage where the concept is developed.',
        4
    ),
    (
        'Requirement Elaboration',
        'The stage where the requirements are elaborated.',
        5
    ),
    (
        'Design',
        'The stage where the design is developed.',
        6
    ),
    (
        'Effort Estimation',
        'The stage where the effort is estimated.',
        7
    ),
    (
        'Team Formation',
        'The stage where the team is formed.',
        8
    ),
    (
        'Plan',
        'The stage where the plan is developed.',
        9
    ),
    (
        'Dev Not Started',
        'The stage where development has not started.',
        10
    ),
    (
        'Dev In Progress',
        'The stage where development is in progress.',
        11
    ),
    (
        'Dev In Review',
        'The stage where development is in review.',
        12
    ),
    (
        'Dev Completed',
        'The stage where development is completed.',
        13
    ),
    (
        'Quality Test',
        'The stage where quality testing is performed.',
        14
    ),
    (
        'User Acceptance Test',
        'The stage where user acceptance testing is performed.',
        15
    ),
    (
        'Release',
        'The stage where the artefact is released.',
        16
    ),
    (
        'Sanity Test',
        'The stage where sanity testing is performed.',
        17
    ),
    (
        'Monitor',
        'The stage where the artefact is monitored.',
        18
    ),
    (
        'Support',
        'The stage where support is provided.',
        19
    ),
    (
        'Post Metric Collection',
        'The stage after metric collection.',
        20
    ),
    (
        'Report Generation',
        'The stage where reports are generated.',
        21
    ),
    (
        'Analysis',
        'The stage where analysis is performed.',
        22
    ),
    (
        'Customer Suggestion Collection',
        'The stage where customer suggestions are collected.',
        23
    ),
    (
        'Feedback Loop',
        'The stage where feedback is looped.',
        24
    ),
    (
        'Enhancment Request',
        'The stage where enhancement requests are made.',
        25
    ),
    (
        'Evolution in Transition',
        'The stage where evolution is in transition.',
        26
    ),
    (
        'Artefact Freeze',
        'The stage where the artefact is frozen.',
        27
    ),
    (
        'Artefact Decommissioned',
        'The stage where the artefact is decommissioned.',
        28
    ),
    (
        'Artefact Retired',
        'The stage where the artefact is retired.',
        29
    ),
    (
        'Artefact Replaced',
        'The stage where the artefact is replaced.',
        30
    );

-- creat table for software base architecture types
CREATE TABLE software_base_architecture_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert statements for the following base architecture types
-- Monolithic Architecture
-- Application Architecture
-- System Architecture
-- Data Architecture
-- Cloud Native Architecture
-- Enterprise Architecture
-- Information Architecture
-- Data Science Architecure
-- Machine Learning Architecture
-- Artificial Intelligence Architecture
-- Enterprise Architecture
INSERT INTO
    software_base_architecture_types (name, description)
VALUES
    (
        'Monolithic Architecture',
        'A monolithic architecture is a software architecture where the software is built as a single unit.'
    ),
    (
        'Application Architecture',
        'An application architecture is a software architecture where the software is built as an application.'
    ),
    (
        'System Architecture',
        'A system architecture is a software architecture where the software is built as a system.'
    ),
    (
        'Data Architecture',
        'A data architecture is a software architecture where the software is built as a data architecture.'
    ),
    (
        'Cloud Native Architecture',
        'A cloud native architecture is a software architecture where the software is built as a cloud native architecture.'
    ),
    (
        'Enterprise Architecture',
        'An enterprise architecture is a software architecture where the software is built as an enterprise architecture.'
    ),
    (
        'Information Architecture',
        'An information architecture is a software architecture where the software is built as an information architecture.'
    ),
    (
        'Data Science Architecure',
        'A data science architecture is a software architecture where the software is built as a data science architecture.'
    ),
    (
        'Machine Learning Architecture',
        'A machine learning architecture is a software architecture where the software is built as a machine learning architecture.'
    ),
    (
        'Artificial Intelligence Architecture',
        'An artificial intelligence architecture is a software architecture where the software is built as an artificial intelligence architecture.'
    );

-- create table for software architecure patterns
CREATE TABLE software_architecture_patterns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- ALTER table to add software_base_architecture_type_id
ALTER TABLE
    software_architecture_patterns
ADD
    COLUMN software_base_architecture_type_id INT,
ADD
    FOREIGN KEY (software_base_architecture_type_id) REFERENCES software_base_architecture_types(id);

-- insert statements for the following architecture patterns
-- Pub-Sub
-- Workflow
-- Business Process Automation
-- Saga
-- Strangle
-- Event Sourcing
-- CQRS
-- Microservices
-- Serverless
-- Monolith
Insert INTO
    software_architecture_patterns (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'Pub-Sub',
        'A pub-sub architecture pattern is a software architecture pattern where the software is built as a pub-sub architecture pattern.',
        3
    ),
    (
        'Workflow',
        'A workflow architecture pattern is a software architecture pattern where the software is built as a workflow architecture pattern.',
        3
    ),
    (
        'Business Process Automation',
        'A business process automation architecture pattern is a software architecture pattern where the software is built as a business process automation architecture pattern.',
        3
    ),
    (
        'Saga',
        'A saga architecture pattern is a software architecture pattern where the software is built as a saga architecture pattern.',
        3
    ),
    (
        'Strangle',
        'A strangle architecture pattern is a software architecture pattern where the software is built as a strangle architecture pattern.',
        3
    ),
    (
        'Event Sourcing',
        'An event sourcing architecture pattern is a software architecture pattern where the software is built as an event sourcing architecture pattern.',
        3
    ),
    (
        'CQRS',
        'A CQRS architecture pattern is a software architecture pattern where the software is built as a CQRS architecture pattern.',
        3
    ),
    (
        'Microservices',
        'A microservices architecture pattern is a software architecture pattern where the software is built as a microservices architecture pattern.',
        3
    ),
    (
        'Serverless',
        'A serverless architecture pattern is a software architecture pattern where the software is built as a serverless architecture pattern.',
        3
    ),
    (
        'Monolith',
        'A monolith architecture pattern is a software architecture pattern where the software is built as a monolith architecture pattern.',
        3
    ),
    (
        'Microfrontend',
        'A microfrontend architecture pattern is a software architecture pattern where the software is built as a microfrontend architecture pattern.',
        2
    ),
    (
        'Component',
        'A component architecture pattern is a software architecture pattern where the software is built as a component architecture pattern.',
        2
    ) -- create table for software_architectures
    CREATE TABLE software_architectures (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        software_base_architecture_type_id INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by INT DEFAULT 0,
        updated_by INT DEFAULT 0,
        FOREIGN KEY (software_base_architecture_type_id) REFERENCES software_base_architecture_types(id) UNIQUE (name),
        INDEX (id)
    );

-- insert into software_architectures following application architectures
-- CLI
-- Website
-- SPA
-- Desktop App
-- Native App
-- Hybrid App
-- PWA
-- Widget
-- Web View
-- Web Component
-- Web Assembly
-- Microfrontend
-- with base architecture type as Application Architecture
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'CLI',
        'A CLI architecture is a software architecture where the software is built as a CLI architecture.',
        2
    ),
    (
        'Website',
        'A website architecture is a software architecture where the software is built as a website architecture.',
        2
    ),
    (
        'SPA',
        'A SPA architecture is a software architecture where the software is built as a SPA architecture.',
        2
    ),
    (
        'Desktop App',
        'A desktop app architecture is a software architecture where the software is built as a desktop app architecture.',
        2
    ),
    (
        'Native App',
        'A native app architecture is a software architecture where the software is built as a native app architecture.',
        2
    ),
    (
        'Hybrid App',
        'A hybrid app architecture is a software architecture where the software is built as a hybrid app architecture.',
        2
    ),
    (
        'PWA',
        'A PWA architecture is a software architecture where the software is built as a PWA architecture.',
        2
    ),
    (
        'Widget',
        'A widget architecture is a software architecture where the software is built as a widget architecture.',
        2
    ),
    (
        'Web View',
        'A web view architecture is a software architecture where the software is built as a web view architecture.',
        2
    ),
    (
        'Web Component',
        'A web component architecture is a software architecture where the software is built as a web component architecture.',
        2
    ),
    (
        'Web Assembly',
        'A web assembly architecture is a software architecture where the software is built as a web assembly architecture.',
        2
    ),
    (
        'Microfrontend',
        'A microfrontend architecture is a software architecture where the software is built as a microfrontend architecture.',
        2
    );

-- insert into software_architectures following system architectures
-- Monolithic
-- Client Server
-- Layered
-- n-Tiered
-- Distributed
-- Parallel
-- Middleware
-- MOM
-- Event Oriented
-- Workflow Oriented
-- SOA
-- MVC
-- MVVM
-- MVP
-- MVW
-- Microservices
-- Other
-- with base architecture type as System Architecture
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'Monolithic',
        'A monolithic architecture is a software architecture where the software is built as a monolithic architecture.',
        3
    ),
    (
        'Client Server',
        'A client server architecture is a software architecture where the software is built as a client server architecture.',
        3
    ),
    (
        'Layered',
        'A layered architecture is a software architecture where the software is built as a layered architecture.',
        3
    ),
    (
        'n-Tiered',
        'An n-tiered architecture is a software architecture where the software is built as an n-tiered architecture.',
        3
    ),
    (
        'Distributed',
        'A distributed architecture is a software architecture where the software is built as a distributed architecture.',
        3
    ),
    (
        'Parallel',
        'A parallel architecture is a software architecture where the software is built as a parallel architecture.',
        3
    ),
    (
        'Middleware',
        'A middleware architecture is a software architecture where the software is built as a middleware architecture.',
        3
    ),
    (
        'MOM',
        'A MOM architecture is a software architecture where the software is built as a MOM architecture.',
        3
    ),
    (
        'Event Oriented',
        'An event oriented architecture is a software architecture where the software is built as an event oriented architecture.',
        3
    ),
    (
        'Workflow Oriented',
        'A workflow oriented architecture is a software architecture where the software is built as a workflow oriented architecture.',
        3
    ),
    (
        'SOA',
        'A SOA architecture is a software architecture where the software is built as a SOA architecture.',
        3
    ),
    (
        'MVC',
        'An MVC architecture is a software architecture where the software is built as an MVC architecture.',
        3
    ),
    (
        'MVVM',
        'An MVVM architecture is a software architecture where the software is built as an MVVM architecture.',
        3
    ),
    (
        'MVP',
        'An MVP architecture is a software architecture where the software is built as an MVP architecture.',
        3
    ),
    (
        'MVW',
        'An MVW architecture is a software architecture where the software is built as an MVW architecture.',
        3
    ),
    (
        'Microservices',
        'A microservices architecture is a software architecture where the software is built as a microservices architecture.',
        3
    ),
    (
        'Other',
        'An other architecture is a software architecture where the software is built as an other architecture.',
        3
    );

-- insert into software_architectures following data architectures
-- RDBMS
-- NoSQL
-- Flat Files
-- Big Data
-- Data Lake
-- Data Warehouse
-- OLAP
-- OLTP
-- Data Mart
-- Object Oriented
-- Graph
-- Document
-- Key Value
-- Columnar
-- Time Series
-- In Memory
-- Vector
-- Spatial
-- with base architecture type as Data Architecture
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'RDBMS',
        'A RDBMS architecture is a software architecture where the software is built as a RDBMS architecture.',
        4
    ),
    (
        'NoSQL',
        'A NoSQL architecture is a software architecture where the software is built as a NoSQL architecture.',
        4
    ),
    (
        'Flat Files',
        'A flat files architecture is a software architecture where the software is built as a flat files architecture.',
        4
    ),
    (
        'Big Data',
        'A big data architecture is a software architecture where the software is built as a big data architecture.',
        4
    ),
    (
        'Data Lake',
        'A data lake architecture is a software architecture where the software is built as a data lake architecture.',
        4
    ),
    (
        'Data Warehouse',
        'A data warehouse architecture is a software architecture where the software is built as a data warehouse architecture.',
        4
    ),
    (
        'OLAP',
        'An OLAP architecture is a software architecture where the software is built as an OLAP architecture.',
        4
    ),
    (
        'OLTP',
        'An OLTP architecture is a software architecture where the software is built as an OLTP architecture.',
        4
    ),
    (
        'Data Mart',
        'A data mart architecture is a software architecture where the software is built as a data mart architecture.',
        4
    ),
    (
        'Object Oriented',
        'An object oriented architecture is a software architecture where the software is built as an object oriented architecture.',
        4
    ),
    (
        'Graph',
        'A graph architecture is a software architecture where the software is built as a graph architecture.',
        4
    ),
    (
        'Document',
        'A document architecture is a software architecture where the software is built as a document architecture.',
        4
    ),
    (
        'Key Value',
        'A key value architecture is a software architecture where the software is built as a key value architecture.',
        4
    ),
    (
        'Columnar',
        'A columnar architecture is a software architecture where the software is built as a columnar architecture.',
        4
    ),
    (
        'Time Series',
        'A time series architecture is a software architecture where the software is built as a time series architecture.',
        4
    ),
    (
        'In Memory',
        'An in memory architecture is a software architecture where the software is built as an in memory architecture.',
        4
    ),
    (
        'Vector',
        'A vector architecture is a software architecture where the software is built as a vector architecture.',
        4
    ),
    (
        'Spatial',
        'A spatial architecture is a software architecture where the software is built as a spatial architecture.',
        4
    );

-- insert into software_architectures following cloud native architectures
-- IaaS (Infrastructure)
-- PaaS (Platform)
-- SaaS (Software)    
-- BaaS (Business)
-- FaaS (Function)
-- CaaS (Container)
-- DaaS (Desktop)
-- DBaaS (Database)
-- STaaS (Storage)
-- IPaaS (Integration)
-- MLaaS (Machine Learning)
-- AIaaS (Artificial Intelligence)
-- SECaaS (Security)
-- IDaaS (Identity)
-- DRaaS (Disaster Recovery)
-- MaaS (Mobility)
-- DevOpsaaS
-- BCaaS (Blockchain)
-- IoTaaS
-- VRaaS (Virtual Reality)
-- MetaaaS (Metaverse)
-- with base architecture type as Cloud Native Architecture
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'IaaS (Infrastructure)',
        'An IaaS architecture is a software architecture where the software is built as an IaaS architecture.',
        5
    ),
    (
        'PaaS (Platform)',
        'A PaaS architecture is a software architecture where the software is built as a PaaS architecture.',
        5
    ),
    (
        'SaaS (Software)',
        'A SaaS architecture is a software architecture where the software is built as a SaaS architecture.',
        5
    ),
    (
        'BaaS (Business)',
        'A BaaS architecture is a software architecture where the software is built as a BaaS architecture.',
        5
    ),
    (
        'FaaS (Function)',
        'A FaaS architecture is a software architecture where the software is built as a FaaS architecture.',
        5
    ),
    (
        'CaaS (Container)',
        'A CaaS architecture is a software architecture where the software is built as a CaaS architecture.',
        5
    ),
    (
        'DaaS (Desktop)',
        'A DaaS architecture is a software architecture where the software is built as a DaaS architecture.',
        5
    ),
    (
        'DBaaS (Database)',
        'A DBaaS architecture is a software architecture where the software is built as a DBaaS architecture.',
        5
    ),
    (
        'STaaS (Storage)',
        'A STaaS architecture is a software architecture where the software is built as a STaaS architecture.',
        5
    ),
    (
        'IPaaS (Integration)',
        'An IPaaS architecture is a software architecture where the software is built as an IPaaS architecture.',
        5
    ),
    (
        'MLaaS (Machine Learning)',
        'An MLaaS architecture is a software architecture where the software is built as an MLaaS architecture.',
        5
    ),
    (
        'AIaaS (Artificial Intelligence)',
        'An AIaaS architecture is a software architecture where the software is built as an AIaaS architecture.',
        5
    ),
    (
        'SECaaS (Security)',
        'A SECaaS architecture is a software architecture where the software is built as a SECaaS architecture.',
        5
    ),
    (
        'IDaaS (Identity)',
        'An IDaaS architecture is a software architecture where the software is built as an IDaaS architecture.',
        5
    ),
    (
        'DRaaS (Disaster Recovery)',
        'A DRaaS architecture is a software architecture where the software is built as a DRaaS architecture.',
        5
    ),
    (
        'MaaS (Mobility)',
        'A MaaS architecture is a software architecture where the software is built as a MaaS architecture.',
        5
    ),
    (
        'DevOpsaaS',
        'A DevOpsaaS architecture is a software architecture where the software is built as a DevOpsaaS architecture.',
        5
    ),
    (
        'BCaaS (Blockchain)',
        'A BCaaS architecture is a software architecture where the software is built as a BCaaS architecture.',
        5
    ),
    (
        'IoTaaS',
        'An IoTaaS architecture is a software architecture where the software is built as an IoTaaS architecture.',
        5
    ),
    (
        'VRaaS (Virtual Reality)',
        'A VRaaS architecture is a software architecture where the software is built as a VRaaS architecture.',
        5
    ),
    (
        'MetaaaS (Metaverse)',
        'A MetaaaS architecture is a software architecture where the software is built as a MetaaaS architecture.',
        5
    );

-- insert into software_architectures the enterprise architectures
-- EA (Enterprise Architecture)
-- TOGAF (The Open Group Architecture Framework)
-- Zachman Framework
-- Gartner EA Framework
-- MIT EA Framework
-- with base architecture type as Enterprise Architecture
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'EA (Enterprise Architecture)',
        'An EA (Enterprise Architecture) architecture is a software architecture where the software is built as an EA (Enterprise Architecture) architecture.',
        6
    ),
    (
        'TOGAF (The Open Group Architecture Framework)',
        'A TOGAF (The Open Group Architecture Framework) architecture is a software architecture where the software is built as a TOGAF (The Open Group Architecture Framework) architecture.',
        6
    ),
    (
        'Zachman Framework',
        'A Zachman Framework architecture is a software architecture where the software is built as a Zachman Framework architecture.',
        6
    ),
    (
        'Gartner EA Framework',
        'A Gartner EA Framework architecture is a software architecture where the software is built as a Gartner EA Framework architecture.',
        6
    ),
    (
        'MIT EA Framework',
        'A MIT EA Framework architecture is a software architecture where the software is built as a MIT EA Framework architecture.',
        6
    );

-- insert into software_architectures the information architectures
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'Hierarchical Information Architecture',
        'Organizes information in a hierarchical structure with parent-child relationships.',
        7
    ),
    (
        'Network Information Architecture',
        'Represents information as interconnected nodes or entities with multiple relationships.',
        7
    ),
    (
        'Taxonomy Information Architecture',
        'Defines a classification system for organizing information into categories and subcategories based on shared characteristics or attributes.',
        7
    ),
    (
        'Faceted Information Architecture',
        'Structures information based on multiple dimensions or facets, allowing users to filter and refine search results dynamically.',
        7
    ),
    (
        'Metadata Information Architecture',
        'Focuses on defining and managing metadata, which provides descriptive information about the content, context, and attributes of information objects.',
        7
    ),
    (
        'Ontology Information Architecture',
        'Represents knowledge domains and concepts using formalized semantics and relationships.',
        7
    ),
    (
        'Federated Information Architecture',
        'Integrates and aggregates information from distributed and heterogeneous sources across multiple systems or domains.',
        7
    ),
    (
        'Service-Oriented Information Architecture',
        'Organizes information resources as modular and reusable services, decoupled from underlying systems and technologies.',
        7
    );

-- insert into software_architectures following data science architectures
-- Data Mining
-- Data Curation
-- Data De-Dupe
-- Data Preprocessing
-- Embeddings
-- Data Modeling (ML)
-- NER
-- NLP
-- Cognitive Service
-- AI
-- Data Analytics
-- Data Classification
-- Data Categorization
-- Data Visualization
-- Prediction
-- Fitment
-- MLOps
-- Supervised
-- Unsupervised
-- Nueal Network
-- CNN
-- RNN
-- Anomaly Detection
-- Deep Learning
-- Reinforcement Learning
-- Optimization and Operations Research
-- Geospatial Analysis
-- Forecasting and Predictive Analytics
-- Explainable AI (XAI)
-- Generative AI (LLM)
-- Generative AI (SLM)
-- AGI (Artificial General Intelligence)
-- ASI (Artificial Super Intelligence)
-- ANI (Artificial Narrow Intelligence)
-- Robotics
-- with base architecture type as Data Science Architecture
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'Data Mining',
        'A data mining architecture is a software architecture where the software is built as a data mining architecture.',
        6
    ),
    (
        'Data Curation',
        'A data curation architecture is a software architecture where the software is built as a data curation architecture.',
        6
    ),
    (
        'Data De-Dupe',
        'A data de-dupe architecture is a software architecture where the software is built as a data de-dupe architecture.',
        6
    ),
    (
        'Data Preprocessing',
        'A data preprocessing architecture is a software architecture where the software is built as a data preprocessing architecture.',
        6
    ),
    (
        'Embeddings',
        'An embeddings architecture is a software architecture where the software is built as an embeddings architecture.',
        6
    ),
    (
        'Data Modeling (ML)',
        'A data modeling (ML) architecture is a software architecture where the software is built as a data modeling (ML) architecture.',
        6
    ),
    (
        'NER',
        'A NER architecture is a software architecture where the software is built as a NER architecture.',
        6
    ),
    (
        'NLP',
        'A NLP architecture is a software architecture where the software is built as a NLP architecture.',
        6
    ),
    (
        'Cognitive Service',
        'A cognitive service architecture is a software architecture where the software is built as a cognitive service architecture.',
        6
    ),
    (
        'AI',
        'An AI architecture is a software architecture where the software is built as an AI architecture.',
        6
    ),
    (
        'Data Analytics',
        'A data analytics architecture is a software architecture where the software is built as a data analytics architecture.',
        6
    ),
    (
        'Data Classification',
        'A data classification architecture is a software architecture where the software is built as a data classification architecture.',
        6
    ),
    (
        'Data Categorization',
        'A data categorization architecture is a software architecture where the software is built as a data categorization architecture.',
        6
    ),
    (
        'Data Visualization',
        'A data visualization architecture is a software architecture where the software is built as a data visualization architecture.',
        6
    ),
    (
        'Prediction',
        'A prediction architecture is a software architecture where the software is built as a prediction architecture.',
        6
    ),
    (
        'Fitment',
        'A fitment architecture is a software architecture where the software is built as a fitment architecture.',
        6
    ),
    (
        'MLOps',
        'A MLOps architecture is a software architecture where the software is built as a MLOps architecture.',
        6
    ),
    (
        'Supervised',
        'A supervised architecture is a software architecture where the software is built as a supervised architecture.',
        6
    ),
    (
        'Unsupervised',
        'An unsupervised architecture is a software architecture where the software is built as an unsupervised architecture.',
        6
    ),
    (
        'Nueal Network',
        'A nueal network architecture is a software architecture where the software is built as a nueal network architecture.',
        6
    ),
    (
        'CNN',
        'A CNN architecture is a software architecture where the software is built as a CNN architecture.',
        6
    ),
    (
        'RNN',
        'A RNN architecture is a software architecture where the software is built as a RNN architecture.',
        6
    ),
    (
        'Anomaly Detection',
        'An anomaly detection architecture is a software architecture where the software is built as an anomaly detection architecture.',
        6
    ),
    (
        'Optimization and Operations Research',
        'An optimization and operations research architecture is a software architecture where the software is built as an optimization and operations research architecture.',
        6
    ),
    (
        'Geospatial Analysis',
        'A geospatial analysis architecture is a software architecture where the software is built as a geospatial analysis architecture.',
        6
    ),
    (
        'Forecasting and Predictive Analytics',
        'A forecasting and predictive analytics architecture is a software architecture where the software is built as a forecasting and predictive analytics architecture.',
        6
    ),
    (
        'Explainable AI (XAI)',
        'An explainable AI (XAI) architecture is a software architecture where the software is built as an explainable AI (XAI) architecture.',
        6
    ),
    (
        'Generative AI (LLM)',
        'A generative AI (LLM) architecture is a software architecture where the software is built as a generative AI (LLM) architecture.',
        6
    ),
    (
        'Generative AI (SLM)',
        'A generative AI (SLM) architecture is a software architecture where the software is built as a generative AI (SLM) architecture.',
        6
    ),
    (
        'AGI (Artificial General Intelligence)',
        'An AGI (Artificial General Intelligence) architecture is a software architecture where the software is built as an AGI (Artificial General Intelligence) architecture.',
        6
    ),
    (
        'ASI (Artificial Super Intelligence)',
        'An ASI (Artificial Super Intelligence) architecture is a software architecture where the software is built as an ASI (Artificial Super Intelligence) architecture.',
        6
    ),
    (
        'ANI (Artificial Narrow Intelligence)',
        'An ANI (Artificial Narrow Intelligence) architecture is a software architecture where the software is built as an ANI (Artificial Narrow Intelligence) architecture.',
        6
    ),
    (
        'Robotics',
        'A robotics architecture is a software architecture where the software is built as a robotics architecture.',
        6
    );

-- machine learning arch
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'Supervised Learning',
        'Uses labeled training data to learn the mapping between input features and target labels.',
        9
    ),
    (
        'Unsupervised Learning',
        'Extracts patterns and structures from unlabeled data without explicit supervision.',
        9
    ),
    (
        'Semi-supervised Learning',
        'Combines labeled and unlabeled data for training, leveraging both supervised and unsupervised learning techniques.',
        9
    ),
    (
        'Reinforcement Learning',
        'Teaches agents to make sequential decisions by interacting with an environment to maximize cumulative rewards.',
        9
    ),
    (
        'Deep Learning',
        'Utilizes deep neural networks with multiple layers to learn hierarchical representations of data.',
        9
    ),
    (
        'Transfer Learning',
        'Transfers knowledge from one task or domain to another, leveraging pre-trained models for new tasks or domains.',
        9
    ),
    (
        'Online Learning',
        'Adapts to new data incrementally, updating the model continuously over time.',
        9
    ),
    (
        'Ensemble Learning',
        'Combines predictions from multiple machine learning models to improve overall performance.',
        9
    ),
    (
        'Convolutional Neural Networks (CNNs)',
        'Specialized deep neural networks designed for processing structured grid data, commonly used in computer vision tasks.',
        9
    ),
    (
        'Recurrent Neural Networks (RNNs)',
        'Neural networks with recurrent connections, suitable for sequential data processing tasks such as natural language processing and time series analysis.',
        9
    ),
    (
        'Long Short-Term Memory (LSTM) Networks',
        'A type of recurrent neural network architecture designed to overcome the vanishing gradient problem and capture long-term dependencies in sequential data.',
        9
    ),
    (
        'Generative Adversarial Networks (GANs)',
        'Consists of two neural networks, a generator and a discriminator, trained adversarially to generate realistic data samples.',
        9
    ),
    (
        'Transformer Models',
        'Architecture based on self-attention mechanisms, widely used in natural language processing tasks such as machine translation and text summarization.',
        9
    ),
    (
        'Autoencoders',
        'Neural network architectures trained to learn efficient representations of data by reconstructing input data from a compressed latent space.',
        9
    ),
    (
        'Capsule Networks',
        'An alternative neural network architecture designed to capture hierarchical relationships between parts of objects in images.',
        9
    ),
    (
        'Deep Reinforcement Learning',
        'Applies deep learning techniques to reinforcement learning problems, combining deep neural networks with reinforcement learning algorithms.',
        9
    );

-- insert AI archs
INSERT INTO
    software_architectures (
        name,
        description,
        software_base_architecture_type_id
    )
VALUES
    (
        'Expert Systems',
        'Rule-based systems that mimic human expertise to make decisions or solve problems in specific domains.',
        10
    ),
    (
        'Knowledge Representation and Reasoning (KRR)',
        'Techniques for representing knowledge in a structured format and performing logical reasoning over that knowledge.',
        10
    ),
    (
        'Bayesian Networks',
        'Probabilistic graphical models that represent uncertain relationships between variables using directed acyclic graphs.',
        10
    ),
    (
        'Markov Decision Processes (MDPs)',
        'Mathematical frameworks for modeling decision-making processes under uncertainty, commonly used in reinforcement learning.',
        10
    ),
    (
        'Probabilistic Programming',
        'Programming paradigm that enables probabilistic inference and reasoning by integrating probability distributions into the code.',
        10
    ),
    (
        'Symbolic AI',
        'Approach to AI that emphasizes the use of symbols, logic, and symbolic reasoning to represent and manipulate knowledge.',
        10
    ),
    (
        'Evolutionary Algorithms',
        'Stochastic optimization techniques inspired by biological evolution, such as genetic algorithms and genetic programming.',
        10
    ),
    (
        'Swarm Intelligence',
        'Collective behavior of decentralized, self-organized systems inspired by the behavior of social insects and other animal societies.',
        10
    ),
    (
        'Artificial Neural Networks (ANNs)',
        'Biologically inspired computational models composed of interconnected nodes (neurons) organized in layers.',
        10
    ),
    (
        'Fuzzy Logic Systems',
        'Mathematical models that handle uncertainty by representing linguistic terms and fuzzy relationships between variables.',
        10
    ),
    (
        'Case-Based Reasoning (CBR)',
        'Problem-solving approach that retrieves and adapts solutions from a repository of past cases similar to the current problem.',
        10
    ),
    (
        'Deep Belief Networks (DBNs)',
        'Generative neural network models composed of multiple layers of stochastic, latent variables.',
        10
    ),
    (
        'Neuroevolution',
        'Evolutionary computation technique that uses genetic algorithms or other evolutionary algorithms to evolve neural networks.',
        10
    ),
    (
        'Cognitive Architectures',
        'Computational models of human cognition that simulate cognitive processes and behaviors, such as perception, learning, and decision-making.',
        10
    ),
    (
        'Emotion AI',
        'AI systems that recognize, interpret, and respond to human emotions based on facial expressions, voice tone, and other cues.',
        10
    ),
    (
        'Hybrid Intelligent Systems',
        'Integration of multiple AI techniques and methodologies to solve complex problems more effectively.',
        10
    ),
    (
        'Multi-Agent Systems (MAS)',
        'Distributed AI systems composed of multiple autonomous agents that interact with each other to achieve goals.',
        10
    ),
    (
        'Natural Language Processing (NLP) Systems',
        'AI systems that process and understand human language, including tasks such as text classification, sentiment analysis, and machine translation.',
        10
    ),
    (
        'Computer Vision Systems',
        'AI systems that analyze and interpret visual information from images or videos, performing tasks such as object detection, image segmentation, and facial recognition.',
        10
    ),
    (
        'Speech Recognition Systems',
        'AI systems that transcribe spoken language into text and perform tasks such as speaker identification, speech synthesis, and voice-controlled interfaces.',
        10
    ),
    (
        'Robotic Architectures',
        'Software frameworks and architectures that control the behavior and movement of robots, enabling tasks such as navigation, manipulation, and interaction with the environment.',
        10
    ),
    (
        'Autonomous Vehicle Architectures',
        'Software architectures for self-driving vehicles, including perception, decision-making, and control systems that enable autonomous navigation and operation.',
        10
    ),
    (
        'AI Ethics and Governance Frameworks',
        'Guidelines, principles, and frameworks for ensuring ethical and responsible development, deployment, and use of AI technologies.',
        10
    ),
    (
        'Explainable AI (XAI) Systems',
        'AI systems that provide transparent and interpretable explanations for their decisions and predictions, enhancing trust and understanding.',
        10
    ),
    (
        'Adversarial AI Systems',
        'AI systems designed to defend against or counteract adversarial attacks, such as adversarial examples in machine learning models.',
        10
    ),
    (
        'Blockchain-Based AI Systems',
        'Integration of blockchain technology with AI systems to enhance transparency, security, and decentralization in data sharing and decision-making.',
        10
    ),
    (
        'Edge AI Architectures',
        'AI architectures optimized for deployment on edge devices such as smartphones, IoT devices, and edge servers, enabling real-time inference and low-latency processing.',
        10
    ),
    (
        'Distributed AI Systems',
        'Decentralized AI architectures that distribute computation and data across multiple nodes or devices, enabling scalable and resilient AI applications.',
        10
    ),
    (
        'Responsible AI Frameworks',
        'Frameworks and methodologies for promoting fairness, accountability, transparency, and privacy in AI systems and applications.',
        10
    ),
    (
        'AI-Driven Recommender Systems',
        'AI architectures that analyze user preferences and behavior to provide personalized recommendations in domains such as e-commerce, media, and content streaming.',
        10
    ),
    (
        'AI-Powered Virtual Assistants',
        'AI architectures that interact with users through natural language interfaces to provide information, perform tasks, and assist with everyday activities.',
        10
    ),
    (
        'AI-Enabled Healthcare Systems',
        'AI architectures for medical diagnosis, treatment recommendation, patient monitoring, and healthcare management, aiming to improve healthcare outcomes and efficiency.',
        10
    ),
    (
        'AI-Driven Chatbots',
        'Architectures for conversational agents that use AI techniques such as natural language understanding and generation to interact with users in text-based or voice-based conversations.',
        10
    ),
    (
        'AI-Enabled Fraud Detection Systems',
        'Architectures that leverage AI algorithms to analyze patterns and anomalies in financial transactions, detecting fraudulent activities in real-time.',
        10
    ),
    (
        'AI-Enhanced Cybersecurity Systems',
        'Architectures that utilize AI techniques such as machine learning and anomaly detection to detect and mitigate cyber threats, intrusions, and attacks.',
        10
    ),
    (
        'AI-Powered Content Moderation Systems',
        'Architectures for automatically filtering, classifying, and moderating user-generated content on online platforms to enforce community guidelines and policies.',
        10
    ),
    (
        'AI-Driven Supply Chain Optimization Systems',
        'Architectures that use AI algorithms to optimize supply chain operations, including demand forecasting, inventory management, and logistics optimization.',
        10
    ),
    (
        'AI-Based Personalized Learning Systems',
        'Architectures for adaptive learning platforms that use AI to deliver personalized learning experiences tailored to the individual needs and preferences of learners.',
        10
    ),
    (
        'AI-Driven Energy Management Systems',
        'Architectures that apply AI techniques to optimize energy consumption, distribution, and production in smart grids, buildings, and industrial facilities.',
        10
    ),
    (
        'AI-Enhanced Autonomous Decision Support Systems',
        'Architectures that combine AI with decision support systems to provide real-time insights, recommendations, and decision-making support in complex domains such as finance, healthcare, and transportation.',
        10
    );

-- create table for tech design patterns\
CREATE TABLE software_tech_design_patterns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert statements for the following tech design patterns for the following
-- "Software Paradigms",
-- "Object Oriented",
-- "Functional",
-- "Imperative",
-- "Procedural",
-- "Declarative",
-- "-",
-- "Aspect Oriented",
-- "Async Programming",
-- "Parallel Programming",
-- "Concurrent Programming",
-- "Reactive Programming",
-- "Event Driven Programming",
-- "-",
-- "Component Based",
-- "Service Oriented",
-- "SOLID",
-- "GoF Design Patterns",
-- "Dependency Injection",
-- "Inversion of Control",
-- "CQRS"
INSERT INTO
    software_tech_design_patterns (name, description)
VALUES
    (
        'Software Paradigms',
        'A software paradigms design pattern is a software design pattern where the software is built using software paradigms.'
    ),
    (
        'Object Oriented',
        'An object oriented design pattern is a software design pattern where the software is built using object oriented programming.'
    ),
    (
        'Functional',
        'A functional design pattern is a software design pattern where the software is built using functional programming.'
    ),
    (
        'Imperative',
        'An imperative design pattern is a software design pattern where the software is built using imperative programming.'
    ),
    (
        'Procedural',
        'A procedural design pattern is a software design pattern where the software is built using procedural programming.'
    ),
    (
        'Declarative',
        'A declarative design pattern is a software design pattern where the software is built using declarative programming.'
    ),
    (
        'Aspect Oriented',
        'An aspect oriented design pattern is a software design pattern where the software is built using aspect oriented programming.'
    ),
    (
        'Async Programming',
        'An async programming design pattern is a software design pattern where the software is built using async programming.'
    ),
    (
        'Parallel Programming',
        'A parallel programming design pattern is a software design pattern where the software is built using parallel programming.'
    ),
    (
        'Concurrent Programming',
        'A concurrent programming design pattern is a software design pattern where the software is built using concurrent programming.'
    ),
    (
        'Reactive Programming',
        'A reactive programming design pattern is a software design pattern where the software is built using reactive programming.'
    ),
    (
        'Event Driven Programming',
        'An event driven programming design pattern is a software design pattern where the software is built using event driven programming.'
    ),
    (
        'Component Based',
        'A component based design pattern is a software design pattern where the software is built using component based programming.'
    ),
    (
        'Service Oriented',
        'A service oriented design pattern is a software design pattern where the software is built using service oriented programming.'
    ),
    (
        'SOLID',
        'A SOLID design pattern is a software design pattern where the software is built using SOLID principles.'
    ),
    (
        'GoF Design Patterns',
        'A GoF design patterns design pattern is a software design pattern where the software is built using GoF design patterns.'
    ),
    (
        'Dependency Injection',
        'A dependency injection design pattern is a software design pattern where the software is built using dependency injection.'
    ),
    (
        'Inversion of Control',
        'An inversion of control design pattern is a software design pattern where the software is built using inversion of control.'
    ),
    (
        'CQRS',
        'A CQRS design pattern is a software design pattern where the software is built using CQRS.'
    );

-- create table for operating systems
CREATE TABLE software_operating_systems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert statements for the following operating systems
-- Windows
-- MacOS
-- Linux
-- Unix
-- Android
-- iOS
-- Chrome OS
-- Ubuntu
-- Fedora
-- CentOS
-- Red Hat
-- Debian
-- Arch
-- Mint
-- OpenSUSE
-- SUSE
-- Kali
-- Raspbian
-- FreeBSD
-- Solaris
-- AIX
-- HP-UX
-- Tandem
-- VMS
-- z/OS
-- with proper description
INSERT INTO
    software_operating_systems (name, description)
VALUES
    (
        'DOS',
        'DOS is a disk operating system developed by Microsoft.'
    ),
    (
        'Windows',
        'Windows is a popular operating system developed by Microsoft.'
    ),
    (
        'MacOS',
        'MacOS is the operating system used by Apple computers.'
    ),
    (
        'Linux',
        'Linux is an open-source operating system that is widely used in servers and embedded systems.'
    ),
    (
        'Unix',
        'Unix is a family of operating systems that are widely used in enterprise environments.'
    ),
    (
        'Android',
        'Android is a mobile operating system developed by Google.'
    ),
    (
        'iOS',
        'iOS is the operating system used by Apple mobile devices.'
    ),
    (
        'Chrome OS',
        'Chrome OS is the operating system used by Chromebooks.'
    ),
    (
        'Ubuntu',
        'Ubuntu is a popular Linux distribution.'
    ),
    (
        'Fedora',
        'Fedora is a Linux distribution sponsored by Red Hat.'
    ),
    (
        'CentOS',
        'CentOS is a free and open-source Linux distribution.'
    ),
    (
        'Red Hat',
        'Red Hat is a popular Linux distribution used in enterprise environments.'
    ),
    (
        'Debian',
        'Debian is a stable and secure Linux distribution.'
    ),
    (
        'Arch',
        'Arch Linux is a lightweight and flexible Linux distribution.'
    ),
    (
        'Mint',
        'Linux Mint is a user-friendly Linux distribution.'
    ),
    (
        'OpenSUSE',
        'OpenSUSE is a Linux distribution sponsored by SUSE.'
    ),
    (
        'SUSE',
        'SUSE Linux Enterprise Server is a Linux distribution used in enterprise environments.'
    ),
    (
        'Kali',
        'Kali Linux is a Linux distribution used for penetration testing.'
    ),
    (
        'Raspbian',
        'Raspbian is the operating system used by Raspberry Pi.'
    ),
    (
        'FreeBSD',
        'FreeBSD is a free and open-source Unix-like operating system.'
    ),
    (
        'Solaris',
        'Solaris is a Unix operating system developed by Sun Microsystems.'
    ),
    (
        'AIX',
        'AIX is a Unix operating system developed by IBM.'
    ),
    (
        'HP-UX',
        'HP-UX is a Unix operating system developed by Hewlett Packard.'
    ),
    (
        'Tandem',
        'Tandem is a fault-tolerant operating system used in high-availability systems.'
    ),
    (
        'VMS',
        'VMS is a virtual memory operating system developed by Digital Equipment Corporation.'
    ),
    (
        'z/OS',
        'z/OS is an operating system developed by IBM for mainframe computers.'
    );

-- create table for software tech stacks
CREATE TABLE software_tech_stacks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- create insert statements for the following tech stacks
-- ".NET Framework 6.0",
-- ".NET Core 3.1",
-- "WebForms",
-- "WPF",
-- "ASP.NET Core",
-- "ASP.NET MVC",
-- "ASP.NET WebAPI",
-- "ASP.NET Razor Pages",
-- "ASP.NET Razor Views",
-- "-",
-- "J2EE",
-- "Spring Boot",
-- "Spring MVC",
-- "Spring Cloud",
-- "Hibernate",
-- "Struts",
-- "JSP",
-- "JMI",
-- "JMS",
-- "Servlets",
-- "ODBC/JDBC",
-- "Maven",
-- "Gradle",
-- "-",
-- "ADO.NET",
-- "Entity Framework",
-- "LINQ",
-- "-",
-- "NodeJS",
-- "Yarn",
-- "Express",
-- "Electron",
-- "React",
-- "Vue ",
-- "Angular",
-- "Nuxt",
-- "Next",
-- "Redux",
-- "Vuex",
-- "NgRx",
-- "RxJS",
-- "Bootstrap",
-- "Material",
-- "Tailwind",
-- "Vuetify",
-- "Quasar",
-- "Fluent",
-- "PrimeNG",
-- "Xamarin",
-- "Flutter ",
-- "PWA",
-- "Cordova"
-- "Capacitor",
-- "Blazor",
-- "React Native",
-- "Ionic",
-- "Google Firebase",
-- "-",
-- "Blazor",
-- "React Native",
-- "Ionic",
-- "Cordova",
-- "Google Firebase",
-- "-",
-- "Jupyter Notebook",
-- "Spyder",
-- "VS Code",
-- "Django",
-- "Flask",
-- "NumPy",
-- "Pandas",
-- "Matplotlib",
-- "TensorFlow",
-- "Git",
-- "-",
-- "Kafka",
-- "RabbitMQ",
-- "Azure Event Hub",
-- "Azure Service Bus",
-- "AWS SQS",
-- "Google Cloud Pub/Sub",
-- "IBM MQ Series",
-- "-",
-- "WCF",
-- "COM/COM+",
-- "MFC",
-- "ATL",
-- "Win32",
-- "CGI",
-- "HTTP",
-- "SSL",
-- "ASF",
-- "NetShow",
-- "-",
-- "ActiveX",
-- "Web Services",
-- "SOAP",
-- "Mozilla",
-- "VBA",
-- "Boost",
-- "ACE",
-- "Apache Tomcat",
-- "SOLR",
-- "-",
-- "Lucene",
-- "JBoss",
-- "WebLogic",
-- "WebSphere",
-- "-",
-- "Consul",
-- "Zookeeper",
-- "Eureka",
-- "Hystrix",
-- "-",
-- "Google Analytics",
-- "SEO"
-- insert into software_tech_stacks following tech stacks
-- provide proper description for each tech stack
INSERT INTO
    software_tech_stacks (name, description)
VALUES
    (
        '.NET Framework 6.0',
        '.NET Framework 6.0 is a software tech stack developed by Microsoft for building Windows applications.'
    ),
    (
        '.NET Core 3.1',
        '.NET Core 3.1 is a software tech stack developed by Microsoft for building cross-platform applications.'
    ),
    (
        'WebForms',
        'WebForms is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'WPF',
        'WPF is a software tech stack developed by Microsoft for building Windows applications.'
    ),
    (
        'ASP.NET Core',
        'ASP.NET Core is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'ASP.NET MVC',
        'ASP.NET MVC is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'ASP.NET WebAPI',
        'ASP.NET WebAPI is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'ASP.NET Razor Pages',
        'ASP.NET Razor Pages is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'ASP.NET Razor Views',
        'ASP.NET Razor Views is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'J2EE',
        'J2EE is a software tech stack developed by Sun Microsystems for building enterprise applications.'
    ),
    (
        'Spring Boot',
        'Spring Boot is a software tech stack developed by Pivotal for building web applications.'
    ),
    (
        'Spring MVC',
        'Spring MVC is a software tech stack developed by Pivotal for building web applications.'
    ),
    (
        'Spring Cloud',
        'Spring Cloud is a software tech stack developed by Pivotal for building cloud-native applications.'
    ),
    (
        'Hibernate',
        'Hibernate is a software tech stack developed by Red Hat for building data access layers.'
    ),
    (
        'Struts',
        'Struts is a software tech stack developed by Apache for building web applications.'
    ),
    (
        'JSP',
        'JSP is a software tech stack developed by Sun Microsystems for building web applications.'
    ),
    (
        'JMI',
        'JMI is a software tech stack developed by Sun Microsystems for building web applications.'
    ),
    (
        'JMS',
        'JMS is a software tech stack developed by Sun Microsystems for building messaging systems.'
    ),
    (
        'Servlets',
        'Servlets is a software tech stack developed by Sun Microsystems for building web applications.'
    ),
    (
        'ODBC/JDBC',
        'ODBC/JDBC is a software tech stack developed by Microsoft for building database applications.'
    ),
    (
        'Maven',
        'Maven is a software tech stack developed by Apache for building Java applications.'
    ),
    (
        'Gradle',
        'Gradle is a software tech stack developed by Gradle for building Java applications.'
    ),
    (
        'NodeJS',
        'NodeJS is a software tech stack developed by NodeJS for building web applications.'
    ),
    (
        'Yarn',
        'Yarn is a software tech stack developed by Facebook for building web applications.'
    ),
    (
        'Express',
        'Express is a software tech stack developed by Express for building web applications.'
    ),
    (
        'Electron',
        'Electron is a software tech stack developed by GitHub for building desktop applications.'
    ),
    (
        'React',
        'React is a software tech stack developed by Facebook for building web applications.'
    ),
    (
        'Vue',
        'Vue is a software tech stack developed by Vue for building web applications.'
    ),
    (
        'Angular',
        'Angular is a software tech stack developed by Google for building web applications.'
    ),
    (
        'Nuxt',
        'Nuxt is a software tech stack developed by Nuxt for building web applications.'
    ),
    (
        'Next',
        'Next is a software tech stack developed by Next for building web applications.'
    ),
    (
        'Redux',
        'Redux is a software tech stack developed by Redux for building web applications.'
    ),
    (
        'Vuex',
        'Vuex is a software tech stack developed by Vuex for building web applications.'
    ),
    (
        'NgRx',
        'NgRx is a software tech stack developed by NgRx for building web applications.'
    ),
    (
        'RxJS',
        'RxJS is a software tech stack developed by RxJS for building web applications.'
    ),
    (
        'Bootstrap',
        'Bootstrap is a software tech stack developed by Twitter for building web applications.'
    ),
    (
        'Material',
        'Material is a software tech stack developed by Google for building web applications.'
    ),
    (
        'Tailwind',
        'Tailwind is a software tech stack developed by Tailwind for building web applications.'
    ),
    (
        'Vuetify',
        'Vuetify is a software tech stack developed by Vuetify for building web applications.'
    ),
    (
        'Quasar',
        'Quasar is a software tech stack developed by Quasar for building web applications.'
    ),
    (
        'Fluent',
        'Fluent is a software tech stack developed by Fluent for building web applications.'
    ),
    (
        'PrimeNG',
        'PrimeNG is a software tech stack developed by PrimeNG for building web applications.'
    ),
    (
        'Xamarin',
        'Xamarin is a software tech stack developed by Microsoft for building cross-platform applications.'
    ),
    (
        'Flutter',
        'Flutter is a software tech stack developed by Google for building cross-platform applications.'
    ),
    (
        'PWA',
        'PWA is a software tech stack developed by Google for building progressive web applications.'
    ),
    (
        'Cordova',
        'Cordova is a software tech stack developed by Apache for building cross-platform applications.'
    ),
    (
        'Capacitor',
        'Capacitor is a software tech stack developed by Ionic for building cross-platform applications.'
    ),
    (
        'Blazor',
        'Blazor is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'React Native',
        'React Native is a software tech stack developed by Facebook for building cross-platform applications.'
    ),
    (
        'Ionic',
        'Ionic is a software tech stack developed by Ionic for building cross-platform applications.'
    ),
    (
        'Google Firebase',
        'Google Firebase is a software tech stack developed by Google for building web applications.'
    ),
    (
        'Jupyter Notebook',
        'Jupyter Notebook is a software tech stack developed by Jupyter for building data science applications.'
    ),
    (
        'Spyder',
        'Spyder is a software tech stack developed by Spyder for building data science applications.'
    ),
    (
        'VS Code',
        'VS Code is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'Django',
        'Django is a software tech stack developed by Django for building web applications.'
    ),
    (
        'Flask',
        'Flask is a software tech stack developed by Flask for building web applications.'
    ),
    (
        'NumPy',
        'NumPy is a software tech stack developed by NumPy for building data science applications.'
    ),
    (
        'Pandas',
        'Pandas is a software tech stack developed by Pandas for building data science applications.'
    ),
    (
        'Matplotlib',
        'Matplotlib is a software tech stack developed by Matplotlib for building data science applications.'
    ),
    (
        'TensorFlow',
        'TensorFlow is a software tech stack developed by TensorFlow for building machine learning applications.'
    ),
    (
        'Git',
        'Git is a software tech stack developed by Git for building version control systems.'
    ),
    (
        'Kafka',
        'Kafka is a software tech stack developed by Apache for building messaging systems.'
    ),
    (
        'RabbitMQ',
        'RabbitMQ is a software tech stack developed by RabbitMQ for building messaging systems.'
    ),
    (
        'Azure Event Hub',
        'Azure Event Hub is a software tech stack developed by Microsoft for building messaging systems.'
    ),
    (
        'Azure Service Bus',
        'Azure Service Bus is a software tech stack developed by Microsoft for building messaging systems.'
    ),
    (
        'AWS SQS',
        'AWS SQS is a software tech stack developed by Amazon for building messaging systems.'
    ),
    (
        'Google Cloud Pub/Sub',
        'Google Cloud Pub/Sub is a software tech stack developed by Google for building messaging systems.'
    ),
    (
        'IBM MQ Series',
        'IBM MQ Series is a software tech stack developed by IBM for building messaging systems.'
    ),
    (
        'WCF',
        'WCF is a software tech stack developed by Microsoft for building web services.'
    ),
    (
        'COM/COM+',
        'COM/COM+ is a software tech stack developed by Microsoft for building component-based applications.'
    ),
    (
        'MFC',
        'MFC is a software tech stack developed by Microsoft for building Windows applications.'
    ),
    (
        'ATL',
        'ATL is a software tech stack developed by Microsoft for building Windows applications.'
    ),
    (
        'Win32',
        'Win32 is a software tech stack developed by Microsoft for building Windows applications.'
    ),
    (
        'CGI',
        'CGI is a software tech stack developed by CGI for building web applications.'
    ),
    (
        'HTTP',
        'HTTP is a software tech stack developed by HTTP for building web applications.'
    ),
    (
        'SSL',
        'SSL is a software tech stack developed by SSL for building secure web applications.'
    ),
    (
        'ASF',
        'ASF is a software tech stack developed by ASF for building web applications.'
    ),
    (
        'NetShow',
        'NetShow is a software tech stack developed by NetShow for building web applications.'
    ),
    (
        'ActiveX',
        'ActiveX is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'Web Services',
        'Web Services is a software tech stack developed by Microsoft for building web applications.'
    ),
    (
        'SOAP',
        'SOAP is a software tech stack developed by SOAP for building web applications.'
    ),
    (
        'Mozilla',
        'Mozilla is a software tech stack developed by Mozilla for building web applications.'
    ),
    (
        'VBA',
        'VBA is a software tech stack developed by Microsoft for building Windows applications.'
    ),
    (
        'Boost',
        'Boost is a software tech stack developed by Boost for building C++ applications.'
    ),
    (
        'ACE',
        'ACE is a software tech stack developed by ACE for building C++ applications.'
    ),
    (
        'Apache Tomcat',
        'Apache Tomcat is a software tech stack developed by Apache for building web applications.'
    ),
    (
        'SOLR',
        'SOLR is a software tech stack developed by Apache for building search applications.'
    ),
    (
        'Lucene',
        'Lucene is a software tech stack developed by Apache for building search applications.'
    ),
    (
        'JBoss',
        'JBoss is a software tech stack developed by JBoss for building web applications.'
    ),
    (
        'WebLogic',
        'WebLogic is a software tech stack developed by Oracle for building web applications.'
    ),
    (
        'WebSphere',
        'WebSphere is a software tech stack developed by IBM for building web applications.'
    ),
    (
        'Consul',
        'Consul is a software tech stack developed by HashiCorp for building service discovery systems.'
    ),
    (
        'Zookeeper',
        'Zookeeper is a software tech stack developed by Apache for building distributed systems.'
    ),
    (
        'Eureka',
        'Eureka is a software tech stack developed by Netflix for building service discovery systems.'
    ),
    (
        'Hystrix',
        'Hystrix is a software tech stack developed by Netflix for building fault-tolerant systems.'
    ),
    (
        'Google Analytics',
        'Google Analytics is a software tech stack developed by Google for tracking website traffic.'
    ),
    (
        'SEO',
        'SEO is a software tech stack developed by SEO for optimizing websites for search engines.'
    );

-- create table for software programming languages
CREATE TABLE software_programming_languages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- create insert statements for the following programming languages
-- "C",
-- "C++/VC++",
-- "C#",
-- "VB.NET",
-- "Java",
-- "Javascript",
-- "Typescript",
-- "Python",
-- "Perl",
-- "PHP",
-- "Borland C++ Builder",
-- "Delphi",
-- "Pascal",
-- "COBOL",
-- "Fortran",
-- "Lisp",
-- "Scheme",
-- "Smalltalk",
-- "Ada",
-- "Eiffel",
-- "Objective-C",
-- "Swift",
-- "PowerBuilder",
-- "Visual Basic",
-- "ASP",
-- "CGI",
-- "XML/XSD/XSL/XSLT/XPath",
-- "SQL",
-- "PL/SQL",
-- "T-SQL",
-- "HTML",
-- "DHTML",
-- "CSS",
-- SASS
-- Stylus
-- SCSS
-- PostCSS
-- "Bash",
-- "Shell",
-- "PowerShell script"
-- R
-- Ruby
-- Scala
-- Groovy
-- Clojure
-- Haskell
-- Elixir
-- Erlang
-- F#
-- R
-- Julia
-- Dart
-- Lua
-- Perl
-- Shell
-- TypeScript
-- JavaScript
-- CoffeeScript
-- create insert statements for the above  programming languages
INSERT INTO
    software_programming_languages (name, description)
VALUES
    (
        'C',
        'C is a general-purpose programming language that is widely used for system programming.'
    ),
    (
        'C++/VC++',
        'C++ is a programming language that is widely used for system programming and game development.'
    ),
    (
        'C#',
        'C# is a programming language developed by Microsoft for building Windows applications.'
    ),
    (
        'VB.NET',
        'VB.NET is a programming language developed by Microsoft for building Windows applications.'
    ),
    (
        'Java',
        'Java is a programming language that is widely used for building enterprise applications.'
    ),
    (
        'Javascript',
        'Javascript is a programming language that is widely used for building web applications.'
    ),
    (
        'Typescript',
        'Typescript is a programming language that is widely used for building web applications.'
    ),
    (
        'Python',
        'Python is a programming language that is widely used for data analysis and machine learning.'
    ),
    (
        'Perl',
        'Perl is a programming language that is widely used for text processing and system administration.'
    ),
    (
        'PHP',
        'PHP is a programming language that is widely used for building web applications.'
    ),
    (
        'Borland C++ Builder',
        'Borland C++ Builder is a programming language that is widely used for building Windows applications.'
    ),
    (
        'Delphi',
        'Delphi is a programming language that is widely used for building Windows applications.'
    ),
    (
        'Pascal',
        'Pascal is a programming language that is widely used for teaching programming.'
    ),
    (
        'COBOL',
        'COBOL is a programming language that is widely used for business applications.'
    ),
    (
        'Fortran',
        'Fortran is a programming language that is widely used for scientific computing.'
    ),
    (
        'Lisp',
        'Lisp is a programming language that is widely used for artificial intelligence.'
    ),
    (
        'Scheme',
        'Scheme is a programming language that is widely used for teaching programming.'
    ),
    (
        'Smalltalk',
        'Smalltalk is a programming language that is widely used for object-oriented programming.'
    ),
    (
        'Ada',
        'Ada is a programming language that is widely used for safety-critical systems.'
    ),
    (
        'Eiffel',
        'Eiffel is a programming language that is widely used for software engineering.'
    ),
    (
        'Objective-C',
        'Objective-C is a programming language that is widely used for building iOS applications.'
    ),
    (
        'Swift',
        'Swift is a programming language that is widely used for building iOS applications.'
    ),
    (
        'PowerBuilder',
        'PowerBuilder is a programming language that is widely used for building Windows applications.'
    ),
    (
        'Visual Basic',
        'Visual Basic is a programming language that is widely used for building Windows applications.'
    ),
    (
        'ASP',
        'ASP is a programming language that is widely used for building web applications.'
    ),
    (
        'CGI',
        'CGI is a programming language that is widely used for building web applications.'
    ),
    (
        'XML/XSD/XSL/XSLT/XPath',
        'XML/XSD/XSL/XSLT/XPath is a programming language that is widely used for building web applications.'
    ),
    (
        'SQL',
        'SQL is a programming language that is widely used for database programming.'
    ),
    (
        'PL/SQL',
        'PL/SQL is a programming language that is widely used for Oracle database programming.'
    ),
    (
        'T-SQL',
        'T-SQL is a programming language that is widely used for Microsoft SQL Server database programming.'
    ),
    (
        'HTML',
        'HTML is a programming language that is widely used for building web applications.'
    ),
    (
        'DHTML',
        'DHTML is a programming language that is widely used for building web applications.'
    ),
    (
        'CSS',
        'CSS is a programming language that is widely used for building web applications.'
    ),
    (
        'SASS',
        'SASS is a programming language that is widely used for building web applications.'
    ),
    (
        'Stylus',
        'Stylus is a programming language that is widely used for building web applications.'
    ),
    (
        'SCSS',
        'SCSS is a programming language that is widely used for building web applications.'
    ),
    (
        'PostCSS',
        'PostCSS is a programming language that is widely used for building web applications.'
    ),
    (
        'Bash',
        'Bash is a programming language that is widely used for system administration.'
    ),
    (
        'Shell',
        'Shell is a programming language that is widely used for system administration.'
    ),
    (
        'PowerShell script',
        'PowerShell script is a programming language that is widely used for system administration.'
    ),
    (
        'R',
        'R is a programming language that is widely used for data analysis and machine learning.'
    ),
    (
        'Ruby',
        'Ruby is a programming language that is widely used for web development.'
    ),
    (
        'Scala',
        'Scala is a programming language that is widely used for building scalable applications.'
    ),
    (
        'Groovy',
        'Groovy is a programming language that is widely used for building web applications.'
    ),
    (
        'Clojure',
        'Clojure is a programming language that is widely used for building web applications.'
    ),
    (
        'Haskell',
        'Haskell is a programming language that is widely used for teaching programming.'
    ),
    (
        'Elixir',
        'Elixir is a programming language that is widely used for building web applications.'
    ),
    (
        'Erlang',
        'Erlang is a programming language that is widely used for building scalable applications.'
    ),
    (
        'F#',
        'F# is a programming language that is widely used for building web applications.'
    ),
    (
        'Julia',
        'Julia is a programming language that is widely used for scientific computing.'
    ),
    (
        'Dart',
        'Dart is a programming language that is widely used for building web applications.'
    ),
    (
        'Lua',
        'Lua is a programming language that is widely used for game development.'
    ),
    (
        'Go',
        'Go is a programming language that is widely used for building scalable applications.'
    ),
    (
        'CoffeeScript',
        'CoffeeScript is a programming language that is widely used for building web applications.'
    );

-- create table for databases\
CREATE TABLE software_databases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- alter table software_databases add column database type as ENUM
ALTER TABLE
    software_databases
ADD
    COLUMN database_type ENUM(
        'SQL',
        'NoSQL',
        'NewSQL',
        'Graph',
        'Time Series',
        'Document',
        'Key-Value',
        'Columnar',
        'Multimodel'
    );

-- create insert statements for the following databases
-- "SQL Server",
-- "MySQL",
-- "PostgreSQL",
-- "SQLite",
-- "Oracle",
-- "DB2",
-- "Sybase",
-- "Informix",
-- "Ingres",
-- "Teradata",
-- "Access",
-- "FoxPro",
-- "dBase",
-- "Paradox",
-- "Lotus Notes",
-- "MongoDB",
-- "CouchDB",
-- "Cassandra",
-- "HBase",
-- "Redis",
-- "Memcached",
-- "Riak",
-- "Neo4j",
-- "OrientDB",
-- "ArangoDB",
-- "Couchbase",
-- "RethinkDB",
-- "InfluxDB",
-- "Elasticsearch",
-- "RabbitMQ",
-- "Azure Event Hub",
-- "Azure Service Bus",
-- "AWS SQS",
-- "Google Cloud Pub/Sub",
-- "IBM MQ Series",
-- "Hadoop",
-- "Hive",
-- "Presto",
-- "Impala",
-- "Drill",
-- "Spark",
-- "Flink",
-- "Samza",
-- "Storm"
-- "Pincone"
-- provide proper description for each database
-- provide proper database type for each database
INSERT INTO
    software_databases (name, description, database_type)
VALUES
    (
        'SQL Server',
        'SQL Server is a relational database management system developed by Microsoft.',
        'SQL'
    ),
    (
        'MySQL',
        'MySQL is a relational database management system developed by Oracle.',
        'SQL'
    ),
    (
        'PostgreSQL',
        'PostgreSQL is a relational database management system developed by the PostgreSQL Global Development Group.',
        'SQL'
    ),
    (
        'SQLite',
        'SQLite is a relational database management system developed by the SQLite Consortium.',
        'SQL'
    ),
    (
        'Oracle',
        'Oracle is a relational database management system developed by Oracle.',
        'SQL'
    ),
    (
        'DB2',
        'DB2 is a relational database management system developed by IBM.',
        'SQL'
    ),
    (
        'Sybase',
        'Sybase is a relational database management system developed by Sybase.',
        'SQL'
    ),
    (
        'Informix',
        'Informix is a relational database management system developed by IBM.',
        'SQL'
    ),
    (
        'Ingres',
        'Ingres is a relational database management system developed by Ingres Corporation.',
        'SQL'
    ),
    (
        'Teradata',
        'Teradata is a relational database management system developed by Teradata Corporation.',
        'SQL'
    ),
    (
        'Access',
        'Access is a relational database management system developed by Microsoft.',
        'SQL'
    ),
    (
        'FoxPro',
        'FoxPro is a relational database management system developed by Microsoft.',
        'SQL'
    ),
    (
        'dBase',
        'dBase is a relational database management system developed by dBase LLC.',
        'SQL'
    ),
    (
        'Paradox',
        'Paradox is a relational database management system developed by Corel Corporation.',
        'SQL'
    ),
    (
        'Lotus Notes',
        'Lotus Notes is a document-oriented database management system developed by IBM.',
        'Document'
    ),
    (
        'MongoDB',
        'MongoDB is a document-oriented database management system developed by MongoDB Inc.',
        'Document'
    ),
    (
        'CouchDB',
        'CouchDB is a document-oriented database management system developed by Apache Software Foundation.',
        'Document'
    ),
    (
        'Cassandra',
        'Cassandra is a wide-column store database management system developed by Apache Software Foundation.',
        'Columnar'
    ),
    (
        'HBase',
        'HBase is a wide-column store database management system developed by Apache Software Foundation.',
        'Columnar'
    ),
    (
        'Redis',
        'Redis is a key-value store database management system developed by Redis Labs.',
        'Key-Value'
    ),
    (
        'Memcached',
        'Memcached is a key-value store database management system developed by Memcached Inc.',
        'Key-Value'
    ),
    (
        'Riak',
        'Riak is a key-value store database management system developed by Basho Technologies.',
        'Key-Value'
    ),
    (
        'Neo4j',
        'Neo4j is a graph database management system developed by Neo4j Inc.',
        'Graph'
    ),
    (
        'OrientDB',
        'OrientDB is a graph database management system developed by OrientDB Inc.',
        'Graph'
    ),
    (
        'ArangoDB',
        'ArangoDB is a multimodel database management system developed by ArangoDB Inc.',
        'Multimodel'
    ),
    (
        'Couchbase',
        'Couchbase is a multimodel database management system developed by Couchbase Inc.',
        'Multimodel'
    ),
    (
        'RethinkDB',
        'RethinkDB is a document-oriented database management system developed by RethinkDB Inc.',
        'Document'
    ),
    (
        'InfluxDB',
        'InfluxDB is a time series database management system developed by InfluxData Inc.',
        'Time Series'
    ),
    (
        'Elasticsearch',
        'Elasticsearch is a search engine database management system developed by Elastic Inc.',
        'Document'
    ),
    (
        'Hadoop',
        'Hadoop is a distributed file system database management system developed by Apache Software Foundation.',
        'NewSQL'
    ),
    (
        'Hive',
        'Hive is a distributed file system database management system developed by Apache Software Foundation.',
        'NewSQL'
    ),
    (
        'Presto',
        'Presto is a distributed file system database management system developed by Facebook.',
        'NewSQL'
    ),
    (
        'Impala',
        'Impala is a distributed file system database management system developed by Cloudera.',
        'NewSQL'
    ),
    (
        'Drill',
        'Drill is a distributed file system database management system developed by Apache Software Foundation.',
        'NewSQL'
    ),
    (
        'Spark',
        'Spark is a distributed file system database management system developed by Apache Software Foundation.',
        'NewSQL'
    ),
    (
        'Flink',
        'Flink is a distributed file system database management system developed by Apache Software Foundation.',
        'NewSQL'
    ),
    (
        'Samza',
        'Samza is a distributed file system database management system developed by Apache Software Foundation.',
        'NewSQL'
    ),
    (
        'Pincone',
        'Pincone is a distributed file system database management system developed by Pincone Inc.',
        'NewSQL'
    );

-- create a table for data management types
CREATE TABLE software_data_management_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- create insert statements for the following with proper description
-- "Database Design",
-- "Data Model",
-- "Data Flow",
-- "Data Integration",
-- "Data Transformation",
-- "Data Migration",
-- "Data Replication",
-- "-",
-- "Data Warehousing",
-- "Data Mining",
-- "Data Lake",
-- "Data Analytics",
-- "Data Visualization",
-- "Data Reporting",
-- "-",
-- "Data Governance",
-- "Data Security",
-- "Data Privacy",
-- "Data Quality",
-- "Data Catalog",
-- "Data Masking",
-- "-",
-- "Data Archiving",
-- "Data Backup",
-- "Data Recovery",
-- "Data Retention",
-- "Data Storage",
-- "Data Compression",
-- "-",
-- "Data Encryption",
-- "Data Decryption",
-- "-",
-- "Data Indexing",
-- "Data Partitioning",
-- "Data Sharding",
INSERT INTO
    software_data_management_types (name, description)
VALUES
    (
        'Database Design',
        'Database Design is the process of designing the structure of a database.'
    ),
    (
        'Data Model',
        'Data Model is a conceptual representation of data in a database.'
    ),
    (
        'Data Flow',
        'Data Flow is the movement of data between systems or components.'
    ),
    (
        'Data Integration',
        'Data Integration is the process of combining data from different sources.'
    ),
    (
        'Data Transformation',
        'Data Transformation is the process of converting data from one format to another.'
    ),
    (
        'Data Migration',
        'Data Migration is the process of moving data from one system to another.'
    ),
    (
        'Data Replication',
        'Data Replication is the process of copying data to multiple locations.'
    ),
    (
        'Data Warehousing',
        'Data Warehousing is the process of storing and managing data in a central repository.'
    ),
    (
        'Data Mining',
        'Data Mining is the process of analyzing data to discover patterns and trends.'
    ),
    (
        'Data Lake',
        'Data Lake is a large repository of raw data stored in its native format.'
    ),
    (
        'Data Analytics',
        'Data Analytics is the process of analyzing data to gain insights and make decisions.'
    ),
    (
        'Data Visualization',
        'Data Visualization is the process of presenting data in visual formats.'
    ),
    (
        'Data Reporting',
        'Data Reporting is the process of generating reports based on data analysis.'
    ),
    (
        'Data Governance',
        'Data Governance is the process of managing and protecting data assets.'
    ),
    (
        'Data Security',
        'Data Security is the process of protecting data from unauthorized access.'
    ),
    (
        'Data Privacy',
        'Data Privacy is the process of protecting personal data from misuse.'
    ),
    (
        'Data Quality',
        'Data Quality is the process of ensuring data accuracy and reliability.'
    ),
    (
        'Data Catalog',
        'Data Catalog is a centralized inventory of data assets.'
    ),
    (
        'Data Masking',
        'Data Masking is the process of obfuscating sensitive data.'
    ),
    (
        'Data Archiving',
        'Data Archiving is the process of storing historical data for long-term retention.'
    ),
    (
        'Data Backup',
        'Data Backup is the process of copying data to prevent data loss.'
    ),
    (
        'Data Recovery',
        'Data Recovery is the process of restoring data after a disaster or data loss.'
    ),
    (
        'Data Retention',
        'Data Retention is the process of retaining data for compliance or legal requirements.'
    ),
    (
        'Data Storage',
        'Data Storage is the process of storing data in a structured or unstructured format.'
    ),
    (
        'Data Compression',
        'Data Compression is the process of reducing the size of data for storage or transmission.'
    ),
    (
        'Data Encryption',
        'Data Encryption is the process of encoding data to protect it from unauthorized access.'
    ),
    (
        'Data Decryption',
        'Data Decryption is the process of decoding encrypted data to make it readable.'
    ),
    (
        'Data Indexing',
        'Data Indexing is the process of creating indexes to speed up data retrieval.'
    ),
    (
        'Data Partitioning',
        'Data Partitioning is the process of dividing data into smaller parts for storage or processing.'
    ),
    (
        'Data Sharding',
        'Data Sharding is the process of distributing data across multiple servers for scalability.'
    );

-- create table for API management types
CREATE TABLE software_api_management_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- create insert statements for the following API management types
-- "API Gateway",
-- "API Management",
-- "API Security",
-- "API Documentation",
-- "API Swagger",
-- "API Testing",
-- "API Monitoring",
-- "API Analytics",
-- "API Governance",
-- "-",
-- "API Lifecycle",
-- "API Design",
-- "API Development",
-- "API Deployment",
-- "API Consumption",
-- "API Integration",
-- "API Orchestration",
-- "API Transformation",
-- "API GraphQL",
-- "API REST",
-- "API SOAP",
-- "API gRPC",
-- "API Webhooks",
-- "API Microservices",
-- "API Serverless",
-- "API OAuth",
-- "API OpenID Connect",
-- "API JWT",
-- "API SAML",
-- "API CORS",
-- "API Rate Limiting",
-- "API Throttling",
-- "API Versioning",
-- "API Discovery",
INSERT INTO
    software_api_management_types (name, description)
VALUES
    (
        'API Gateway',
        'API Gateway is a software component that acts as an entry point for APIs.'
    ),
    (
        'API Management',
        'API Management is the process of designing, publishing, and monitoring APIs.'
    ),
    (
        'API Security',
        'API Security is the process of protecting APIs from unauthorized access.'
    ),
    (
        'API Documentation',
        'API Documentation is the process of creating documentation for APIs.'
    ),
    (
        'API Swagger',
        'API Swagger is a tool for designing, building, and documenting APIs.'
    ),
    (
        'API Testing',
        'API Testing is the process of testing APIs for functionality and performance.'
    ),
    (
        'API Monitoring',
        'API Monitoring is the process of tracking API performance and availability.'
    ),
    (
        'API Analytics',
        'API Analytics is the process of analyzing API usage and performance.'
    ),
    (
        'API Governance',
        'API Governance is the process of managing and controlling APIs.'
    ),
    (
        'API Lifecycle',
        'API Lifecycle is the process of managing APIs from design to retirement.'
    ),
    (
        'API Design',
        'API Design is the process of creating API specifications and interfaces.'
    ),
    (
        'API Development',
        'API Development is the process of building APIs based on design specifications.'
    ),
    (
        'API Deployment',
        'API Deployment is the process of making APIs available for use.'
    ),
    (
        'API Consumption',
        'API Consumption is the process of using APIs to access data and services.'
    ),
    (
        'API Integration',
        'API Integration is the process of connecting APIs with other systems and services.'
    ),
    (
        'API Orchestration',
        'API Orchestration is the process of coordinating multiple APIs to achieve a specific goal.'
    ),
    (
        'API Transformation',
        'API Transformation is the process of converting data formats and protocols between APIs.'
    ),
    (
        'API GraphQL',
        'API GraphQL is a query language for APIs that allows clients to request only the data they need.'
    ),
    (
        'API REST',
        'API REST is an architectural style for building APIs that use HTTP methods and URLs.'
    ),
    (
        'API SOAP',
        'API SOAP is a protocol for building APIs that use XML messages over HTTP.'
    ),
    (
        'API gRPC',
        'API gRPC is a high-performance, open-source RPC framework for building APIs.'
    ),
    (
        'API Webhooks',
        'API Webhooks is a way for APIs to send real-time notifications to other systems.'
    ),
    (
        'API Microservices',
        'API Microservices is an architectural style for building APIs as small, independent services.'
    ),
    (
        'API Serverless',
        'API Serverless is a cloud computing model where APIs are deployed as functions.'
    ),
    (
        'API OAuth',
        'API OAuth is an authorization framework for building secure APIs.'
    ),
    (
        'API OpenID Connect',
        'API OpenID Connect is an identity layer for building secure APIs.'
    ),
    (
        'API JWT',
        'API JWT is a JSON Web Token for building secure APIs.'
    ),
    (
        'API SAML',
        'API SAML is a security assertion markup language for building secure APIs.'
    ),
    (
        'API CORS',
        'API CORS is a cross-origin resource sharing for building secure APIs.'
    ),
    (
        'API Rate Limiting',
        'API Rate Limiting is the process of restricting the number of API requests per user.'
    ),
    (
        'API Throttling',
        'API Throttling is the process of limiting the rate of API requests per user.'
    ),
    (
        'API Versioning',
        'API Versioning is the process of managing different versions of APIs.'
    ),
    (
        'API Discovery',
        'API Discovery is the process of finding and using APIs in a network.'
    );

-- create table for cloud servic providers
CREATE TABLE software_cloud_service_providers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- create insert statements for the following cloud service providers
-- "AWS",
-- "Azure",
-- "Google Cloud",
-- "IBM Cloud",
-- "Oracle Cloud",
-- "Alibaba Cloud",
-- "Hetzer Cloud",
-- "Digital Ocean"
INSERT INTO
    software_cloud_service_providers (name, description)
VALUES
    (
        'AWS',
        'AWS is a cloud service provider that offers a wide range of cloud computing services.'
    ),
    (
        'Azure',
        'Azure is a cloud service provider that offers cloud computing services from Microsoft.'
    ),
    (
        'Google Cloud',
        'Google Cloud is a cloud service provider that offers cloud computing services from Google.'
    ),
    (
        'IBM Cloud',
        'IBM Cloud is a cloud service provider that offers cloud computing services from IBM.'
    ),
    (
        'Oracle Cloud',
        'Oracle Cloud is a cloud service provider that offers cloud computing services from Oracle.'
    ),
    (
        'Alibaba Cloud',
        'Alibaba Cloud is a cloud service provider that offers cloud computing services from Alibaba.'
    ),
    (
        'Hetzer Cloud',
        'Hetzer Cloud is a cloud service provider that offers cloud computing services from Hetzer.'
    ),
    (
        'Digital Ocean',
        'Digital Ocean is a cloud service provider that offers cloud computing services from Digital Ocean.'
    );

-- create table for software tools
CREATE TABLE software_tools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- alter table to have tool type ENUM
ALTER TABLE
    software_tools
ADD
    COLUMN tool_type ENUM(
        'IDE',
        'Version Control',
        'Build Automation',
        'Code Quality',
        'Testing',
        'API Testing',
        'API Development',
        'API Management',
        'API Security',
        'API Monitoring',
        'API Analytics',
        'API Governance',
        'API Lifecycle',
        'API Design',
        'API Deployment',
        'API Consumption',
        'API Integration',
        'API Orchestration',
        'API Transformation',
        'API GraphQL',
        'API REST',
        'API SOAP',
        'API gRPC',
        'API Webhooks',
        'API Microservices',
        'API Serverless',
        'API OAuth',
        'API OpenID Connect',
        'API JWT',
        'API SAML',
        'API CORS',
        'API Rate Limiting',
        'API Throttling',
        'API Versioning',
        'API Discovery',
        'Database Design',
        'Data Model',
        'Data Flow',
        'Data Integration',
        'Data Transformation',
        'Data Migration',
        'Data Replication',
        'Data Warehousing',
        'Data Mining',
        'Data Lake',
        'Data Analytics',
        'Data Visualization',
        'Data Reporting',
        'Data Governance',
        'Data Security',
        'Data Privacy',
        'Data Quality',
        'Data Catalog',
        'Data Masking',
        'Data Archiving',
        'Data Backup',
        'Data Recovery',
        'Data Retention',
        'Data Storage',
        'Data Compression',
        'Data Encryption',
        'Data Decryption',
        'Data Indexing',
        'Data Partitioning',
        'Data Sharding'
    );

ALTER TABLE
    software_tools
ADD
    COLUMN organization_id INT DEFAULT 0;

-- "SonarQube",
-- "NUnit",
-- "MSTest",
-- "Junit",
-- "JMeter",
-- "LoadRunner",
-- "Selenium",
-- "Cucumber",
-- "-",
-- "Postman",
-- "Fiddler",
-- "Visual Studio",
-- "Eclipse",
-- "IntelliJ",
-- "XCode",
-- "Android Studio",
-- "Visual Studio Code",
-- "Sublime",
-- "Notepad++",
-- "Vim",
-- "Emacs",
-- "MS Office Suite",
-- "Office 365",
-- "Google Suite",
-- "Nano",
-- "Pico",
-- "Atom",
-- "Confluence",
-- "Wiki",
-- "SharePoint",
-- "Jira",
-- "Azure Devops",
-- "Visual Paradigm",
-- "Rational Rose",
-- "Visio",
-- "SmartDraw",
-- "LucidChart",
-- "Draw.io",
-- "-",
-- ".NET SDK",
-- "NuGet Package Manager",
-- "MSBuild",
-- "Entity Framework Core",
-- "LINQPad",
-- "Resharper",
-- "Postman",
-- "Fiddler",
-- "Tomcat",
-- "JBoss",
-- "WebLogic",
-- "WebSphere",
-- "Consul",
-- "Zookeeper",
-- "Eureka",
-- "Hystrix",
-- "IIS Server",
-- "Apache Server",
-- "Nginx",
-- "HAProxy",
-- "Google Analytics",
-- "SEO",
-- "Google Tag Manager",
-- "Google Optimize",
-- "Google Search Console",
-- "Google AdWords",
-- "Google AdSense",
-- "Google Firebase",
-- "Google Maps",
-- "Nexus Repository",
-- "Maven",
-- "Gradle",
-- "Ant",
-- "Jenkins",
-- "Docker",
-- "Kubernetes",
-- "Ansible",
-- "Terraform",
-- "Vagrant",
-- "Packer",
-- "Chef",
-- "Puppet",
-- "NPM",
-- "NVM",
-- "Yarn",
-- "Webpack",
-- "Grunt",
-- "Gulp",
-- "Babel",
-- "ESLint",
-- "Jest",
-- "Mocha",
-- "Chai",
-- "Karma",
-- "meteor",
-- "turbo",
-- "-",
-- "PyCharm",
-- "Jupyter Notebook",
-- "Spyder",
-- "Django",
-- "Flask",
-- "NumPy",
-- "Pandas",
-- "Matplotlib",
-- "TensorFlow",
-- "Jupyter Notebook",
-- "Anaconda",
-- "-",
-- "Git",
-- "GitHub",
-- "GitLab",
-- "BitBucket",
-- "TFS",
-- "SVN",
-- "CVS",
-- "Perforce",
-- "VSS",
-- "-",
-- "-",
-- "ServiceNow",
-- "PagerDuty",
-- "OpsGenie",
-- "Microsoft Teams",
-- "Zoom",
-- "Google Meet",
-- "Google Workspace",
-- "-",
-- "Prometheus",
-- "Grafana",
-- "ElasitcSearch",
-- "Kibana",
-- "Logstash",
-- "Splunk",
-- "New Relic",
-- "Azure Monitor",
-- "Azure Application Insights",
-- "Azure Log Analytics",
-- "AWS CloudWatch",
-- "Google Cloud Monitoring",
-- "Datadog",
-- "AppDynamics",
-- "Dynatrace",
-- "SolarWinds",
-- "-",
-- "JMeter",
-- "LoadRunner",
-- "Gatling",
-- "Apache Benchmark",
-- "Locust",
-- "-",
-- "Trello",
-- "MS Project"
--   "UML",
-- "MS Visio",
-- "Visual Paradigm",
-- "Rational Rose",
-- "RUP",
-- "Office 365",
-- "Google Suite",
-- "Confluence",
-- "Wiki",
-- "SharePoint",
-- "Slack",
-- "Microsoft Teams",
-- "Zoom",
-- "Google Meet",
-- "WebEx",
-- "Skype",
-- insert statements with appropritate description
INSERT INTO
    software_tools (name, description, tool_type)
VALUES
    (
        'SonarQube',
        'SonarQube is a code quality tool that analyzes code for bugs, vulnerabilities, and code smells.',
        'Code Quality'
    ),
    (
        'NUnit',
        'NUnit is a unit testing framework for .NET applications.',
        'Testing'
    ),
    (
        'MSTest',
        'MSTest is a unit testing framework for .NET applications.',
        'Testing'
    ),
    (
        'Junit',
        'Junit is a unit testing framework for Java applications.',
        'Testing'
    ),
    (
        'JMeter',
        'JMeter is a performance testing tool for web applications.',
        'Testing'
    ),
    (
        'LoadRunner',
        'LoadRunner is a performance testing tool for web applications.',
        'Testing'
    ),
    (
        'Selenium',
        'Selenium is a web testing tool for automating browser interactions.',
        'Testing'
    ),
    (
        'Cucumber',
        'Cucumber is a behavior-driven development tool for writing acceptance tests.',
        'Testing'
    ),
    (
        'Postman',
        'Postman is an API testing tool for testing and debugging APIs.',
        'API Testing'
    ),
    (
        'Fiddler',
        'Fiddler is a web debugging tool for monitoring HTTP traffic.',
        'API Testing'
    ),
    (
        'Visual Studio',
        'Visual Studio is an integrated development environment for building .NET applications.',
        'IDE'
    ),
    (
        'Eclipse',
        'Eclipse is an integrated development environment for building Java applications.',
        'IDE'
    ),
    (
        'IntelliJ',
        'IntelliJ is an integrated development environment for building Java applications.',
        'IDE'
    ),
    (
        'XCode',
        'XCode is an integrated development environment for building iOS applications.',
        'IDE'
    ),
    (
        'Android Studio',
        'Android Studio is an integrated development environment for building Android applications.',
        'IDE'
    ),
    (
        'Visual Studio Code',
        'Visual Studio Code is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Sublime',
        'Sublime is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Notepad++',
        'Notepad++ is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Vim',
        'Vim is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Emacs',
        'Emacs is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'MS Office Suite',
        'MS Office Suite is a collection of office productivity tools from Microsoft.',
        'IDE'
    ),
    (
        'Office 365',
        'Office 365 is a cloud-based office productivity suite from Microsoft.',
        'IDE'
    ),
    (
        'Google Suite',
        'Google Suite is a collection of office productivity tools from Google.',
        'IDE'
    ),
    (
        'Nano',
        'Nano is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Pico',
        'Pico is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Atom',
        'Atom is a lightweight code editor for building web applications.',
        'IDE'
    ),
    (
        'Confluence',
        'Confluence is a collaboration tool for building web applications.',
        'IDE'
    ),
    (
        'Wiki',
        'Wiki is a collaboration tool for building web applications.',
        'IDE'
    ),
    (
        'SharePoint',
        'SharePoint is a collaboration tool for building web applications.',
        'IDE'
    ),
    (
        'Jira',
        'Jira is a project management tool for building web applications.',
        'IDE'
    ),
    (
        'Azure Devops',
        'Azure Devops is a project management tool for building web applications.',
        'IDE'
    ),
    (
        'Visio',
        'Visio is a diagramming tool for building web applications.',
        'IDE'
    ),
    (
        'SmartDraw',
        'SmartDraw is a diagramming tool for building web applications.',
        'IDE'
    ),
    (
        'LucidChart',
        'LucidChart is a diagramming tool for building web applications.',
        'IDE'
    ),
    (
        'Draw.io',
        'Draw.io is a diagramming tool for building web applications.',
        'IDE'
    ),
    (
        '.NET SDK',
        '.NET SDK is a software development kit for building .NET applications.',
        'IDE'
    ),
    (
        'NuGet Package Manager',
        'NuGet Package Manager is a package manager for .NET applications.',
        'IDE'
    ),
    (
        'MSBuild',
        'MSBuild is a build automation tool for building .NET applications.',
        'IDE'
    ),
    (
        'Entity Framework Core',
        'Entity Framework Core is an object-relational mapping framework for .NET applications.',
        'IDE'
    ),
    (
        'LINQPad',
        'LINQPad is a query tool for building .NET applications.',
        'IDE'
    ),
    (
        'Resharper',
        'Resharper is a code analysis tool for building .NET applications.',
        'IDE'
    ),
    (
        'Tomcat',
        'Tomcat is a web server for building Java applications.',
        'IDE'
    ),
    (
        'JBoss',
        'JBoss is a web server for building Java applications.',
        'IDE'
    ),
    (
        'WebLogic',
        'WebLogic is a web server for building Java applications.',
        'IDE'
    ),
    (
        'WebSphere',
        'WebSphere is a web server for building Java applications.',
        'IDE'
    ),
    (
        'Consul',
        'Consul is a service discovery tool for building web applications.',
        'IDE'
    ),
    (
        'Zookeeper',
        'Zookeeper is a service discovery tool for building web applications.',
        'IDE'
    ),
    (
        'Eureka',
        'Eureka is a service discovery tool for building web applications.',
        'IDE'
    ),
    (
        'Hystrix',
        'Hystrix is a circuit breaker tool for building web applications.',
        'IDE'
    ),
    (
        'IIS Server',
        'IIS Server is a web server for building .NET applications.',
        'IDE'
    ),
    (
        'Apache Server',
        'Apache Server is a web server for building web applications.',
        'IDE'
    ),
    (
        'Nginx',
        'Nginx is a web server for building web applications.',
        'IDE'
    ),
    (
        'HAProxy',
        'HAProxy is a load balancer for building web applications.',
        'IDE'
    ),
    (
        'Google Analytics',
        'Google Analytics is a web analytics tool for building web applications.',
        'IDE'
    ),
    (
        'SEO',
        'SEO is a search engine optimization tool for building web applications.',
        'IDE'
    ),
    (
        'Google Tag Manager',
        'Google Tag Manager is a tag management tool for building web applications.',
        'IDE'
    ),
    (
        'Google Optimize',
        'Google Optimize is an A/B testing tool for building web applications.',
        'IDE'
    ),
    (
        'Google Search Console',
        'Google Search Console is a search engine optimization tool for building web applications.',
        'IDE'
    ),
    (
        'Google AdWords',
        'Google AdWords is an advertising tool for building web applications.',
        'IDE'
    ),
    (
        'Google AdSense',
        'Google AdSense is an advertising tool for building web applications.',
        'IDE'
    ),
    (
        'Google Firebase',
        'Google Firebase is a mobile and web application development platform.',
        'IDE'
    ),
    (
        'Google Maps',
        'Google Maps is a mapping tool for building web applications.',
        'IDE'
    ),
    (
        'Nexus Repository',
        'Nexus Repository is a repository manager for building web applications.',
        'IDE'
    ),
    (
        'Maven',
        'Maven is a build automation tool for building Java applications.',
        'IDE'
    ),
    (
        'Gradle',
        'Gradle is a build automation tool for building Java applications.',
        'IDE'
    ),
    (
        'Ant',
        'Ant is a build automation tool for building Java applications.',
        'IDE'
    ),
    (
        'Jenkins',
        'Jenkins is a continuous integration tool for building web applications.',
        'IDE'
    ),
    (
        'Docker',
        'Docker is a containerization tool for building web applications.',
        'IDE'
    ),
    (
        'Kubernetes',
        'Kubernetes is a container orchestration tool for building web applications.',
        'IDE'
    ),
    (
        'Ansible',
        'Ansible is a configuration management tool for building web applications.',
        'IDE'
    ),
    (
        'Terraform',
        'Terraform is an infrastructure as code tool for building web applications.',
        'IDE'
    ),
    (
        'Vagrant',
        'Vagrant is a virtualization tool for building web applications.',
        'IDE'
    ),
    (
        'Packer',
        'Packer is a virtualization tool for building web applications.',
        'IDE'
    ),
    (
        'Chef',
        'Chef is a configuration management tool for building web applications.',
        'IDE'
    ),
    (
        'Puppet',
        'Puppet is a configuration management tool for building web applications.',
        'IDE'
    ),
    (
        'NPM',
        'NPM is a package manager for building web applications.',
        'IDE'
    ),
    (
        'NVM',
        'NVM is a version manager for building web applications.',
        'IDE'
    ),
    (
        'Yarn',
        'Yarn is a package manager for building web applications.',
        'IDE'
    ),
    (
        'Webpack',
        'Webpack is a module bundler for building web applications.',
        'IDE'
    ),
    (
        'Grunt',
        'Grunt is a task runner for building web applications.',
        'IDE'
    ),
    (
        'Gulp',
        'Gulp is a task runner for building web applications.',
        'IDE'
    ),
    (
        'Babel',
        'Babel is a JavaScript compiler for building web applications.',
        'IDE'
    ),
    (
        'ESLint',
        'ESLint is a code quality tool for building web applications.',
        'IDE'
    ),
    (
        'Jest',
        'Jest is a testing framework for building web applications.',
        'IDE'
    ),
    (
        'Mocha',
        'Mocha is a testing framework for building web applications.',
        'IDE'
    ),
    (
        'Chai',
        'Chai is an assertion library for building web applications.',
        'IDE'
    ),
    (
        'Karma',
        'Karma is a test runner for building web applications.',
        'IDE'
    ),
    (
        'meteor',
        'meteor is a full-stack JavaScript platform for building web applications.',
        'IDE'
    ),
    (
        'turbo',
        'turbo is a full-stack JavaScript platform for building web applications.',
        'IDE'
    ),
    (
        'PyCharm',
        'PyCharm is an integrated development environment for building Python applications.',
        'IDE'
    ),
    (
        'Jupyter Notebook',
        'Jupyter Notebook is an interactive notebook for building Python applications.',
        'IDE'
    ),
    (
        'Spyder',
        'Spyder is an integrated development environment for building Python applications.',
        'IDE'
    ),
    (
        'Django',
        'Django is a web framework for building Python applications.',
        'IDE'
    ),
    (
        'Flask',
        'Flask is a micro web framework for building Python applications.',
        'IDE'
    ),
    (
        'NumPy',
        'NumPy is a numerical computing library for building Python applications.',
        'IDE'
    ),
    (
        'Pandas',
        'Pandas is a data analysis library for building Python applications.',
        'IDE'
    ),
    (
        'Matplotlib',
        'Matplotlib is a plotting library for building Python applications.',
        'IDE'
    ),
    (
        'TensorFlow',
        'TensorFlow is a machine learning library for building Python applications.',
        'IDE'
    ),
    (
        'Anaconda',
        'Anaconda is a data science platform for building Python applications.',
        'IDE'
    ),
    (
        'Git',
        'Git is a version control system for building web applications.',
        'Version Control'
    ),
    (
        'GitHub',
        'GitHub is a code hosting platform for building web applications.',
        'Version Control'
    ),
    (
        'GitLab',
        'GitLab is a code hosting platform for building web applications.',
        'Version Control'
    ),
    (
        'BitBucket',
        'BitBucket is a code hosting platform for building web applications.',
        'Version Control'
    ),
    (
        'TFS',
        'TFS is a version control system for building web applications.',
        'Version Control'
    ),
    (
        'SVN',
        'SVN is a version control system for building web applications.',
        'Version Control'
    ),
    (
        'CVS',
        'CVS is a version control system for building web applications.',
        'Version Control'
    ),
    (
        'Perforce',
        'Perforce is a version control system for building web applications.',
        'Version Control'
    ),
    (
        'VSS',
        'VSS is a version control system for building web applications.',
        'Version Control'
    ),
    (
        'ServiceNow',
        'ServiceNow is a service management tool for building web applications.',
        'Version Control'
    ),
    (
        'PagerDuty',
        'PagerDuty is an incident management tool for building web applications.',
        'Version Control'
    ),
    (
        'OpsGenie',
        'OpsGenie is an incident management tool for building web applications.',
        'Version Control'
    ),
    (
        'Microsoft Teams',
        'Microsoft Teams is a collaboration tool for building web applications.',
        'Version Control'
    ),
    (
        'Zoom',
        'Zoom is a video conferencing tool for building web applications.',
        'Version Control'
    ),
    (
        'Google Meet',
        'Google Meet is a video conferencing tool for building web applications.',
        'Version Control'
    ),
    (
        'Google Workspace',
        'Google Workspace is a collection of office productivity tools from Google.',
        'Version Control'
    ),
    (
        'Prometheus',
        'Prometheus is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Grafana',
        'Grafana is a visualization tool for building web applications.',
        'Version Control'
    ),
    (
        'ElasitcSearch',
        'ElasitcSearch is a search engine for building web applications.',
        'Version Control'
    ),
    (
        'Kibana',
        'Kibana is a visualization tool for building web applications.',
        'Version Control'
    ),
    (
        'Logstash',
        'Logstash is a log management tool for building web applications.',
        'Version Control'
    ),
    (
        'Splunk',
        'Splunk is a log management tool for building web applications.',
        'Version Control'
    ),
    (
        'New Relic',
        'New Relic is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Azure Monitor',
        'Azure Monitor is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Azure Application Insights',
        'Azure Application Insights is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Azure Log Analytics',
        'Azure Log Analytics is a log management tool for building web applications.',
        'Version Control'
    ),
    (
        'AWS CloudWatch',
        'AWS CloudWatch is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Google Cloud Monitoring',
        'Google Cloud Monitoring is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Datadog',
        'Datadog is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'AppDynamics',
        'AppDynamics is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Dynatrace',
        'Dynatrace is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'SolarWinds',
        'SolarWinds is a monitoring tool for building web applications.',
        'Version Control'
    ),
    (
        'Gatling',
        'Gatling is a performance testing tool for building web applications.',
        'Version Control'
    ),
    (
        'Apache Benchmark',
        'Apache Benchmark is a performance testing tool for building web applications.',
        'Version Control'
    ),
    (
        'Locust',
        'Locust is a performance testing tool for building web applications.',
        'Version Control'
    ),
    (
        'Trello',
        'Trello is a project management tool for building web applications.',
        'Version Control'
    ),
    (
        'MS Project',
        'MS Project is a project management tool for building web applications.',
        'Version Control'
    ),
    (
        'UML',
        'UML is a modeling language for building web applications.',
        'Version Control'
    ),
    (
        'MS Visio',
        'MS Visio is a diagramming tool for building web applications.',
        'Version Control'
    ),
    (
        'Visual Paradigm',
        'Visual Paradigm is a UML modeling tool for building web applications.',
        'Version Control'
    ),
    (
        'Rational Rose',
        'Rational Rose is a UML modeling tool for building web applications.',
        'Version Control'
    ),
    (
        'RUP',
        'RUP is a software development process for building web applications.',
        'Version Control'
    ),
    (
        'Slack',
        'Slack is a collaboration tool for building web applications.',
        'Version Control'
    ),
    (
        'WebEx',
        'WebEx is a video conferencing tool for building web applications.',
        'Version Control'
    ),
    (
        'Skype',
        'Skype is a video conferencing tool for building web applications.',
        'Version Control'
    );

    -- create table for 3rd party software mapped to organization_id
CREATE TABLE software_3rd_party (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,

    software_operating_system_id INT DEFAULT 0,
    programming_language_id INT DEFAULT 0,
    software_tech_stack_id INT DEFAULT 0,
    software_architecture_id INT DEFAULT 0,
    software_cloud_service_provider_id INT DEFAULT 0,
    software_artefact_type_id INT DEFAULT 0,

    organization_id INT DEFAULT 0,
    author_name VARCHAR(255),
    reference_url TEXT,
    download_url TEXT,
    user_id VARCHAR(255),
    password TEXT,

    subscription_type ENUM('Free', 'Paid Once', 'Subscription', 'Freemium', 'Open Source', 'Other'),
    subscription_key TEXT,

    notes TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (programming_language_id) REFERENCES software_programming_languages(id),
    FOREIGN KEY (software_artefact_type_id) REFERENCES software_artefact_types(id),
    FOREIGN KEY (software_architecture_id) REFERENCES software_architectures(id),
    FOREIGN KEY (software_cloud_service_provider_id) REFERENCES software_cloud_service_providers(id),
    FOREIGN KEY (software_operating_system_id) REFERENCES software_operating_systems(id),
    FOREIGN KEY (software_tech_stack_id) REFERENCES software_tech_stacks(id),
    FOREIGN KEY (organization_id) REFERENCES organizations(id),
    INDEX (id),
    UNIQUE (name)
);