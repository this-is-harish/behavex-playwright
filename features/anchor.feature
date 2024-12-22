@Anchor
Feature: Add a root anchor for your DMS context

  @Critical @Anchor
  Scenario: Verify if a user can be added to anchor context
    Given user executes command to create new user with "correct" passphrase
    And user executes command to retrieve keys with "correct" passphrase for "valid" user
    When user adds specific user to root dms context with correct key
    Then specified user is added root anchor

  @Anchor
  Scenario: Verify if error message is displayed if user's key did is incorrect
    Given user executes command to create new user with "correct" passphrase
    And user executes command to retrieve keys with "correct" passphrase for "valid" user
    When user adds specific user to root dms context with incorrect key
    Then specified user is not added root anchor

  @Grant @Critical
  Scenario: Verify if a user can be given grant to context
    Given user executes command to create new user with "correct" passphrase
    And user executes command to retrieve keys with "correct" passphrase for "valid" user
    When user creates grant user context for valid expiry date
    Then user is granted access successfully

  @Grant @test
  Scenario: Verify if a user can be given grant to context with invalid expiry date (before passphrase)
    Given user executes command to create new user with "correct" passphrase
    And user executes command to retrieve keys with "correct" passphrase for "valid" user
    When user creates grant user context for invalid expiry date
    Then user is not granted access successfully

  @Revoke
  Scenario: Verify revoke access from non-existent context
    Given user executes command to create new user with "correct" passphrase
    And user executes command to retrieve keys with "correct" passphrase for "valid" user
    When user revokes access from non-existent context
    Then command returns code 0
