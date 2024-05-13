--
-- Generated by mysql-backup4j
-- https://github.com/SeunMatt/mysql-backup4j
-- Date: 13-5-2024 18:47:59
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
-- Inserts of Appointment
--


/*!40000 ALTER TABLE `Appointment` DISABLE KEYS */;

--
-- start table insert : Appointment
--
INSERT INTO `Appointment`(`id_appointment`, `name`, `lesson`, `hours`, `minutes`, `day`, `date`, `max_users`, `teacher_id`, `sgroup_id`) VALUES 
(1, 'Группа Lol4k 128', 1, '11', '11', '1', '2024-04-08', 8, 1, 3),
(2, 'Индивидуальные Аппаев Али', 3, '14', '00', '5', '2024-04-12', 1, 1, 2),
(3, 'Группа Unity 128', 4, '13', '00', '2', '2024-04-30', 8, 1, 3),
(4, 'Группа Unity 128', 5, '13', '00', '2', '2024-05-07', 8, 1, 3),
(5, 'Группа Unity 128', 6, '13', '00', '2', '2024-05-14', 8, 1, 3),
(6, 'Группа Unity 128', 7, '13', '00', '2', '2024-05-21', 8, 1, 3),
(7, 'Группа Unity 128', 8, '13', '00', '2', '2024-05-28', 8, 1, 3),
(8, 'Группа Unity 128', 9, '13', '00', '2', '2024-06-04', 8, 1, 3),
(9, 'Группа Unity 128', 10, '13', '00', '2', '2024-06-11', 8, 1, 3),
(10, 'Группа Unity 128', 11, '13', '00', '2', '2024-06-18', 8, 1, 3),
(11, 'Группа Unity 128', 12, '13', '00', '2', '2024-06-25', 8, 1, 3);
--
-- end table insert : Appointment
--

/*!40000 ALTER TABLE `Appointment` ENABLE KEYS */;


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
-- Inserts of appointment_students
--


/*!40000 ALTER TABLE `appointment_students` DISABLE KEYS */;

--
-- start table insert : appointment_students
--
INSERT INTO `appointment_students`(`id_appointment_student`, `appointment_id`, `student_id`, `state`) VALUES 
(1, 1, 1, 'await'),
(2, 1, 2, 'await'),
(3, 3, 1, 'await'),
(4, 3, 2, 'await'),
(5, 4, 1, 'await'),
(6, 4, 2, 'await'),
(7, 5, 1, 'await'),
(8, 5, 2, 'await'),
(9, 6, 1, 'await'),
(10, 6, 2, 'await'),
(11, 7, 1, 'await'),
(12, 7, 2, 'await'),
(13, 8, 1, 'await'),
(14, 8, 2, 'await'),
(15, 9, 1, 'await'),
(16, 9, 2, 'await'),
(17, 10, 1, 'await'),
(18, 10, 2, 'await'),
(19, 11, 1, 'await'),
(20, 11, 2, 'await');
--
-- end table insert : appointment_students
--

/*!40000 ALTER TABLE `appointment_students` ENABLE KEYS */;


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
-- Inserts of Cource
--


/*!40000 ALTER TABLE `Cource` DISABLE KEYS */;

--
-- start table insert : Cource
--
INSERT INTO `Cource`(`id_cource`, `name`) VALUES 
(1, 'Roblox'),
(3, 'Scratch'),
(2, 'Unity');
--
-- end table insert : Cource
--

/*!40000 ALTER TABLE `Cource` ENABLE KEYS */;


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
(1, 'Павел', 'Нефедов', 'Вадимович', '$2a$10$8M3JyV5zQ7.mQJd8LVxA6uSwgm5/5JKwSOjtV7kD5nnDvCW2ye0OK', 'lIR02/88x7z7sT+IABaj1Q==:iIf3al87JL8Xq+Z7ysmIwA==', 'test@mail.com', 1, 1),
(2, 'Иванов', 'Иван', '-', '$2a$10$8M3JyV5zQ7.mQJd8LVxA6u/z94xdBNr1NKK/USZBcG9lM7k3TvLRu', 'oaOxv2kdFY4Mcqs6wJjhag==:B8SWf1zKUYjMEW2nbLG2ow==', 'jny/WaUTyUD5/nfhz5/FwK7rxcsVyZD3JcXqigprRls=:Qap8rsipo01iSNzbAO2Rzw==', 2, 3);
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
-- Inserts of Homework
--


/*!40000 ALTER TABLE `Homework` DISABLE KEYS */;

--
-- start table insert : Homework
--
INSERT INTO `Homework`(`id_homework`, `title`, `description`, `part`, `num`, `timespan`, `url`, `tegs`, `author_id`, `module_id`) VALUES 
(1, 'Знакомство с Unity', 'Вам необходимо ...', 1, 1, 50, 'nothing', '', 1, 2);
--
-- end table insert : Homework
--

/*!40000 ALTER TABLE `Homework` ENABLE KEYS */;


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
-- Inserts of Module
--


/*!40000 ALTER TABLE `Module` DISABLE KEYS */;

--
-- start table insert : Module
--
INSERT INTO `Module`(`id_module`, `number`, `cource_id`, `description`) VALUES 
(1, 1, 2, 'Что то в 2Д делаем'),
(2, 2, 2, 'Что то в 3Д'),
(3, 3, 2, 'Что то в 3Д, но круче');
--
-- end table insert : Module
--

/*!40000 ALTER TABLE `Module` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



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
(1, 'Менеджер'),
(2, 'Преподаватель');
--
-- end table insert : Role
--

/*!40000 ALTER TABLE `Role` ENABLE KEYS */;


--
-- start  table dump : role_seq
--

CREATE TABLE IF NOT EXISTS `role_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- end  table dump : role_seq
--


--
-- Inserts of role_seq
--


/*!40000 ALTER TABLE `role_seq` DISABLE KEYS */;

--
-- start table insert : role_seq
--
INSERT INTO `role_seq`(`next_val`) VALUES 
('1');
--
-- end table insert : role_seq
--

/*!40000 ALTER TABLE `role_seq` ENABLE KEYS */;


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
-- Inserts of Sgroups
--


/*!40000 ALTER TABLE `Sgroups` DISABLE KEYS */;

--
-- start table insert : Sgroups
--
INSERT INTO `Sgroups`(`id_group`, `name`, `module_num`, `cource_id`) VALUES 
(1, 'Индивидуальные Ромео Кефер', 1, 1),
(2, 'Индивидуальные Аппаев Али', 1, 2),
(3, 'Группа Unity 128', 2, 2);
--
-- end table insert : Sgroups
--

/*!40000 ALTER TABLE `Sgroups` ENABLE KEYS */;


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
-- Inserts of Student
--


/*!40000 ALTER TABLE `Student` DISABLE KEYS */;

--
-- start table insert : Student
--
INSERT INTO `Student`(`id_student`, `name`, `second_name`, `middle_name`, `student_email`, `phone_num`, `group_id`) VALUES 
(1, 'Ромео', 'Кефер', '-', 'romeorom@gmail.com', '', 3),
(2, 'Анри', 'Газарян', 'Арменович', 'zagrizulya@yandex.ru', '', 3),
(3, 'Денисовна', 'Мария', 'Путинцева', 'gusdimus1@gmail.com', '+79193885108', null);
--
-- end table insert : Student
--

/*!40000 ALTER TABLE `Student` ENABLE KEYS */;


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
