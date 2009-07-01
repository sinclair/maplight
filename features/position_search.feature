#http://maplight.org/services_open_api/map.organization_positions_v1.json?apikey=example&organization_id=22135
Feature: Organization's Bill Position search
  In order to provide a list of the positions associated with an organization
  As a civic software programmer
  I want to be search for the positions an organization has taken
  
  Scenario: Successful positions search
    Given an organization
    When calling the web service positions search api
    And I invoke the positions method
    Then the system should return all the positions for that organization
  
  
  

  
