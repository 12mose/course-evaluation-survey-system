-- =======================================================
-- 0. CREATE ENUM TYPES (Required for PostgreSQL)
-- =======================================================
CREATE TYPE user_status_enum AS ENUM ('PENDING', 'ACTIVE', 'REJECTED');
CREATE TYPE access_type_enum AS ENUM ('AUTHENTICATED', 'GUEST', 'BOTH');
CREATE TYPE survey_status_enum AS ENUM ('DRAFT', 'PUBLISHED', 'CLOSED');
CREATE TYPE question_type_enum AS ENUM ('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TEXT');

-- -------------------------------------------------------
-- 1. ROLES
-- -------------------------------------------------------
CREATE TABLE roles (
                       role_id   SERIAL PRIMARY KEY,
                       role_name VARCHAR(50) NOT NULL UNIQUE   -- ADMIN, INITIATOR, TEACHER, RESPONDENT
);

INSERT INTO roles (role_name) VALUES
                                  ('ADMIN'), ('INITIATOR'), ('TEACHER'), ('RESPONDENT');

-- -------------------------------------------------------
-- 2. USERS
-- -------------------------------------------------------
CREATE TABLE users (
                       user_id      SERIAL PRIMARY KEY,
                       username     VARCHAR(100) NOT NULL UNIQUE,
                       email        VARCHAR(150) NOT NULL UNIQUE,
                       password     VARCHAR(255) NOT NULL,
                       full_name    VARCHAR(200) NOT NULL,
                       role_id      INT NOT NULL,
                       status       user_status_enum DEFAULT 'ACTIVE',
                       created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Default admin account (password: Admin@123 – bcrypt)
INSERT INTO users (username, email, password, full_name, role_id, status)
VALUES ('admin', 'admin@courseeval.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lH7y',
        'System Administrator', 1, 'ACTIVE');

-- -------------------------------------------------------
-- 3. COURSES
-- -------------------------------------------------------
CREATE TABLE courses (
                         course_id   SERIAL PRIMARY KEY,
                         course_code VARCHAR(20)  NOT NULL UNIQUE,
                         course_name VARCHAR(200) NOT NULL,
                         description TEXT,
                         created_by  INT,    -- admin user_id
                         created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- -------------------------------------------------------
-- 4. TEACHER_COURSES  (assignment)
-- -------------------------------------------------------
CREATE TABLE teacher_courses (
                                 id         SERIAL PRIMARY KEY,
                                 teacher_id INT NOT NULL,
                                 course_id  INT NOT NULL,
                                 assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 CONSTRAINT uq_teacher_course UNIQUE (teacher_id, course_id),
                                 FOREIGN KEY (teacher_id) REFERENCES users(user_id),
                                 FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

-- -------------------------------------------------------
-- 5. SURVEYS
-- -------------------------------------------------------
CREATE TABLE surveys (
                         survey_id      SERIAL PRIMARY KEY,
                         title          VARCHAR(300) NOT NULL,
                         description    TEXT,
                         course_id      INT NOT NULL,
                         created_by     INT NOT NULL,   -- initiator user_id
                         access_type    access_type_enum DEFAULT 'BOTH',
                         status         survey_status_enum DEFAULT 'DRAFT',
                         start_date     DATE,
                         end_date       DATE,
                         created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (course_id)  REFERENCES courses(course_id),
                         FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- -------------------------------------------------------
-- 6. SURVEY_QUESTIONS
-- -------------------------------------------------------
CREATE TABLE survey_questions (
                                  question_id   SERIAL PRIMARY KEY,
                                  survey_id     INT NOT NULL,
                                  question_text TEXT NOT NULL,
                                  question_type question_type_enum DEFAULT 'SINGLE_CHOICE',
                                  order_num     INT DEFAULT 0,
                                  FOREIGN KEY (survey_id) REFERENCES surveys(survey_id) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- 7. SURVEY_OPTIONS
-- -------------------------------------------------------
CREATE TABLE survey_options (
                                option_id   SERIAL PRIMARY KEY,
                                question_id INT NOT NULL,
                                option_text VARCHAR(500) NOT NULL,
                                order_num   INT DEFAULT 0,
                                FOREIGN KEY (question_id) REFERENCES survey_questions(question_id) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- 8. RESPONDENTS
-- -------------------------------------------------------
CREATE TABLE respondents (
                             respondent_id SERIAL PRIMARY KEY,
                             user_id       INT,                       -- NULL if guest
                             guest_email   VARCHAR(150),              -- used when guest
                             display_name  VARCHAR(200),
                             created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- -------------------------------------------------------
-- 9. SURVEY_RESPONSES  (one row per submission)
-- -------------------------------------------------------
CREATE TABLE survey_responses (
                                  response_id   SERIAL PRIMARY KEY,
                                  survey_id     INT NOT NULL,
                                  respondent_id INT NOT NULL,
                                  submitted_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  CONSTRAINT uq_survey_respondent UNIQUE (survey_id, respondent_id),
                                  FOREIGN KEY (survey_id)     REFERENCES surveys(survey_id),
                                  FOREIGN KEY (respondent_id) REFERENCES respondents(respondent_id)
);

-- -------------------------------------------------------
-- 10. RESPONSE_ANSWERS  (individual answers)
-- -------------------------------------------------------
CREATE TABLE response_answers (
                                  answer_id     SERIAL PRIMARY KEY,
                                  response_id   INT NOT NULL,
                                  question_id   INT NOT NULL,
                                  option_id     INT,          -- NULL for TEXT answers
                                  text_answer   TEXT,         -- used for TEXT question type
                                  FOREIGN KEY (response_id) REFERENCES survey_responses(response_id) ON DELETE CASCADE,
                                  FOREIGN KEY (question_id) REFERENCES survey_questions(question_id),
                                  FOREIGN KEY (option_id)   REFERENCES survey_options(option_id)
);