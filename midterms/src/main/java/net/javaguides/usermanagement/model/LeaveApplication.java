package net.javaguides.usermanagement.model;

public class LeaveApplication {
    protected int id;
    protected String name;
    protected String leaveType;
    protected String status;

    public LeaveApplication() {
    }

    public LeaveApplication(String name, String leaveType, String status) {
        this.name = name;
        this.leaveType = leaveType;
        this.status = status;
    }

    public LeaveApplication(int id, String name, String leaveType, String status) {
        this.id = id;
        this.name = name;
        this.leaveType = leaveType;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
