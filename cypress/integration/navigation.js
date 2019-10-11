describe('Inter page navigation', function() {
  it('works as expected', function() {
	cy.server() 
    
	cy.route(
		'GET',      
		'/.netlify/functions/google-api',
		'fixture:league-list.json'
	  )
  
	cy.route(
	  'GET',      
	  '/.netlify/functions/google-api?leagueTitle=Regional Div 1',
	  'fixture:one-played-game.json'
	)

	// The 'contains' statements are chosen so that they will exist on the
	// page in question, and won't exist on all other pages. This is important
	// to make sure the test is testing the navigation properly, so bear this
	// in mind if making changes
	cy.visit('/') 
	cy.contains('League Tables')
	cy.get('.data-test-refresh').click()
	cy.contains('League Tables')

	cy.get('.data-test-league:nth-child(1)').click()
	cy.contains('Points')
	cy.get('.data-test-refresh').click()
	cy.contains('Points')

	cy.get('.data-test-results-fixtures').click()
	cy.contains('Results / Fixtures')
	cy.get('.data-test-refresh').click()
	cy.contains('Results / Fixtures')

	cy.get('.data-test-back').click()
	cy.get('.data-test-top-scorers').click()
	cy.contains('Top Scorers')
	cy.get('.data-test-refresh').click()
	cy.contains('Top Scorers')

	cy.get('.data-test-back').click()
	cy.contains('Points')

	cy.get('.data-test-back').click()
	cy.contains('League Tables')
  })
})