package com.crowdfunding.crowdfunding.dao;

import java.util.ArrayList;
import java.util.List;

public class User {

  private int id;
  private String username;
  private String email;
  private String password;
  private String role; // New field for role (e.g. "admin", "user", etc.)
  private final List<Integer> contributions;

  public User() {
    contributions = new ArrayList<Integer>();
  }

  // Getters and Setters
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }

  public List<Integer> getContributions() {
    return contributions;
  }

  public void addContribution(int contribution) {
    contributions.add(contribution);
  }
}
