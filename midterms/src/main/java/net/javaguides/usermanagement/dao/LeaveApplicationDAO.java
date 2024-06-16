package net.javaguides.usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import net.javaguides.usermanagement.model.LeaveApplication;

public class LeaveApplicationDAO {
	private String jdbcURL = "jdbc:derby:C:\\Users\\asus\\MyDB;create=true";
	private String jdbcUsername = "admin";
	private String jdbcPassword = "12345";

    private static final String INSERT_LEAVE_SQL = "INSERT INTO leave_applications (name, leave_type, status) VALUES (?, ?, ?)";
    private static final String SELECT_LEAVE_BY_ID = "SELECT id, name, leave_type, status FROM leave_applications WHERE id = ?";
    private static final String SELECT_ALL_LEAVES = "SELECT * FROM leave_applications";
    private static final String DELETE_LEAVE_SQL = "DELETE FROM leave_applications WHERE id = ?";
    private static final String UPDATE_LEAVE_SQL = "UPDATE leave_applications SET name = ?, leave_type = ?, status = ? WHERE id = ?";

	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}


    public void insertLeave(LeaveApplication leave) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_LEAVE_SQL)) {
            preparedStatement.setString(1, leave.getName());
            preparedStatement.setString(2, leave.getLeaveType());
            preparedStatement.setString(3, leave.getStatus());
            preparedStatement.executeUpdate();
        }
    }

    public LeaveApplication selectLeave(int id) {
        LeaveApplication leave = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_LEAVE_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                String leaveType = rs.getString("leave_type");
                String status = rs.getString("status");
                leave = new LeaveApplication(id, name, leaveType, status);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return leave;
    }

    public List<LeaveApplication> selectAllLeaves() {
        List<LeaveApplication> leaves = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_LEAVES)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String leaveType = rs.getString("leave_type");
                String status = rs.getString("status");
                leaves.add(new LeaveApplication(id, name, leaveType, status));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return leaves;
    }

    public boolean deleteLeave(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_LEAVE_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateLeave(LeaveApplication leave) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_LEAVE_SQL)) {
            statement.setString(1, leave.getName());
            statement.setString(2, leave.getLeaveType());
            statement.setString(3, leave.getStatus());
            statement.setInt(4, leave.getId());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        ex.printStackTrace();
    }
}
