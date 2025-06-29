#!/usr/bin/env python3
import mysql.connector

# --- Configuration Variables ---

# Domain description and OpenAI prompt to be used with every creative data generation
DOMAIN_NAME = "The LMS is for PEdagogy for American School Curriculum where the teachers are trained"
OPENAI_PROMPT = (
    f"The domain is {DOMAIN_NAME} - training teachers from grade 1 to grade 12th in America. "
    "Include 20 different material categories for the school curriculum in America. Be creative to generate the data."
)

# MySQL database connection variables
DB_HOST = "localhost"
DB_PORT = 3306
DB_USER = "root"
DB_PASSWORD = "root"
DB_NAME = "chordify-lms-pedagogy-db"

# --- DDL Script ---
ddl_script = """
CREATE DATABASE  IF NOT EXISTS `chordify-lms-pedagogy-db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chordify-lms-pedagogy-db`;

DROP TABLE IF EXISTS `content_type`;
CREATE TABLE `content_type` (
  `content_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`content_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material_type`;
CREATE TABLE `training_material_type` (
  `material_type_id` int NOT NULL AUTO_INCREMENT,
  `material_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`material_type_id`),
  UNIQUE KEY `material_type_name` (`material_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `users`;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user_roles`;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user_profiles`;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `content`;
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
  KEY `content_type_id` (`content_type_id`),
  CONSTRAINT `content_ibfk_1` FOREIGN KEY (`content_type_id`) REFERENCES `content_type` (`content_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material_category`;
CREATE TABLE `training_material_category` (
  `material_category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `category_description` text,
  `is_active` bit(1) DEFAULT b'1',
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`material_category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material`;
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material_files`;
CREATE TABLE `training_material_files` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `training_material_files_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material_mcqs`;
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material_text`;
CREATE TABLE `training_material_text` (
  `text_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`text_id`),
  KEY `training_material_text` (`material_id`),
  CONSTRAINT `training_material_text` FOREIGN KEY (`material_id`) REFERENCES `training_material` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `training_material_videos`;
CREATE TABLE `training_material_videos` (
  `video_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `url` text NOT NULL,
  `is_vimeo` tinyint DEFAULT '0',
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user_exams`;
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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user_asked_questions`;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user_exam_answers`;
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
) ENGINE=InnoDB AUTO_INCREMENT=763 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
"""

# --- Functions for Data Insertion ---
def execute_ddl(cursor):
    # Split the DDL script on semicolons and execute each non-empty query
    queries = ddl_script.split(";")
    for query in queries:
        query = query.strip()
        if query:
            cursor.execute(query)

