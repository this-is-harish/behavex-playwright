@KeyRetrieval
Feature: Keys retrieval

  Background:
    Given user executes command to create new user with "correct" passphrase

  @Critical @Smoke
  Scenario: Verify if the user is able to retrieve the DID keys of created user
    When user executes command to retrieve keys with "correct" passphrase for "valid" user
    Then keys for the specific user is retrieved

  @Critical
  Scenario: Verify if the user is not able to retrieve the DID keys if passphrase is incorrect
    When user executes command to retrieve keys with "incorrect" passphrase for "valid" user
    Then keys for the specific user is not retrieved

  Scenario: Verify if the error message is shown if user retrieves keys for non-existent user
    When user executes command to retrieve keys with "incorrect" passphrase for "invalid" user
    Then key not found error message is displayed