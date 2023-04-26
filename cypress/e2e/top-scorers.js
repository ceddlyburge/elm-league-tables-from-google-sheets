describe("The Top Scorers Page", function () {
  it("shows scorers in order of goal count, player name, team name", function () {
    cy.intercept(
      "GET",
      "/.netlify/functions/google-api?leagueTitle=Regional%20Div%201",
      { fixture: "two-results-two-fixtures.json" }
    );

    // I could visit the home here and then click on the link to get to the league table page
    // this would be a better end to end test, but risks repeating the navigating testing a
    // lot, and means I would have to set up another route
    // I think I'll test the navigation separately
    cy.visit("/top-scorers/Regional%20Div%201");

    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(1) .data-test-top-scorer-player-name"
    ).contains("Cedd");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(1) .data-test-top-scorer-team-name"
    ).contains("Castle");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(1) .data-test-top-scorer-goal-count"
    ).contains("2");

    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(2) .data-test-top-scorer-player-name"
    ).contains("Johnnie");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(2) .data-test-top-scorer-team-name"
    ).contains("Blackwater");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(2) .data-test-top-scorer-goal-count"
    ).contains("1");

    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(3) .data-test-top-scorer-player-name"
    ).contains("Lisa");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(3) .data-test-top-scorer-team-name"
    ).contains("Blackwater");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(3) .data-test-top-scorer-goal-count"
    ).contains("1");

    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(4) .data-test-top-scorer-player-name"
    ).contains("Will");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(4) .data-test-top-scorer-team-name"
    ).contains("Blackwater");
    cy.get(
      ".data-test-top-scorers .data-test-top-scorer:nth-Child(4) .data-test-top-scorer-goal-count"
    ).contains("1");
  });
});
