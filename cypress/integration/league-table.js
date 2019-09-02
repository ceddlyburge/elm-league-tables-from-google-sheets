describe('The League Table Page', function() {
  it('shows league table for one completely entered, played game', function() {
	cy.server() 
    
	cy.route(
	  'GET',      
	  '/.netlify/functions/google-api?leagueTitle=Regional Div 1',
	  'fixture:one-played-game.json'
	)

	// I could visit the home here and then click on the link to get to the league table page
	// this would be a better end to end test, but risks repeating the navigating testing a
	// lot, and means I would have to set up another route
	// I think I'll test the navigation separately
	cy.visit('/league/Regional%20Div%201') 
	
	cy.get('.data-test-teams .data-test-team:nth-Child(2)').within(() => {
			cy.get('.data-test-position').contains('1')
			cy.get('.data-test-name').contains('Castle')
			cy.get('.data-test-gamesPlayed').contains('1')
			cy.get('.data-test-won').contains('1')
			cy.get('.data-test-drawn').contains('0')
			cy.get('.data-test-lost').contains('0')
			cy.get('.data-test-points').contains('3')
			cy.get('.data-test-goalsFor').contains('3')
			cy.get('.data-test-goalsAgainst').contains('0')
			cy.get('.data-test-goalDifference').contains('3')
	})
	
	cy.get('.data-test-teams .data-test-team:nth-Child(3)').within(() => {
			cy.get('.data-test-position').contains('2')
			cy.get('.data-test-name').contains('Meridian')
			cy.get('.data-test-gamesPlayed').contains('1')
			cy.get('.data-test-won').contains('0')
			cy.get('.data-test-drawn').contains('0')
			cy.get('.data-test-lost').contains('1')
			cy.get('.data-test-points').contains('0')
			cy.get('.data-test-goalsFor').contains('0')
			cy.get('.data-test-goalsAgainst').contains('3')
			cy.get('.data-test-goalDifference').contains('-3')
	})
  })
})