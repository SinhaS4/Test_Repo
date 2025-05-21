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

