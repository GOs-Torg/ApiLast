package com.example.pixelapi.controller;

import com.example.pixelapi.controllers.DBController;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import static org.mockito.Mockito.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import static org.junit.jupiter.api.Assertions.*;

public class DBControllerTest {

    @InjectMocks
    private DBController dbController;

    @Mock
    private Connection connection;

    @Mock
    private ResultSet resultSet;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetConnections_Success() throws SQLException {
        when(connection.isValid(1)).thenReturn(true);
        assertNotNull(dbController.getConnections());
    }

    @Test
    public void testGetConnections_Failure() throws SQLException {
        when(connection.isValid(1)).thenReturn(false);
        assertNull(dbController.getConnections());
    }

    @Test
    public void testRunQuery_SelectQuery() throws SQLException {
        String query = "SELECT * FROM Cource";
        when(connection.createStatement()).thenReturn(null);
        when(dbController.getConnections()).thenReturn(connection);
        when(connection.isValid(1)).thenReturn(true);
        when(connection.createStatement().executeQuery(query)).thenReturn(resultSet);
        assertNotNull(dbController.runQuery(query));
    }

    @Test
    public void testRunQuery_InsertQuery() throws SQLException {
        String query = "INSERT INTO Cource VALUES (1, 'test')";
        when(connection.createStatement()).thenReturn(null);
        when(dbController.getConnections()).thenReturn(connection);
        when(connection.isValid(1)).thenReturn(true);
        assertNull(dbController.runQuery(query));
    }

    // Add more tests for other scenarios like update and delete queries

    @Test
    public void testAddToTable_Success() {
        // Test your addToTable method with a successful scenario
    }

    @Test
    public void testAddToTable_Failure() {
        // Test your addToTable method with a failure scenario
    }

    // Add more tests for other methods like addToTableNoLogs, updateTable, deleteTable, etc.

}
