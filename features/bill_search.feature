Feature: Bill Search
  In order to have access to data about Bills (Legislation)
  As a developer of applications
  I want to search for Bills
  
  Scenario: Successful Bill search
    Given that I have registered and received a MapLight api key from maplight.org
    And that the MapLight module has been included
    And that my MapLight api key has been set
    When searching for all bills with Water in their name
    Then the result should contain at least one LegislativeBill
  
  
  

  