def create_content_type(cursor):
    content_types = [
        ("Service Description",),
        ("Process Description",),
        ("Post",),
        ("FAQ",)
    ]
    query = "INSERT INTO content_type (type_name) VALUES (%s)"
    for ct in content_types:
        cursor.execute(query, ct)
    cursor.execute("SELECT content_type_id, type_name FROM content_type")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_training_material_type(cursor):
    material_types = [
        ("Files",),
        ("MCQ",),
        ("Q&A",),
        ("Text",),
        ("Video",)
    ]
    query = "INSERT INTO training_material_type (material_type_name) VALUES (%s)"
    for mt in material_types:
        cursor.execute(query, mt)
    cursor.execute("SELECT material_type_id, material_type_name FROM training_material_type")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_roles(cursor):
    roles = [
        ("superadmin", 0),
        ("instructor", 0),
        ("student", 0),
        ("org", 0),
        ("org-admin", 0)
    ]
    query = "INSERT INTO roles (role_name, is_deleted) VALUES (%s, %s)"
    for role in roles:
        cursor.execute(query, role)
    cursor.execute("SELECT role_id, role_name FROM roles")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_training_material_category(cursor):
    categories = [
        ("Mathematics", "Covers arithmetic, algebra, geometry, calculus and statistics."),
        ("Science", "Includes physics, chemistry, biology, and earth sciences."),
        ("English Literature", "Study of literature and language arts."),
        ("History", "World history, American history, and modern history."),
        ("Geography", "Study of physical and human geography."),
        ("Art", "Visual arts, art history, and creative expression."),
        ("Music", "Music theory, instruments, and performance."),
        ("Physical Education", "Sports, fitness, and health education."),
        ("Computer Science", "Introduction to programming and computational thinking."),
        ("Economics", "Basic economics principles and business studies."),
        ("Biology", "Detailed study of life sciences."),
        ("Chemistry", "Chemical reactions, compounds, and laboratory techniques."),
        ("Physics", "Fundamentals of physics including mechanics and thermodynamics."),
        ("Social Studies", "Civics, sociology, and cultural studies."),
        ("Foreign Language", "Learning languages such as Spanish, French, or Mandarin."),
        ("Health", "Personal health and wellness education."),
        ("Civics", "Government, politics, and social responsibilities."),
        ("Literature", "Study of classical and contemporary literature."),
        ("Environmental Science", "Study of ecosystems, sustainability and environmental issues."),
        ("Drama", "Theatre arts and performance studies.")
    ]
    query = "INSERT INTO training_material_category (category_name, category_description) VALUES (%s, %s)"
    for cat in categories:
        cursor.execute(query, cat)
    cursor.execute("SELECT material_category_id, category_name FROM training_material_category")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_users(cursor):
    users = [
        ("alice", "hashed_password_1", "alice@example.com", 1, -1, None, 0, 1),
        ("bob", "hashed_password_2", "bob@example.com", 1, -1, None, 0, 1),
        ("charlie", "hashed_password_3", "charlie@example.com", 1, -1, None, 0, 1)
    ]
    query = """
    INSERT INTO users (username, password_hash, email, is_approved, approved_rejected_by, approved_rejected_reason, is_locked, is_deleted)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    for user in users:
        cursor.execute(query, user)
    cursor.execute("SELECT user_id, username FROM users")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_user_profiles(cursor, user_ids):
    profiles = []
    for username, uid in user_ids.items():
        first_name = username.capitalize()
        last_name = "Smith" if username == "alice" else "Johnson" if username == "bob" else "Williams"
        avatar = f"https://example.com/avatars/{username}.png"
        address = f"123 {username.capitalize()} Street"
        phone_number = "1234567890"
        dob = "2000-01-01"
        license_number = f"{username.upper()}-LICENSE"
        license_issue_date = "2020-01-01"
        license_expiry_date = "2030-01-01"
        profiles.append((uid, first_name, last_name, avatar, address, phone_number, dob, license_number, license_issue_date, license_expiry_date))
    query = """
    INSERT INTO user_profiles (user_id, first_name, last_name, avatar, address, phone_number, dob, license_number, license_issue_date, license_expiry_date)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    for profile in profiles:
        cursor.execute(query, profile)
    cursor.execute("SELECT profile_id, user_id FROM user_profiles")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_user_roles(cursor, user_ids, role_ids):
    user_roles = [
        (user_ids["alice"], role_ids["superadmin"]),
        (user_ids["bob"], role_ids["instructor"]),
        (user_ids["charlie"], role_ids["student"])
    ]
    query = "INSERT INTO user_roles (user_id, role_id) VALUES (%s, %s)"
    for ur in user_roles:
        cursor.execute(query, ur)

def create_content(cursor, content_type_ids):
    sample_contents = [
        (content_type_ids["Service Description"], "Service Overview", "Detailed description of the service provided."),
        (content_type_ids["Process Description"], "Process Flow", "Step by step process of our operations."),
        (content_type_ids["Post"], "Announcement", "New update on the curriculum."),
        (content_type_ids["FAQ"], "Frequently Asked Questions", "Answers to common questions.")
    ]
    query = "INSERT INTO content (content_type_id, title, description, is_public) VALUES (%s, %s, %s, %s)"
    for content in sample_contents:
        cursor.execute(query, (*content, 1))
    cursor.execute("SELECT content_id, title FROM content")
    rows = cursor.fetchall()
    return {row[1]: row[0] for row in rows}

