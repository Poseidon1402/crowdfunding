package com.crowdfunding.crowdfunding.dao;
import java.util.Date;

public class Project {
  private final int id;
  private final int userId;
  private final String name;
  private final Date deadline;
  private final boolean isApproved;
  private final int moneyNeeded;
  private final int moneyPerContributor;
  private final String status;
  private int contributions;

  // Constructor
  public Project(int id, int userId, String name, Date deadline, boolean isApproved, int moneyNeeded, int moneyPerContributor, String status) {
    this.id = id;
    this.userId = userId;
    this.name = name;
    this.deadline = deadline;
    this.isApproved = isApproved;
    this.moneyNeeded = moneyNeeded;
    this.moneyPerContributor = moneyPerContributor;
    this.status = status;
    this.contributions = 0;
  }

  // Getters...
  public int getId() {return id;}
  public int getUserId() { return userId; }
  public String getName() { return name; }
  public Date getDeadline() { return deadline; }
  public boolean isApproved() { return isApproved; }
  public int getMoneyNeeded() { return moneyNeeded; }
  public int getMoneyPerContributor() { return moneyPerContributor; }
  public int getContributions() { return contributions; }
  public String getStatus() { return status; }

  public void setContributions(int contributions) { this.contributions = contributions; }
}

