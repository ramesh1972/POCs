CREATE DATABASE  IF NOT EXISTS `chordify-lms-pedagogy-db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chordify-lms-pedagogy-db`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: chordify-lms-pedagogy-db
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `content_id` int NOT NULL AUTO_INCREMENT,
  `content_type_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `is_public` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` bit(1) DEFAULT b'1',
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`content_id`),
  KEY `ctype_fk_idx` (`content_type_id`),
  CONSTRAINT `ctype_fk` FOREIGN KEY (`content_type_id`) REFERENCES `content_type` (`content_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,2,'Teacher Registration and Enrollment','• Teachers sign up, verify credentials and enroll in the LMS.\n• User-friendly interface streamlines onboarding.\n• Access is granted upon successful approval.',1,'2025-04-07 03:11:45','2025-04-07 03:13:05',_binary '',_binary '\0'),(2,2,'Orientation and System Introduction','• Teachers receive an interactive orientation.\n• Modules explain LMS features and navigation.\n• Essential resources and support are highlighted.',1,'2025-04-07 03:11:45','2025-04-07 03:13:05',_binary '',_binary '\0'),(3,2,'Core Training Modules Delivery','• Engage with tailored training modules.\n• Content spans videos, texts, and interactive lessons.\n• Modules are aligned with curriculum standards.',1,'2025-04-07 03:11:45','2025-04-07 03:13:05',_binary '',_binary '\0'),(4,2,'Assessment and Feedback','• Teachers complete quizzes and practical tasks.\n• Immediate feedback and performance reports are provided.\n• Progress is tracked and improvement areas are identified.',1,'2025-04-07 03:11:45','2025-04-07 03:13:05',_binary '',_binary '\0'),(6,1,'Course Management Service','• Provides tools for course creation and curriculum design.\n• Helps teachers organize and update educational content.\n• Streamlines course scheduling and resource allocation.',1,'2025-04-07 03:18:38','2025-04-07 03:18:38',_binary '',_binary '\0'),(7,1,'Assessment and Testing Service','• Enables creation and management of quizzes, exams, and assignments.\n• Automates grading and feedback for student assessments.\n• Supports diverse question formats for comprehensive evaluation.',1,'2025-04-07 03:18:38','2025-04-07 03:18:38',_binary '',_binary '\0'),(8,1,'Communication and Collaboration Service','• Facilitates discussion forums and messaging among teachers.\n• Supports real-time collaboration and resource sharing.\n• Enhances professional networking and support.',1,'2025-04-07 03:18:38','2025-04-07 03:18:38',_binary '',_binary '\0'),(9,1,'Resource Library Service','• Curates a digital library of teaching materials including files, videos, and texts.\n• Provides searchable, categorized access to lesson plans and references.\n• Supports continuous professional development through diverse resources.',1,'2025-04-07 03:18:38','2025-04-07 03:18:38',_binary '',_binary '\0'),(10,1,'Certification Service','• Provides certified programs to validate teacher training.\n• Awards digital certificates upon successful course completion.\n• Enhances professional credentials and career advancement.',1,'2025-04-07 03:21:11','2025-04-07 03:21:55',_binary '',_binary '\0'),(11,1,'Reporting and Analytics Service','• Generates insights through performance metrics and progress tracking.\n• Helps teachers and administrators monitor and improve teaching effectiveness.\n• Offers customizable reports for data-driven decisions.',1,'2025-04-07 03:18:38','2025-04-07 03:21:55',_binary '',_binary '\0'),(12,4,'How do I access the course materials?','Course materials are available through the LMS dashboard after login. Navigate to the courses section and click on the relevant course to view all available resources.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(13,4,'What is the procedure for certification?','The certification process requires completion of designated courses and passing final assessments. Detailed instructions and requirements are provided in the certification section of the LMS.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(14,4,'How can I reset my password?','If you forget your password, use the reset feature available on the login page. A reset link will be sent to your registered email with further instructions.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(15,4,'Who should I contact for technical support?','Technical support is available through the LMS help center. Users can submit a support ticket or contact the team directly for prompt assistance.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(16,4,'How is my progress tracked?','Progress is tracked automatically through quizzes, assignments, and course completions. Detailed progress reports are available on your dashboard for continuous monitoring.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(17,4,'How can I update my profile information?','Users can update their profile information via the profile settings page. Changes take effect immediately after submission, ensuring your account details remain current.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(18,4,'What are the benefits of teacher training courses?','Teacher training courses enhance pedagogical skills and provide practical classroom strategies. They offer certification, professional development, and valuable networking opportunities.',1,'2025-04-07 03:35:40','2025-04-07 03:35:40',_binary '',_binary '\0'),(19,3,'Innovative Pedagogy: Transforming Teacher Training','In today\'s rapidly evolving educational landscape, innovative pedagogy offers teachers new approaches to engage students and enhance learning experiences. By integrating technology with proven teaching strategies, educators can unlock creative potential in the classroom.\n\nThis blog post explores the latest trends in teacher training, highlighting success stories and practical tips for implementing innovative strategies. It is a must-read for educators seeking to adapt to modern challenges and inspire lifelong learning.',1,'2025-04-07 03:37:43','2025-04-07 03:37:43',_binary '',_binary '\0'),(20,3,'Embracing Digital Tools for Enhanced Learning','Digital tools are reshaping how education is delivered and received. In this blog, we delve into the advantages of using multimedia, interactive software, and online resources to support teachers and students alike.\n\nThe post offers insights on how educators can integrate digital solutions into their curriculum, providing examples and case studies. It encourages a forward-thinking approach to modernizing teaching methodologies.',1,'2025-04-07 03:37:43','2025-04-07 03:37:43',_binary '',_binary '\0'),(21,3,'Empowering Educators: The Future of Teacher Development','Empowering educators is at the heart of sustainable educational progress. This blog discusses strategies that build teacher confidence and competence through continuous professional development and collaborative learning environments.\n\nThe article reviews innovative programs, success metrics, and practical frameworks that support teacher empowerment. It aims to inspire teachers to embrace new challenges and drive meaningful change in their classrooms.\n\nDiscover how thoughtful professional development can pave the way for transformative educational practices.',1,'2025-04-07 03:37:43','2025-04-07 03:37:43',_binary '',_binary '\0'),(84,3,'Announcement','New update on the curriculum.',1,'2025-04-06 04:33:07','2025-04-06 22:14:45',_binary '',_binary '\0');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_type`
--

DROP TABLE IF EXISTS `content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_type` (
  `content_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`content_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type`
--

LOCK TABLES `content_type` WRITE;
/*!40000 ALTER TABLE `content_type` DISABLE KEYS */;
INSERT INTO `content_type` VALUES (1,'Service Description'),(2,'Process Description'),(3,'Post'),(4,'FAQ');
/*!40000 ALTER TABLE `content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (4,'superadmin',0),(5,'instructor',0),(6,'student',0),(7,'org',0),(8,'org-admin',0);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material`
--

DROP TABLE IF EXISTS `training_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `material_type_id` int NOT NULL,
  `material_category_id` int DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `is_active` tinyint DEFAULT '1',
  `is_deleted` tinyint DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(1024) DEFAULT NULL,
  `description` text,
  `thumbnail` blob,
  `background_img` text,
  PRIMARY KEY (`material_id`),
  KEY `material_type_id` (`material_type_id`),
  KEY `material_category_id` (`material_category_id`),
  CONSTRAINT `training_material_ibfk_1` FOREIGN KEY (`material_type_id`) REFERENCES `training_material_type` (`material_type_id`) ON DELETE CASCADE,
  CONSTRAINT `training_material_ibfk_2` FOREIGN KEY (`material_category_id`) REFERENCES `training_material_category` (`material_category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material`
--

LOCK TABLES `training_material` WRITE;
/*!40000 ALTER TABLE `training_material` DISABLE KEYS */;
INSERT INTO `training_material` VALUES (133,9,34,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Art Training Material','Comprehensive training material for Art. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(134,10,39,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Biology Training Material','Comprehensive training material for Biology. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(135,10,40,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Chemistry Training Material','Comprehensive training material for Chemistry. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(136,10,45,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Civics Training Material','Comprehensive training material for Civics. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(138,9,48,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Drama Training Material','Comprehensive training material for Drama. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(139,10,38,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Economics Training Material','Comprehensive training material for Economics. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(140,9,31,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','English Literature Training Material','Comprehensive training material for English Literature. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(141,10,47,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Environmental Science Training Material','Comprehensive training material for Environmental Science. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(142,10,43,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Foreign Language Training Material','Comprehensive training material for Foreign Language. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(144,10,44,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Health Training Material','Comprehensive training material for Health. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(145,9,32,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','History Training Material','Comprehensive training material for History. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(146,10,46,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Literature Training Material','Comprehensive training material for Literature. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(148,9,35,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Music Training Material','Comprehensive training material for Music. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(150,10,41,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Physics Training Material','Comprehensive training material for Physics. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(152,10,42,1,1,0,'2025-04-06 10:03:07','2025-04-06 10:03:07','Social Studies Training Material','Comprehensive training material for Social Studies. The domain is The LMS is for PEdagogy for American School Curriculum where the teachers are trained - training teachers from grade 1 to grade 12th in America. Include 20 different material categories for the school curriculum in America. Be creative to generate the data.',NULL,NULL),(160,7,37,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Computer Science','This training material covers Computer Science fundamentals and advanced topics, designed specifically for teacher training.',NULL,''),(161,7,31,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for English Literature','This training material covers English Literature essentials, providing insights into literary analysis and creative teaching methods.',NULL,''),(162,7,29,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Mathematics','This training material delves into Mathematics concepts from basic arithmetic to advanced problem-solving techniques for educators.',NULL,''),(163,7,30,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Science','This training material offers a comprehensive overview of scientific principles, experiments, and inquiry-based teaching strategies.',NULL,''),(164,7,32,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for History','This training material explores historical events and methodologies, enabling teachers to present history in an engaging and contextual manner.',NULL,''),(165,7,33,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Geography','This training material focuses on geographical concepts and map-reading skills, essential for integrating spatial awareness in classrooms.',NULL,''),(166,7,34,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Art','This training material covers visual arts and creative expression, providing teachers with techniques to inspire artistic development.',NULL,''),(167,7,35,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Music','This training material introduces music theory and performance skills, supporting teachers in delivering a dynamic music education.',NULL,''),(168,7,36,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Physical Education','This training material is designed to enhance Physical Education instruction, emphasizing sports, fitness, and health education strategies.',NULL,''),(169,7,45,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Civics','This training material covers the fundamentals of civics, enabling educators to discuss governmental structures and civic responsibilities.',NULL,''),(170,7,44,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Health','This training material provides comprehensive insights into health and wellness education, tailored for teacher development in promoting student well-being.',NULL,''),(171,7,43,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Foreign Language','This training material supports language acquisition techniques and cultural immersion strategies for effective foreign language teaching.',NULL,''),(172,7,42,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Social Studies','This training material emphasizes critical thinking in social studies, integrating current events with historical and cultural analysis.',NULL,''),(173,7,41,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Physics','This training material explains fundamental laws of physics using experiments and inquiry-based approaches for effective teaching.',NULL,''),(174,7,40,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Chemistry','This training material covers chemical reactions and laboratory techniques, providing educators with hands-on approaches to teaching chemistry.',NULL,''),(175,7,39,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Biology','This training material introduces biological concepts and life sciences through interactive experiments and field studies.',NULL,''),(176,7,38,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Economics','This training material explores economic principles and market trends, using real-world examples to support teacher training in economics.',NULL,''),(177,7,48,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Drama','This training material covers theatre arts and performance studies, offering techniques to enhance creativity and expressive skills in drama.',NULL,''),(178,7,47,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Environmental Science','This training material focuses on ecosystems, sustainability, and environmental issues, equipping teachers to integrate environmental science in their lessons.',NULL,''),(179,7,46,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Literature','This training material explores both classical and contemporary literature, enhancing teachers’ ability to analyze texts and promote literary discussions.',NULL,''),(180,7,45,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Civics','This training material revisits civic education with advanced strategies to encourage community engagement and informed debate in schools.',NULL,''),(181,7,44,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Health','This training material offers updated approaches to health education, focusing on both physical and mental well-being in the classroom.',NULL,''),(182,7,37,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Computer Science','This training material provides a second look at Computer Science topics, emphasizing modern programming and problem-solving techniques for teachers.',NULL,''),(183,7,36,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Physical Education','This training material revisits Physical Education with new fitness trends and sports education methodologies to enhance teacher instruction.',NULL,''),(184,7,35,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Music','This training material is designed for music educators, covering advanced musical techniques and diverse genre exploration to enrich classroom instruction.',NULL,''),(185,7,34,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Art','This training material focuses on creative expression and art history, offering innovative strategies for art teachers to inspire student creativity.',NULL,''),(186,7,33,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Geography','This training material provides an in-depth look at geographical methods and spatial analysis, essential for modern geography instruction in teacher training.',NULL,''),(187,7,32,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for History','This training material revisits historical methodologies and source analysis, equipping educators with advanced techniques for teaching history effectively.',NULL,''),(188,7,31,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for English Literature','This training material explores advanced literary analysis and creative teaching strategies for English Literature, aimed at enhancing teacher expertise.',NULL,''),(189,7,29,1,1,0,'2025-04-07 09:34:13','2025-04-07 09:48:14','Training Material for Mathematics','This training material provides a revisited approach to Mathematics instruction, combining fundamental concepts with innovative problem-solving techniques for teacher development.',NULL,''),(190,6,29,1,1,0,'2025-04-07 17:51:43','2025-04-07 20:53:21','Mathematics: Advanced Teaching Guide','A comprehensive guide for teaching advanced mathematics using modern methodologies. It includes detailed lesson plans, practical exercises, and assessment strategies tailored for educators.',NULL,''),(191,6,31,1,1,0,'2025-04-07 17:51:43','2025-04-07 17:54:20','English Literature: Syllabus Overview','This document provides an in-depth overview of the English Literature syllabus for teacher training. It outlines key texts, literary analysis techniques, and discussion topics to enrich classroom learning.',NULL,''),(192,6,30,1,1,0,'2025-04-07 17:51:43','2025-04-07 17:54:20','Science: Experiment Manual','A practical manual containing step-by-step science experiments and classroom activities. It emphasizes safety guidelines and experimental methodologies to support science educators.',NULL,''),(193,6,32,1,1,0,'2025-04-07 17:51:43','2025-04-07 17:54:20','History: Analytical Framework','An analytical framework designed to help teachers evaluate historical events critically. This resource includes methodologies for source analysis and contextual interpretation.',NULL,''),(194,6,33,1,1,0,'2025-04-07 17:51:43','2025-04-07 17:54:20','Geography: Interactive Map Presentation','A dynamic presentation resource showcasing interactive maps and spatial analysis tools. It is intended to help educators integrate technology into geography lessons effectively.',NULL,'');
/*!40000 ALTER TABLE `training_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_category`
--

DROP TABLE IF EXISTS `training_material_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_category` (
  `material_category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `category_description` text,
  `is_active` bit(1) DEFAULT b'1',
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`material_category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_category`
--

LOCK TABLES `training_material_category` WRITE;
/*!40000 ALTER TABLE `training_material_category` DISABLE KEYS */;
INSERT INTO `training_material_category` VALUES (29,'Mathematics','Covers arithmetic, algebra, geometry, calculus and statistics.',_binary '',_binary '\0'),(30,'Science','Includes physics, chemistry, biology, and earth sciences.',_binary '',_binary '\0'),(31,'English Literature','Study of literature and language arts.',_binary '',_binary '\0'),(32,'History','World history, American history, and modern history.',_binary '',_binary '\0'),(33,'Geography','Study of physical and human geography.',_binary '',_binary '\0'),(34,'Art','Visual arts, art history, and creative expression.',_binary '',_binary '\0'),(35,'Music','Music theory, instruments, and performance.',_binary '',_binary '\0'),(36,'Physical Education','Sports, fitness, and health education.',_binary '',_binary '\0'),(37,'Computer Science','Introduction to programming and computational thinking.',_binary '',_binary '\0'),(38,'Economics','Basic economics principles and business studies.',_binary '',_binary '\0'),(39,'Biology','Detailed study of life sciences.',_binary '',_binary '\0'),(40,'Chemistry','Chemical reactions, compounds, and laboratory techniques.',_binary '',_binary '\0'),(41,'Physics','Fundamentals of physics including mechanics and thermodynamics.',_binary '',_binary '\0'),(42,'Social Studies','Civics, sociology, and cultural studies.',_binary '',_binary '\0'),(43,'Foreign Language','Learning languages such as Spanish, French, or Mandarin.',_binary '',_binary '\0'),(44,'Health','Personal health and wellness education.',_binary '',_binary '\0'),(45,'Civics','Government, politics, and social responsibilities.',_binary '',_binary '\0'),(46,'Literature','Study of classical and contemporary literature.',_binary '',_binary '\0'),(47,'Environmental Science','Study of ecosystems, sustainability and environmental issues.',_binary '',_binary '\0'),(48,'Drama','Theatre arts and performance studies.',_binary '',_binary '\0');
/*!40000 ALTER TABLE `training_material_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_files`
--

DROP TABLE IF EXISTS `training_material_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_files` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `training_material_files_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_files`
--

LOCK TABLES `training_material_files` WRITE;
/*!40000 ALTER TABLE `training_material_files` DISABLE KEYS */;
INSERT INTO `training_material_files` VALUES (1,190,'courses/pedagogy2.png'),(2,191,'courses/pedagogy.docx'),(3,192,'courses/pedagogy.pdf'),(4,193,'courses/pedagogy.pptx'),(5,194,'courses/pedagogy.png');
/*!40000 ALTER TABLE `training_material_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_mcqs`
--

DROP TABLE IF EXISTS `training_material_mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_mcqs` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `question_text` text NOT NULL,
  `answer_1` text NOT NULL,
  `answer_2` text NOT NULL,
  `answer_3` text NOT NULL,
  `answer_4` text NOT NULL,
  `correct_1` tinyint(1) DEFAULT '0',
  `correct_2` tinyint(1) DEFAULT '0',
  `correct_3` tinyint(1) DEFAULT '0',
  `correct_4` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`question_id`),
  KEY `training_material_mcqs` (`material_id`),
  CONSTRAINT `training_material_mcqs` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_mcqs`
--

LOCK TABLES `training_material_mcqs` WRITE;
/*!40000 ALTER TABLE `training_material_mcqs` DISABLE KEYS */;
INSERT INTO `training_material_mcqs` VALUES (1,160,'In the Computer Science module, which of the following best describes computational thinking in teaching?','Breaking down problems into smaller parts.','Using technology to enhance learning.','Memorizing algorithms without understanding.','Ignoring problem-solving strategies.',1,1,0,0),(2,161,'In the English Literature module, what are effective strategies for analyzing a text?','Identifying themes and motifs.','Noting literary devices.','Skipping difficult passages.','Comparing texts with historical context.',1,1,0,1),(3,162,'In the Mathematics module, which methods enhance problem-solving skills?','Practice with varied problems.','Understanding underlying concepts.','Rote memorization only.','Using real-world applications.',1,1,0,1),(4,163,'In the Science module, which approaches best foster scientific inquiry?','Conducting experiments.','Asking open-ended questions.','Relying solely on textbooks.','Encouraging observations and analysis.',1,1,0,1),(5,164,'In the History module, which techniques help in understanding historical events?','Analyzing primary sources.','Chronologically mapping events.','Ignoring cultural context.','Discussing multiple perspectives.',1,1,0,1),(6,165,'In the Geography module, which skills are essential for interpreting maps?','Understanding scale and distance.','Reading legends and symbols.','Overlooking topographical details.','Analyzing spatial relationships.',1,1,0,1),(7,166,'In the Art module, what are key elements of visual analysis?','Observing color and composition.','Understanding symbolism.','Focusing solely on technical skill.','Considering context and style.',1,1,0,1),(8,167,'In the Music module, which factors contribute to a comprehensive music education?','Learning music theory.','Practicing instruments regularly.','Ignoring historical context.','Exploring various musical genres.',1,1,0,1),(9,168,'In the Physical Education module, which practices promote overall fitness in students?','Regular physical activity.','Balanced nutrition.','Excessive sedentary behavior.','Varied sports and exercises.',1,1,0,1),(10,169,'In the Civics module, which aspects are critical for civic education?','Understanding governmental structures.','Discussing rights and responsibilities.','Excluding community engagement.','Encouraging informed debate.',1,1,0,1),(11,170,'In the Health module, which factors are essential for promoting wellness in schools?','Regular health education classes.','Accessible mental health resources.','Skipping regular exercise.','Encouraging healthy eating habits.',1,1,0,1),(12,171,'In the Foreign Language module, what strategies are effective for language acquisition?','Immersive language practice.','Regular conversational practice.','Memorizing vocabulary without context.','Engaging with native speakers.',1,1,0,1),(13,172,'In the Social Studies module, which methods enhance critical thinking about society?','Analyzing current events.','Discussing cultural diversity.','Avoiding controversial topics.','Evaluating historical case studies.',1,1,0,1),(14,173,'In the Physics module, which techniques best help students understand fundamental laws?','Using real-world experiments.','Applying mathematical models.','Relying solely on theoretical lectures.','Encouraging inquiry-based learning.',1,1,0,1),(15,174,'In the Chemistry module, which practices assist in grasping chemical reactions?','Conducting laboratory experiments.','Balancing equations methodically.','Memorizing elements without application.','Visualizing molecular structures.',1,1,0,1),(16,175,'In the Biology module, which approaches are most effective for understanding life processes?','Hands-on experiments with specimens.','Studying biological models and diagrams.','Ignoring ecological relationships.','Integrating field studies.',1,1,0,1),(17,176,'In the Economics module, which factors are vital for teaching economic principles effectively?','Relating theory to real-world examples.','Analyzing market trends.','Ignoring statistical data.','Utilizing interactive simulations.',1,1,0,1),(18,177,'In the Drama module, which elements contribute to a successful performance lesson?','Understanding character development.','Emphasizing stage presence.','Overlooking script analysis.','Encouraging improvisation.',1,1,0,1),(19,178,'In the Environmental Science module, which strategies are important for fostering environmental awareness?','Studying local ecosystems.','Analyzing human impact on nature.','Ignoring sustainability practices.','Promoting conservation efforts.',1,1,0,1),(20,179,'In the Literature module, which approaches help in appreciating literary works?','Examining narrative structures.','Exploring symbolism and metaphors.','Disregarding author context.','Comparing different literary genres.',1,1,0,1),(21,180,'In the Civics module, which factors are essential for civic engagement in schools?','Encouraging student participation in debates.','Teaching constitutional principles.','Neglecting community involvement.','Promoting volunteer activities.',1,1,0,1),(22,181,'In the Health module, which methods can improve student well-being?','Regular physical check-ups.','Integrating mental health awareness.','Ignoring dietary needs.','Implementing fitness programs.',1,1,0,1),(23,182,'In the Computer Science module, which approaches best support coding education?','Project-based learning.','Interactive coding exercises.','Relying solely on theoretical lectures.','Pair programming and collaboration.',1,1,0,1),(24,183,'In the Physical Education module, what practices help improve students\' motor skills?','Structured warm-up routines.','Regular skill drills.','Ignoring coordination exercises.','Integrating fun, competitive games.',1,1,0,1),(25,184,'In the Music module, which techniques are effective for teaching rhythm and harmony?','Using metronomes and rhythm exercises.','Listening to diverse musical styles.','Avoiding hands-on practice.','Group music activities and ensemble practice.',1,1,0,1),(26,185,'In the Art module, which aspects are crucial for fostering creativity in students?','Encouraging experimental techniques.','Studying art history.','Limiting self-expression.','Providing diverse materials and tools.',1,1,0,1),(27,186,'In the Geography module, which methods aid in developing spatial awareness?','Using interactive maps.','Analyzing regional data.','Overlooking physical landmarks.','Participating in field studies.',1,1,0,1),(28,187,'In the History module, what strategies help students critically analyze historical events?','Evaluating multiple sources.','Contextualizing events within broader narratives.','Relying only on textbook summaries.','Engaging in debates and discussions.',1,1,0,1),(29,188,'In the English Literature module, which techniques improve literary interpretation skills?','Close reading of texts.','Discussion of thematic elements.','Skipping analysis of symbolism.','Comparative study of different works.',1,1,0,1),(30,189,'In the Mathematics module, which strategies are most effective in teaching problem-solving?','Encouraging step-by-step reasoning.','Using real-life examples.','Focusing solely on formulas.','Promoting collaborative problem-solving.',1,1,0,1);
/*!40000 ALTER TABLE `training_material_mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_text`
--

DROP TABLE IF EXISTS `training_material_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_text` (
  `text_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`text_id`),
  KEY `training_material_text` (`material_id`),
  CONSTRAINT `training_material_text` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_text`
--

LOCK TABLES `training_material_text` WRITE;
/*!40000 ALTER TABLE `training_material_text` DISABLE KEYS */;
INSERT INTO `training_material_text` VALUES (20,133,'This is an in-depth text training material for Art.'),(21,138,'This is an in-depth text training material for Drama.'),(22,140,'This is an in-depth text training material for English Literature.'),(23,145,'This is an in-depth text training material for History.'),(24,148,'This is an in-depth text training material for Music.');
/*!40000 ALTER TABLE `training_material_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_type`
--

DROP TABLE IF EXISTS `training_material_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_type` (
  `material_type_id` int NOT NULL AUTO_INCREMENT,
  `material_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`material_type_id`),
  UNIQUE KEY `material_type_name` (`material_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_type`
--

LOCK TABLES `training_material_type` WRITE;
/*!40000 ALTER TABLE `training_material_type` DISABLE KEYS */;
INSERT INTO `training_material_type` VALUES (6,'Files'),(7,'MCQ'),(8,'Q&A'),(9,'Text'),(10,'Video');
/*!40000 ALTER TABLE `training_material_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_material_videos`
--

DROP TABLE IF EXISTS `training_material_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_material_videos` (
  `video_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `url` text NOT NULL,
  `is_vimeo` tinyint DEFAULT '0',
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_material_videos`
--

LOCK TABLES `training_material_videos` WRITE;
/*!40000 ALTER TABLE `training_material_videos` DISABLE KEYS */;
INSERT INTO `training_material_videos` VALUES (9,134,'videos/v1.mp4',0),(10,135,'videos/v2.mp4',0),(11,136,'videos/v3.mp4',0);
/*!40000 ALTER TABLE `training_material_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_asked_questions`
--

DROP TABLE IF EXISTS `user_asked_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_asked_questions` (
  `user_question_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `asked_question` text NOT NULL,
  `admin_user_id` int DEFAULT NULL,
  `admin_answer` text,
  `is_public` tinyint DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_asked` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_answered` datetime DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0',
  `is_active` tinyint DEFAULT '1',
  PRIMARY KEY (`user_question_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_asked_questions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_asked_questions`
--

LOCK TABLES `user_asked_questions` WRITE;
/*!40000 ALTER TABLE `user_asked_questions` DISABLE KEYS */;
INSERT INTO `user_asked_questions` VALUES (37,25,'What is the best method to improve alice\'s learning outcomes?',NULL,'hey',1,'2025-04-06 04:33:07','2025-04-06 23:25:52','2025-04-06 10:03:07',NULL,0,1),(38,26,'What is the best method to improve bob\'s learning outcomes?',NULL,NULL,1,'2025-04-06 04:33:07','2025-04-06 04:33:07','2025-04-06 10:03:07',NULL,0,1),(39,27,'What is the best method to improve charlie\'s learning outcomes?',NULL,NULL,1,'2025-04-06 04:33:07','2025-04-06 04:33:07','2025-04-06 10:03:07',NULL,0,1);
/*!40000 ALTER TABLE `user_asked_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_exam_answers`
--

DROP TABLE IF EXISTS `user_exam_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_exam_answers` (
  `exam_question_id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int NOT NULL,
  `mcq_id` int NOT NULL,
  `choice_3_answer` tinyint DEFAULT '0',
  `choice_4_answer` tinyint DEFAULT '0',
  `choice_2_answer` tinyint DEFAULT '0',
  `choice_1_answer` tinyint DEFAULT '0',
  `attempted` tinyint DEFAULT '0',
  `is_correct` tinyint DEFAULT '0',
  PRIMARY KEY (`exam_question_id`),
  KEY `qa_id` (`mcq_id`),
  KEY `exam_id_idx` (`exam_id`),
  CONSTRAINT `exam_id` FOREIGN KEY (`exam_id`) REFERENCES `user_exams` (`exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=772 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_exam_answers`
--

LOCK TABLES `user_exam_answers` WRITE;
/*!40000 ALTER TABLE `user_exam_answers` DISABLE KEYS */;
INSERT INTO `user_exam_answers` VALUES (763,105,64,0,0,0,1,1,1),(764,106,64,0,0,0,1,1,1),(765,107,64,0,0,0,1,1,1),(766,105,66,0,0,1,1,1,0),(767,105,64,0,0,1,0,1,0),(768,105,65,0,0,0,0,0,0),(769,108,64,0,0,0,0,0,0),(770,108,66,0,0,0,1,1,1),(771,108,65,0,0,0,0,0,0);
/*!40000 ALTER TABLE `user_exam_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_exams`
--

DROP TABLE IF EXISTS `user_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_exams` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_started` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `score` int DEFAULT NULL,
  `result` tinyint DEFAULT '0',
  `certificate_url` varchar(255) DEFAULT NULL,
  `num_questions` int DEFAULT NULL,
  `num_attempted` int DEFAULT NULL,
  `num_correct` int DEFAULT NULL,
  `num_wrong` int DEFAULT NULL,
  `min_correct_answers_for_pass` int DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `user_id` (`user_id`),
  KEY `result_type_id` (`result`),
  CONSTRAINT `user_exams_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_exams`
--

LOCK TABLES `user_exams` WRITE;
/*!40000 ALTER TABLE `user_exams` DISABLE KEYS */;
INSERT INTO `user_exams` VALUES (105,25,'2025-04-06 10:03:07','2025-04-07 06:04:25','2025-04-07 06:04:37',0,0,NULL,3,2,0,3,7),(106,26,'2025-04-06 10:03:07',NULL,NULL,80,1,NULL,10,8,7,1,6),(107,27,'2025-04-06 10:03:07',NULL,NULL,80,1,NULL,10,8,7,1,6),(108,25,'2025-04-07 05:16:04','2025-04-07 08:25:26','2025-04-07 08:25:34',1,0,NULL,3,1,1,2,7);
/*!40000 ALTER TABLE `user_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `avatar` varchar(1024) DEFAULT '"',
  `address` varchar(255) DEFAULT '',
  `phone_number` varchar(20) NOT NULL DEFAULT '',
  `dob` datetime DEFAULT NULL,
  `license_number` varchar(255) DEFAULT NULL,
  `license_issue_date` datetime DEFAULT NULL,
  `license_expiry_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`profile_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (26,25,'Alice','Smith','1.jpg','123 Alice Street','1234567890','2000-01-01 00:00:00','ALICE-LICENSE','2020-01-01 00:00:00','2030-01-01 00:00:00','2025-04-06 04:33:07','2025-04-07 15:08:31'),(27,26,'Bob','Johnson','2.jpg','123 Bob Street','1234567890','2000-01-01 00:00:00','BOB-LICENSE','2020-01-01 00:00:00','2030-01-01 00:00:00','2025-04-06 04:33:07','2025-04-07 15:12:45'),(28,27,'Charlie','Williams','3.jpg','123 Charlie Street','1234567890','2000-01-01 00:00:00','CHARLIE-LICENSE','2020-01-01 00:00:00','2030-01-01 00:00:00','2025-04-06 04:33:07','2025-04-07 15:08:31');
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_role_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (22,25,6,'2025-04-06 04:33:07','2025-04-06 23:49:26'),(23,26,5,'2025-04-06 04:33:07','2025-04-06 04:33:07'),(24,27,6,'2025-04-06 04:33:07','2025-04-06 04:33:07');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_approved` tinyint DEFAULT '0',
  `approved_rejected_by` int DEFAULT '-1',
  `approved_rejected_reason` varchar(255) DEFAULT NULL,
  `approved_rejected_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_locked` tinyint NOT NULL DEFAULT '0',
  `is_deleted` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (25,'alice','123','alice@example.com',1,-1,NULL,'2025-04-06 10:03:07',0,0,'2025-04-06 04:33:07','2025-04-06 23:29:21'),(26,'bob','123','bob@example.com',1,-1,NULL,'2025-04-06 10:03:07',0,0,'2025-04-06 04:33:07','2025-04-06 23:29:21'),(27,'charlie','123','charlie@example.com',1,-1,NULL,'2025-04-06 10:03:07',0,0,'2025-04-06 04:33:07','2025-04-06 23:29:21');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'chordify-lms-pedagogy-db'
--

--
-- Dumping routines for database 'chordify-lms-pedagogy-db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08 19:06:16
