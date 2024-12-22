Feature: Nunet Run

  @NunetRun @Critical @Smoke
  Scenario: Verify if  the user is able to run nunet dms
    Given user executes command to create new DMS with "correct" passphrase
    When user enters command to run dms with correct passphrase
    Then dms is running on port 9999

  @MANUAL @Smoke
  Scenario: Verify if the user gets an error message if port 9999 is already in use
    Given port 9999 is already in use
    When user enters command to run dms
    Then user should get an error message stating 9999 is already in use

  @MANUAL
  Scenario: Verify the behavior when the network connection is lost
    Given a device is onboarded
    And resources are being actively used
    When the network connection to the provider is lost
    Then the consumer should be notified
    And the operation should pause until the connection is restored

  @MANUAL @Smoke @Critical
  Scenario: Verify if dms run command fails if passphrase is incorrect
    Given users are created
    When user enters command to run dms
    And enters incorrect passphrase
    Then user should get error message about incorrect passphrase

