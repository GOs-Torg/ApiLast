
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


CREATE TABLE IF NOT EXISTS `Cource` (
  `id_cource` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_cource`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



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


INSERT INTO `Employee`(`id_employee`, `first_name`, `second_name`, `middle_name`, `password`, `login`, `email`, `role_id`, `region_id`) VALUES 
(1, 'Павел', 'Нефедов', 'Вадимович', '$2a$10$8M3JyV5zQ7.mQJd8LVxA6uSwgm5/5JKwSOjtV7kD5nnDvCW2ye0OK', 'lIR02/88x7z7sT+IABaj1Q==:iIf3al87JL8Xq+Z7ysmIwA==', 'test@mail.com', 1, 1),
(2, 'Иванов', 'Иван', '-', '$2a$10$8M3JyV5zQ7.mQJd8LVxA6u/z94xdBNr1NKK/USZBcG9lM7k3TvLRu', 'oaOxv2kdFY4Mcqs6wJjhag==:B8SWf1zKUYjMEW2nbLG2ow==', 'jny/WaUTyUD5/nfhz5/FwK7rxcsVyZD3JcXqigprRls=:Qap8rsipo01iSNzbAO2Rzw==', 2, 3);

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


CREATE TABLE IF NOT EXISTS `Module` (
  `id_module` int NOT NULL AUTO_INCREMENT,
  `number` tinyint NOT NULL,
  `cource_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id_module`),
  KEY `module_cource` (`cource_id`),
  CONSTRAINT `module_cource` FOREIGN KEY (`cource_id`) REFERENCES `Cource` (`id_cource`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `Region` (
  `id_region` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_region`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE IF NOT EXISTS `Role` (
  `id_role` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



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


CREATE OR REPLACE VIEW `fullappointment` AS select `appointment`.`id_appointment` AS `id_appointment`,concat(`sgroups`.`name`,' ',`sgroups`.`module_num`) AS `name`,`appointment`.`lesson` AS `lesson`,`appointment`.`hours` AS `hours`,`appointment`.`minutes` AS `minutes`,`appointment`.`day` AS `day`,`appointment`.`date` AS `date`,`appointment`.`max_users` AS `max_users`,`appointment`.`teacher_id` AS `teacher_id`,(select count(`appointment_students`.`student_id`) from `appointment_students` where (`appointment_students`.`appointment_id` = `appointment`.`id_appointment`)) AS `active_num`,concat(`employee`.`second_name`,' ',`employee`.`first_name`,' ',`employee`.`middle_name`) AS `employee_name`,`appointment`.`sgroup_id` AS `sgroup_id` from (((`appointment` join `employee` on((`employee`.`id_employee` = `appointment`.`teacher_id`))) join `region` on((`region`.`id_region` = `employee`.`region_id`))) join `sgroups` on((`sgroups`.`id_group` = `appointment`.`sgroup_id`)));
