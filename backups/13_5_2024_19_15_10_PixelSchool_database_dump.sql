--
-- Generated by mysql-backup4j
-- https://github.com/SeunMatt/mysql-backup4j
-- Date: 13-5-2024 19:15:10
--

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

--
-- start  table dump : Appointment
--

CREATE TABLE IF NOT EXISTS `Appointment` (
  `id_appointment` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `lesson` tinyint NOT NULL,
  `hours` varchar(2) NOT NULL,
  `minutes` varchar(2) NOT NULL,
  `day` varchar(1) NOT NULL,
  `date` date NOT NULL DEFAULT '2024-01-01',
  `max_users` int NOT NULL,
  `teacher_id` int NOT NULL,
  `sgroup_id` int NOT NULL,
  PRIMARY KEY (`id_appointment`),
  KEY `lesson_teacher` (`teacher_id`),
  KEY `sgroup_lesson` (`sgroup_id`),
  CONSTRAINT `lesson_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `Employee` (`id_employee`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sgroup_lesson` FOREIGN KEY (`sgroup_id`) REFERENCES `Sgroups` (`id_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=444 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Appointment
--



--
-- start  table dump : appointment_students
--

CREATE TABLE IF NOT EXISTS `appointment_students` (
  `id_appointment_student` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  `student_id` int NOT NULL,
  `state` varchar(10) NOT NULL,
  PRIMARY KEY (`id_appointment_student`),
  KEY `appointment_id_lesson` (`appointment_id`),
  KEY `student_id_lesson` (`student_id`),
  CONSTRAINT `appointment_id_lesson` FOREIGN KEY (`appointment_id`) REFERENCES `Appointment` (`id_appointment`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `student_id_lesson` FOREIGN KEY (`student_id`) REFERENCES `Student` (`id_student`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : appointment_students
--



--
-- start  table dump : Cource
--

CREATE TABLE IF NOT EXISTS `Cource` (
  `id_cource` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_cource`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Cource
--



--
-- start  table dump : Employee
--

CREATE TABLE IF NOT EXISTS `Employee` (
  `id_employee` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) NOT NULL,
  `second_name` varchar(60) NOT NULL,
  `middle_name` varchar(60) NOT NULL DEFAULT '-',
  `password` varchar(250) NOT NULL,
  `login` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `role_id` int NOT NULL,
  `region_id` int NOT NULL,
  PRIMARY KEY (`id_employee`),
  KEY `employee_region` (`region_id`),
  KEY `employee_role` (`role_id`),
  CONSTRAINT `employee_region` FOREIGN KEY (`region_id`) REFERENCES `Region` (`id_region`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_role` FOREIGN KEY (`role_id`) REFERENCES `Role` (`id_role`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Employee
--


--
-- Inserts of Employee
--


/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;

--
-- start table insert : Employee
--
INSERT INTO `Employee`(`id_employee`, `first_name`, `second_name`, `middle_name`, `password`, `login`, `email`, `role_id`, `region_id`) VALUES 
(1, 'ADM', 'ADM', 'ADM', 'pass123', 'ADMRoot512362', 'test@mail.com', 3, 1);
--
-- end table insert : Employee
--

/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;


--
-- start  table dump : Homework
--

CREATE TABLE IF NOT EXISTS `Homework` (
  `id_homework` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL,
  `part` int NOT NULL,
  `num` tinyint NOT NULL,
  `timespan` int NOT NULL,
  `url` varchar(100) NOT NULL,
  `tegs` varchar(200) NOT NULL,
  `author_id` int NOT NULL,
  `module_id` int NOT NULL,
  PRIMARY KEY (`id_homework`),
  KEY `homework_author` (`author_id`),
  KEY `homework_module` (`module_id`),
  CONSTRAINT `homework_author` FOREIGN KEY (`author_id`) REFERENCES `Employee` (`id_employee`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `homework_module` FOREIGN KEY (`module_id`) REFERENCES `Module` (`id_module`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Homework
--



--
-- start  table dump : Homework_Try
--

CREATE TABLE IF NOT EXISTS `Homework_Try` (
  `id_try` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `homework_id` int NOT NULL,
  `num` int NOT NULL,
  `proscent` int NOT NULL,
  `text` varchar(255) NOT NULL,
  `comment` varchar(300) NOT NULL,
  `send_date` date NOT NULL,
  `send_time` time NOT NULL,
  PRIMARY KEY (`id_try`),
  KEY `try_student` (`student_id`),
  KEY `try_homework` (`homework_id`),
  CONSTRAINT `try_homework` FOREIGN KEY (`homework_id`) REFERENCES `Homework` (`id_homework`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `try_student` FOREIGN KEY (`student_id`) REFERENCES `Student` (`id_student`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Homework_Try
--



--
-- start  table dump : Module
--

CREATE TABLE IF NOT EXISTS `Module` (
  `id_module` int NOT NULL AUTO_INCREMENT,
  `number` tinyint NOT NULL,
  `cource_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id_module`),
  KEY `module_cource` (`cource_id`),
  CONSTRAINT `module_cource` FOREIGN KEY (`cource_id`) REFERENCES `Cource` (`id_cource`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Module
--



--
-- start  table dump : Region
--

CREATE TABLE IF NOT EXISTS `Region` (
  `id_region` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_region`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Region
--


--
-- Inserts of Region
--


/*!40000 ALTER TABLE `Region` DISABLE KEYS */;

--
-- start table insert : Region
--
INSERT INTO `Region`(`id_region`, `name`) VALUES 
(3, 'Онлайн 1'),
(2, 'Онлайн 2'),
(1, 'Онлайн 3');
--
-- end table insert : Region
--

/*!40000 ALTER TABLE `Region` ENABLE KEYS */;


--
-- start  table dump : Role
--

CREATE TABLE IF NOT EXISTS `Role` (
  `id_role` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Role
--


--
-- Inserts of Role
--


/*!40000 ALTER TABLE `Role` DISABLE KEYS */;

--
-- start table insert : Role
--
INSERT INTO `Role`(`id_role`, `name`) VALUES 
(3, 'Администратор'),
(1, 'Менеджер'),
(2, 'Преподаватель');
--
-- end table insert : Role
--

/*!40000 ALTER TABLE `Role` ENABLE KEYS */;


--
-- start  table dump : Sgroups
--

CREATE TABLE IF NOT EXISTS `Sgroups` (
  `id_group` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `module_num` int NOT NULL,
  `cource_id` int NOT NULL,
  PRIMARY KEY (`id_group`),
  UNIQUE KEY `name` (`name`),
  KEY `group_cource` (`cource_id`),
  CONSTRAINT `group_cource` FOREIGN KEY (`cource_id`) REFERENCES `Cource` (`id_cource`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Sgroups
--



--
-- start  table dump : Student
--

CREATE TABLE IF NOT EXISTS `Student` (
  `id_student` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `second_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `student_email` varchar(150) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `group_id` int DEFAULT NULL,
  PRIMARY KEY (`id_student`),
  UNIQUE KEY `student_email` (`student_email`),
  KEY `Student_Group` (`group_id`),
  CONSTRAINT `Student_Group` FOREIGN KEY (`group_id`) REFERENCES `Sgroups` (`id_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : Student
--



--
-- start  view dump : fullappointment
--

CREATE OR REPLACE VIEW `fullappointment` AS select `appointment`.`id_appointment` AS `id_appointment`,concat(`sgroups`.`name`,' ',`sgroups`.`module_num`) AS `name`,`appointment`.`lesson` AS `lesson`,`appointment`.`hours` AS `hours`,`appointment`.`minutes` AS `minutes`,`appointment`.`day` AS `day`,`appointment`.`date` AS `date`,`appointment`.`max_users` AS `max_users`,`appointment`.`teacher_id` AS `teacher_id`,(select count(`appointment_students`.`student_id`) from `appointment_students` where (`appointment_students`.`appointment_id` = `appointment`.`id_appointment`)) AS `active_num`,concat(`employee`.`second_name`,' ',`employee`.`first_name`,' ',`employee`.`middle_name`) AS `employee_name`,`appointment`.`sgroup_id` AS `sgroup_id` from (((`appointment` join `employee` on((`employee`.`id_employee` = `appointment`.`teacher_id`))) join `region` on((`region`.`id_region` = `employee`.`region_id`))) join `sgroups` on((`sgroups`.`id_group` = `appointment`.`sgroup_id`)));



--
-- end  view dump : fullappointment
--


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
