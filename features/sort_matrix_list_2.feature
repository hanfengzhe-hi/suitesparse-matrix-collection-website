Feature: display list of matrices sorted by attributes

  As a consumer
  So that I can better browse the collection
  I want to sort the collection by matrix properties

Background: matrices have been added to database

  Given the following matrices exist:
  | group  | name     | num_rows | num_cols  | author |
  | Boeing | airplane | 343      | 55        | John   |
  | HB     | test1    | 34       | 435       | Paul   |
  | Bai    | test2    | 44       | 23333     | Greg   |
  | Gset   | test3    | 46902    | 343       | Lass   |

  Scenario: sort matrices in increasing number of rows
    Given I am on the home page
    When I follow "Reset filters"
    And I click on the table header "Rows"
    Then I should see "HB" before "Bai"
    Then I should see "Boeing" before "Bai"
    Then I should see "Boeing" before "Gset"

  @javascript
  Scenario: sort matrices in decreasing number of rows using dropdown
    Given I am on the home page
    When I select "Rows (High to Low)" from "filterrific[sorted_by]"
    Then I should see "test3" before "airplane"
    Then I should see "airplane" before "test2"
    Then I should see "test2" before "test1"

  @javascript
  Scenario: sort matrices in increasing number of rows using dropdown
    Given I am on the home page
    When I select "Rows (Low to High)" from "filterrific[sorted_by]"
    Then I should see "test1" before "test2"
    Then I should see "test2" before "airplane"
    Then I should see "airplane" before "test3"

  @javascript
  Scenario: sort matrices in decreasing number of columns using dropdown
    Given I am on the home page
    When I select "Columns (High to Low)" from "filterrific[sorted_by]"
    Then I should see "test2" before "test1"
    Then I should see "test1" before "test3"
    Then I should see "test3" before "airplane"

  @javascript
  Scenario: sort matrices in increasing number of columns using dropdown
    Given I am on the home page
    When I select "Columns (Low to High)" from "filterrific[sorted_by]"
    Then I should see "airplane" before "test3"
    Then I should see "test3" before "test1"
    Then I should see "test1" before "test2"