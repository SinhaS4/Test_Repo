#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
  Feature: Inventory API Test Scenarios

  Background:
    * url 'http://localhost:8080/api/inventory'  # Change to actual API base URL

  Scenario: Get all menu items
    Given path ''
    When method GET
    Then status 200
    And match response.length >= 9
    And match each response contains { id: '#string', name: '#string', price: '#string', image: '#string' }

  Scenario: Filter by id
    Given path 'filter'
    And param id = 3
    When method GET
    Then status 200
    And match response == { id: '3', name: 'Baked Rolls x 8', price: '$9', image: 'baked_rolls.png' }

  Scenario: Add item for non-existent id
    Given path 'add'
    And request { id: "10", name: "Hawaiian", image: "hawaiian.png", price: "$14" }
    When method POST
    Then status 200

  Scenario: Add item for existing id
    Given path 'add'
    And request { id: "10", name: "Hawaiian", image: "hawaiian.png", price: "$14" }
    When method POST
    Then status 400

  Scenario: Add item with missing information
    Given path 'add'
    And request { name: "Hawaiian", image: "hawaiian.png", price: "$14" }
    When method POST
    Then status 400
    And match response.message == "Not all requirements are met"

  Scenario: Validate recently added item is present
    Given path ''
    When method GET
    Then status 200
    And match response contains { id: "10", name: "Hawaiian", image: "hawaiian.png", price: "$14" }

