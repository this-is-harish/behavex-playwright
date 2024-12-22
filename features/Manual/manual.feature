Feature: Manual Feature
  # Manual Test cases can be added here to track your automation rate
  @MANUAL
  Scenario: Verify if user is able to Add the provide anchor to a personal context
    Given root anchor is configured
    And personal context is created
    When user adds provide anchor to a personal context
    Then personal context can be used to invoke public network authorization

  @MANUAL
  Scenario: Verify if non-root user is not able to Add the provide anchor to a personal context
    Given non-root anchor is configured
    And personal context is created
    When user adds provide anchor to a personal context
    Then user should get an error message about authorization

  @MANUAL
  Scenario Outline: Verify if the onboarded device cannot use the allocated <component> from local machine
    Given root contexts are created
    And dms is running
    And device is onboarded with 50% of <component>'s resource
    When user tries to use 100% <component>'s resource
    Then user should not be allowed to use the allocated resource
    Examples:
      | component |
      | CPU       |
      | GPU       |
      | Disk      |
      | RAM       |

  @MANUAL
  Scenario: Verify the behavior of unexpected shutdown of computer, when disk is used by DMS
    Given device is onboarded
    And resource of the device is being used
    When the provider machine is restarted
    # I'm not sure what's expected. So, I tried to give my logical response
    Then consumer should be notified about the resource failure
    And re-allocate the operation on a different available disk from decentralized network
    # Questions?
    # Does the NuNet DMS support automatic failover for resources like disk storage?
    # Is there any expectation for the consumer to handle resource failure (e.g., retrying, waiting)?

  @MANUAL
  Scenario: Verify the behavior of network disconnection of consumer
    Given multiple devices share resources
    When consumer has network downtime
    Then provider machines are unaffected

  @MANUAL @NoRequirement
  Scenario: Verify offboarding a device when resource is already in use
    Given a device is onboarded
    And resource is being used by DMS
    When user tries to offboard the device
    Then error/warning message should be displayed about resource being used

  @MANUAL @NoRequirement
  Scenario: Verify reducing the resource of machine when resource is already utilized
    Given a device is onboarded with 10GB of disk
    And 5GB of the disk is already in use
    When user updates the resource allocation to 3GB
    Then user should get an error message "Allocation update failed: current usage exceeds new allocation"
    And the resource allocation remains at 10GB

  @MANUAL
  Scenario: Verify if data is stored properly across multiple resources
    Given 2 devices are onboarded with 10GB disk space each
    When the DMS performs an operation requiring 15GB of storage
    Then the data should be distributed across the two devices
    And the data should be retrieved accurately and consistently

  @MANUAL
  Scenario: Verify if the root anchor is able to delegate access to user
    Given root anchor context is created
    When user executes command to delegate the access
    Then command is executed successfully

  @MANUAL
  Scenario: Verify if a non-root anchor is not able to delegate access to user
    Given dms is running
    When non-root user executes command to delegate the access
    Then user gets an error

  @MANUAL
  Scenario: Verify granted access is revoked after expiry date
    Given dms is created
    When user create a capability anchor for public behaviors
    Then capability has to be revoked after expiry date