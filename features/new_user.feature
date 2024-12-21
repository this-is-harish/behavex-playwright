@UserCreation
Feature: User creation

  @Critical @Smoke @User
  Scenario: Verify if a new user can be created
    Given DMS is installed
    When user executes command to create new user with "correct" passphrase
    Then new user is created

  @Critical @User
  Scenario: Verify if a new user is not created if confirm passphrase is incorrect
    Given DMS is installed
    When user executes command to create new user with "incorrect" passphrase
    Then new user is not created

  @User
  Scenario: Verify if a new user is not created if the user name has invalid char
    Given DMS is installed
    When user executes command to create new invalid user with "correct" passphrase
    Then new user is not created

  @Critical @Smoke @DMS
  Scenario: Verify if a new DMS can be created
    Given DMS is installed
    When user executes command to create new DMS with "correct" passphrase
    Then new DMS is created

  @Critical @DMS
  Scenario: Verify if a new DMS is not created if confirm passphrase is incorrect
    Given DMS is installed
    When user executes command to create new DMS with "incorrect" passphrase
    Then new DMS is not created

  @DMS
  Scenario: Verify if a new DMS is not created if the DMS name has invalid char
    Given DMS is installed
    When user executes command to create new invalid DMS with "correct" passphrase
    Then new DMS is not created