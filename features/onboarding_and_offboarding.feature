Feature: Onboarding and Offboarding

  @MANUAL @Smoke @Critical
  Scenario: Verify if the user is able to on board a device
    Given root contexts are created
    And dms is running
    When user executes command to onboard device
    Then device should be onboarded

  @MANUAL @Critical
  Scenario Outline: Verify if the user is not able to add more than machine's resource
    Given root contexts are created
    And dms is running
    When user executes command to onboard device with <component> limit exceeding
    Then device should not be onboarded

    Examples:
      | component |
      | CPU       |
      | GPU       |
      | Disk      |
      | RAM       |

  @MANUAL @Smoke @Critical
  Scenario: Verify if user is able to offboard device
    Given root contexts are created
    And dms is running
    And devices are on boarded
    When user executes command to offboard device
    Then device should be offboarded

  @MANUAL @Critical
  Scenario: Verify if the user is able to view the status of onboarded devices
    Given root contexts are created
    And dms is running
    And devices are on boarded
    When user executes command to check status of onboarded
    Then status of the onboarded device should be displayed

  @MANUAL @Critical
  Scenario: Verify if the user is able to view the status of resource usage
    Given root contexts are created
    And dms is running
    And devices are on boarded
    When user executes command to check status of allocated resources
    Then status of the allocated resources should be displayed

  @MANUAL
  Scenario: Verify that unauthorized users cannot onboard a device
    Given a DMS instance is running
    And an unauthorized user attempts to onboard a device
    When the user executes the onboarding command
    Then the system should reject the request with an authorization error

  @MANUAL
  Scenario: Verify the behavior when a tampered key is used to onboard
    Given a DMS instance is running
    When a user attempts to onboard a device with a tampered key
    Then the system should reject the request and log a security alert

  @MANUAL @Performance
  Scenario: Verify if multiple devices can be on boarded at the same time
    Given DMS is installed
    When multiple users try to share resource at the same time
    Then resources should be shared to decentralized network

  @MANUAL @CrossPlatform
  Scenario Outline: Verify if the resource can be shared from <os>
    Given DMS is installed in <os>
    When user shared resource from <os>
    Then resource is shared with decentralized network properly

    Examples:
      | os      |
      | Windows |
      | MacOS   |
      | Linux   |
