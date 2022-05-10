
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_code` varchar(255) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`course_code`),
  KEY `department` (`department`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`department`) REFERENCES `faculty` (`department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('BU111','Business Environment','Business','Understanding the Business environment'),('CP264','Data Structures II','Computer Science','Continuation of Data Structures'),('CP373','Ethics in Computing','Computer Science','Overview of Computer Ethics'),('HI123','Great Battles of History','History','Overview of historical battles'),('HI211','German History','History','History of Germany 1870-1990');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `current_courses`
--

DROP TABLE IF EXISTS `current_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `current_courses` (
  `student_id` int NOT NULL,
  `course_code` varchar(255) NOT NULL,
  `semester` varchar(255) NOT NULL,
  PRIMARY KEY (`student_id`,`course_code`),
  KEY `course_code` (`course_code`),
  CONSTRAINT `current_courses_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `current_courses`
--

LOCK TABLES `current_courses` WRITE;
/*!40000 ALTER TABLE `current_courses` DISABLE KEYS */;
INSERT INTO `current_courses` VALUES (22050,'CP373','Fall 2021'),(53146,'BU111','Fall 2021'),(53146,'HI123','Fall 2021'),(90042,'CP264','Fall 2021'),(90042,'CP373','Fall 2021'),(98599,'HI123','Fall 2021');
/*!40000 ALTER TABLE `current_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `department` varchar(255) NOT NULL,
  `faculty` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES ('Anthropology','Arts'),('Business','Lazaridis School of Business and Economics'),('Computer Science','Science'),('English','Arts'),('Health Sciences','Science'),('History','Arts');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `past_courses`
--

DROP TABLE IF EXISTS `past_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `past_courses` (
  `student_id` int NOT NULL,
  `course_code` varchar(255) NOT NULL,
  `semester` varchar(255) NOT NULL,
  `grade` varchar(255) NOT NULL,
  PRIMARY KEY (`student_id`,`course_code`),
  KEY `course_code` (`course_code`),
  CONSTRAINT `past_courses_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `past_courses`
--

LOCK TABLES `past_courses` WRITE;
/*!40000 ALTER TABLE `past_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `past_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `major_minor` varchar(255) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`major_minor`),
  KEY `department` (`department`),
  CONSTRAINT `program_ibfk_1` FOREIGN KEY (`department`) REFERENCES `faculty` (`department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES ('Business','Business'),('Economics','Business'),('Computer Science','Computer Science'),('Data Science','Computer Science'),('Ancient Studies','History'),('History','History');
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scholarships`
--

DROP TABLE IF EXISTS `scholarships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scholarships` (
  `scholarship_name` varchar(255) NOT NULL,
  `student_id` int NOT NULL,
  `award_date` date NOT NULL,
  `award_amount` float NOT NULL,
  PRIMARY KEY (`scholarship_name`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `scholarships_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scholarships`
--

LOCK TABLES `scholarships` WRITE;
/*!40000 ALTER TABLE `scholarships` DISABLE KEYS */;
INSERT INTO `scholarships` VALUES ('Entrance Scholarship',5271,'2019-09-03',1000),('In-Course Scholarship',53146,'2021-01-07',1500);
/*!40000 ALTER TABLE `scholarships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `DOB` date NOT NULL,
  `address` varchar(255) NOT NULL,
  `full_part` varchar(255) NOT NULL,
  `admission_year` int NOT NULL,
  `curr_gpa` float NOT NULL,
  `grad_date` varchar(255) DEFAULT NULL,
  `international` tinyint(1) NOT NULL,
  `major` varchar(255) DEFAULT NULL,
  `minor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `major` (`major`),
  KEY `minor` (`minor`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`major`) REFERENCES `program` (`major_minor`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`minor`) REFERENCES `program` (`major_minor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (5271,'Maria','England','2002-01-13','866 Rue King','Part Time',2019,8,'Winter 2024',0,'Business','Economics'),(22050,'Cheryl','Dailey','1999-11-11','2914 rue Principale','Full Time',2018,10.5,'Spring 2022',0,'Computer Science',NULL),(53146,'William','Adkins','2000-09-09','1405 Riedel Street','Full Time',2019,11.5,'Fall 2023',0,'Business','History'),(90042,'Anthony','Stjohn','2000-12-11','4232 Toy Avenue','Part Time',2018,7.1,'Spring 2022',0,'Data Science',NULL),(98599,'Larry','Leeper','2001-04-12','1757 Beaver Creek','Full Time',2020,7.1,'Fall 2024',1,'Ancient Studies','Computer Science');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-02 17:44:21



--queries for testing

-- Simple SELECT, list individual courses that students are taken
SELECT student.student_id, student.first_name, student.last_name, current_courses.course_code FROM student, current_courses WHERE student.student_id = current_courses.student_id;

-- Subquery SELECT, get all students who currently have a course
SELECT S.student_id, S.first_name FROM student S WHERE EXISTS (SELECT * FROM current_courses C WHERE C.student_id=S.student_id);

--Inner Join, get all students with scholarships and show info
SELECT S.student_id, S.first_name, S.last_name, T.scholarship_name, T.award_amount, T.award_date FROM student S INNER JOIN scholarships T ON S.student_id=T.student_id;*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;