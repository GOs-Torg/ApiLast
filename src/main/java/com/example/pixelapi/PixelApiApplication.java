package com.example.pixelapi;

import com.example.pixelapi.controllers.DBController;
import com.example.pixelapi.security.Crypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.sql.SQLException;
import java.util.logging.Logger;

@SpringBootApplication
public class PixelApiApplication {
	public static void main(String[] args) {
		DBController controller = new DBController();
		controller.initDB();

		SpringApplication.run(PixelApiApplication.class, args);
	}

}
