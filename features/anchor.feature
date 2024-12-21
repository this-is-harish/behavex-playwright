Feature: Add a root anchor for your DMS context

  Background:
    Given user executes command to create new user with "correct" passphrase
    And user executes command to retrieve keys with "correct" passphrase for "valid" user

  Scenario: Verify if a user can be added to anchor context
    When user adds specific user to root dms context with correct key
    Then specified user is added root anchor

  Scenario: Verify if error message is displayed if user's key did is incorrect
    When user adds specific user to root dms context with incorrect key
    Then specified user is not added root anchor

  Scenario: Verify if a user can be given grant to context
    When user creates grant user context for valid expiry date
    Then user is granted access successfully

  Scenario: Verify if a user can be given grant to context with invalid expiry date (before passphrase)
    When user creates grant user context for invalid expiry date
    Then user is not granted access successfully

  Scenario: Verify revoke access from non-existent context
    Given DMS is installed
    When user revokes access from non-existent context
    Then command returns code 0

  Scenario: Verify if the root anchor is able to delegate access to user
    Given root anchor context is created
    When user executes command to delegate the access
    Then command is executed successfully

  Scenario: Verify if a non-root anchor is not able to delegate access to user
    Given dms is running
    When non-root user executes command to delegate the access
    Then user gets an error

