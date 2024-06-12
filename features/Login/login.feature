Feature: Test1

  Scenario: Test Login
    Given User enters login details
    When User clicks submit button
    Then Following error message is displayed: "The email or mobile number you entered isn’t connected to an account."

  @Invalid
    # this test will demonstrate to create/modify your test data based on the tags.. check environment.py
  Scenario: Test Login2
    Given User enters login details
    When User clicks submit button
    Then Following error message is displayed: "The email or mobile number you entered isn’t connected to an account."