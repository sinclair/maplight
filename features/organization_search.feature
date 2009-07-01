Feature: Search for an Organization
  In order to identify an organization 
  As an software programmer
  I want to be able to search for an Organization

  Scenario: Successfully search for an Organization by name
    Given that I have registered and received a MapLight api key from maplight.org
    And that the MapLight module has been included
    And that my MapLight api key has been set
    When searching for all organizations with Glasgow in their name
    Then the result should contain at least one Organization


  Scenario: Unsuccessfully search for an Organization by name
    Given that I have registered and received a MapLight api key from maplight.org
    And that the MapLight module has been included
    And that my MapLight api key has been set
    When searching for all organizations with WasTalofka in their name
    Then the result should contain no Organization
    


