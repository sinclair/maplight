Feature: Bill Position Search
  In order to inform people about the position Organizations have taken on a given Bill
  As a civic programmer, I need the maplight gem 
  to provide a bill position search

@billposition
  Scenario: Successful search for a Bill Position
  Given that I have registered and received a MapLight api key from maplight.org
  And that the MapLight module has been included
  And that my MapLight api key has been set
  And that I have a bill
  When getting the positions for the bill
  Then the result should contain a list of positions
  
  
  
