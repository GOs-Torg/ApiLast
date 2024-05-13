INSERT IGNORE INTO `Region`(`id_region`, `name`) VALUES
                                              (3, 'Онлайн 1'),
                                              (2, 'Онлайн 2'),
                                              (1, 'Онлайн 3');
INSERT IGNORE INTO `Role`(`id_role`, `name`) VALUES
                                          (1, 'Менеджер'),
                                          (2, 'Преподаватель'),
                                          (3, 'Администратор');



INSERT IGNORE INTO `Employee`(`id_employee`, `first_name`, `second_name`, `middle_name`, `password`, `login`, `email`, `role_id`, `region_id`) VALUES
    (1, 'ADM', 'ADM', 'ADM', '$2a$10$8M3JyV5zQ7.mQJd8LVxA6u/AG2ok2lTpmFxws22N/.Ra0lrFUID52', 'lrXGYKpqAr2pfE9zpK1J8Q==:rKr5IMDF+0f48+c1CP/VNA==', 'ulFwKp+9EuvKvN3qLvzXsA==:REdYqQbWvFDawcg7qJVikw==', 3, 1);