describe('The League Table Page', function() {
  it('shows league table for one completely entered, played game', function() {
	cy.server() 
    
	cy.route(
	  'GET',      
	  '/.netlify/functions/google-api?leagueTitle=Regional%20Div%201',
	  'fixture:one-played-game.json'
	)

	// I could visit the home here and then click on the link to get to the league table page
	// this would be a better end to end test, but risks repeating the navigating testing a
	// lot, and means I would have to set up another route
	// I think I'll test the navigation separately
	cy.visit('/league/Regional%20Div%201') 
	
	// need to work out cypress selectors at this point
	cy.contains('Regional Div 1')
	cy.contains('Regional Div 2')
  })
})