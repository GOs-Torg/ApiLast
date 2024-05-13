package com.example.pixelapi.shedules;

import com.smattme.MysqlExportService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;

@Configuration
@EnableScheduling
@ConditionalOnProperty(name = "scheduler.enabled", matchIfMissing = true)
public class BackupSchedule {
    static final Logger LOGGER = Logger.getLogger(BackupSchedule.class.getName());
    static final String backupDirectory = "";
    private final int time = 1000*60*60*4;
    @Scheduled(fixedDelay = time)
    private void CreateBackup() throws IOException {
        String username = "root";
        String password = "";
        String databaseName = "PixelSchool";
        String backupPath = new File(".").getCanonicalPath()+"\\backups\\";

        try {
            Properties properties = new Properties();
            properties.setProperty(MysqlExportService.DB_NAME, databaseName);
            properties.setProperty(MysqlExportService.DB_USERNAME, username);
            properties.setProperty(MysqlExportService.DB_PASSWORD, password);
            properties.setProperty(MysqlExportService.PRESERVE_GENERATED_ZIP, "true");
            properties.setProperty(MysqlExportService.TEMP_DIR, new File("external").getPath());

            MysqlExportService mysqlExportService = new MysqlExportService(properties);
            mysqlExportService.export();
            backupPath += mysqlExportService.getSqlFileName();
            PrintWriter writer = new PrintWriter(backupPath, "utf-8");
            writer.println(mysqlExportService.getGeneratedSql());
            writer.close();
            mysqlExportService.clearTempFiles();
            LOGGER.info("Created File");
        } catch (IOException e) {
            LOGGER.warning("Created Error");
            e.printStackTrace();
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.warning("SQL Error");
            throw new RuntimeException(e);
        }
    }

}