def create_training_material(cursor, material_type_ids, category_ids):
    training_material_ids = {}
    for cat_name, cat_id in category_ids.items():
        if cat_name in ["Mathematics", "Science", "Computer Science"]:
            material_type = "MCQ"
        elif cat_name in ["English Literature", "History", "Art", "Music", "Drama"]:
            material_type = "Text"
        elif cat_name in ["Geography", "Physical Education"]:
            material_type = "Files"
        else:
            material_type = "Video"
        title = f"{cat_name} Training Material"
        description = f"Comprehensive training material for {cat_name}. {OPENAI_PROMPT}"
        query = """
        INSERT INTO training_material (material_type_id, material_category_id, is_public, is_active, is_deleted, title, description)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (material_type_ids[material_type], cat_id, 1, 1, 0, title, description))
        training_material_ids[cat_name] = cursor.lastrowid
    return training_material_ids

def create_training_material_files(cursor, training_material_ids):
    for cat_name, material_id in training_material_ids.items():
        if cat_name in ["Geography", "Physical Education"]:
            file_name = f"{cat_name}\\training_material_file.pdf"
            query = "INSERT INTO training_material_files (material_id, file_name) VALUES (%s, %s)"
            cursor.execute(query, (material_id, file_name))

def create_training_material_videos(cursor, training_material_ids):
    for cat_name, material_id in training_material_ids.items():
        if cat_name not in ["Mathematics", "Science", "Computer Science", "English Literature", "History", "Art", "Music", "Drama", "Geography", "Physical Education"]:
            video_url = f"{cat_name}\\training_material_video.mp4"
            query = "INSERT INTO training_material_videos (material_id, url, is_vimeo) VALUES (%s, %s, %s)"
            cursor.execute(query, (material_id, video_url, 0))

def create_training_material_mcqs(cursor, training_material_ids):
    for cat_name, material_id in training_material_ids.items():
        if cat_name in ["Mathematics", "Science", "Computer Science"]:
            question_text = f"What is the fundamental concept in {cat_name}?"
            answer_1 = "Option A"
            answer_2 = "Option B"
            answer_3 = "Option C"
            answer_4 = "Option D"
            query = """
            INSERT INTO training_material_mcqs (material_id, question_text, answer_1, answer_2, answer_3, answer_4, correct_1, correct_2, correct_3, correct_4)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query, (material_id, question_text, answer_1, answer_2, answer_3, answer_4, 1, 0, 0, 0))

def create_training_material_text(cursor, training_material_ids):
    for cat_name, material_id in training_material_ids.items():
        if cat_name in ["English Literature", "History", "Art", "Music", "Drama"]:
            text_content = f"This is an in-depth text training material for {cat_name}."
            query = "INSERT INTO training_material_text (material_id, text) VALUES (%s, %s)"
            cursor.execute(query, (material_id, text_content))

def create_user_exams(cursor, user_ids):
    exam_ids = {}
    for username, uid in user_ids.items():
        num_questions = 10
        query = """
        INSERT INTO user_exams (user_id, score, result, num_questions, num_attempted, num_correct, num_wrong, min_correct_answers_for_pass)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (uid, 80, 1, num_questions, 8, 7, 1, 6))
        exam_ids[username] = cursor.lastrowid
    return exam_ids

def create_user_exam_answers(cursor, exam_ids):
    cursor.execute("SELECT question_id, material_id FROM training_material_mcqs")
    mcqs = cursor.fetchall()
    for username, exam_id in exam_ids.items():
        if mcqs:
            mcq = mcqs[0]
            mcq_id = mcq[0]
            query = """
            INSERT INTO user_exam_answers (exam_id, mcq_id, choice_1_answer, choice_2_answer, choice_3_answer, choice_4_answer, attempted, is_correct)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query, (exam_id, mcq_id, 1, 0, 0, 0, 1, 1))

def create_user_asked_questions(cursor, user_ids):
    for username, uid in user_ids.items():
        query = """
        INSERT INTO user_asked_questions (user_id, asked_question, is_public)
        VALUES (%s, %s, %s)
        """
        question = f"What is the best method to improve {username}'s learning outcomes?"
        cursor.execute(query, (uid, question, 1))

# --- Main Function ---
def main():
    try:
        connection = mysql.connector.connect(
            host=DB_HOST,
            port=DB_PORT,
            user=DB_USER,
            password=DB_PASSWORD,
            autocommit=False
        )
        cursor = connection.cursor()
        # Execute the DDL script to create (or recreate) the schema
        execute_ddl(cursor)
        cursor.execute(f"USE `{DB_NAME}`")
        
        # Insert base data and store primary keys for later foreign key use
        content_type_ids = create_content_type(cursor)
        material_type_ids = create_training_material_type(cursor)
        role_ids = create_roles(cursor)
        category_ids = create_training_material_category(cursor)
        user_ids = create_users(cursor)
        create_user_profiles(cursor, user_ids)
        create_user_roles(cursor, user_ids, role_ids)
        create_content(cursor, content_type_ids)
        training_material_ids = create_training_material(cursor, material_type_ids, category_ids)
        create_training_material_files(cursor, training_material_ids)
        create_training_material_videos(cursor, training_material_ids)
        create_training_material_mcqs(cursor, training_material_ids)
        create_training_material_text(cursor, training_material_ids)
        exam_ids = create_user_exams(cursor, user_ids)
        create_user_exam_answers(cursor, exam_ids)
        create_user_asked_questions(cursor, user_ids)
        
        connection.commit()
        print("Database setup and data insertion completed successfully.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        connection.rollback()
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == '__main__':
    main()
