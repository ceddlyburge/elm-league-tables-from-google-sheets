describe('The Results / Fixtures Page', function() {
  it('shows days in descending order, and games within days in ascending order', function() {
	cy.server() 
    
	cy.route(
	  'GET',      
	  '/.netlify/functions/google-api?leagueTitle=Regional Div 1',
	  'fixture:one-result-three-fixtures.json'
	)

	// I could visit the home here and then click on the link to get to the league table page
	// this would be a better end to end test, but risks repeating the navigating testing a
	// lot, and means I would have to set up another route
	// I think I'll test the navigation separately
	cy.visit('/results-fixtures/Regional%20Div%201') 
	
	// these assert the order of the days
	cy.get('.data-test-dates .data-test-day:nth-Child(1)').should('have.class', 'data-test-date-2018-06-04')
	cy.get('.data-test-dates .data-test-day:nth-Child(2)').should('have.class', 'data-test-date-2018-06-03')
	cy.get('.data-test-dates .data-test-day:nth-Child(3)').should('have.class', 'data-test-date-unscheduled')
	
	// these assert the day titles / headers
	cy.get('.data-test-date-2018-06-04 .data-test-dayHeader').contains('June 4, 2018')
	cy.get('.data-test-date-2018-06-03 .data-test-dayHeader').contains('June 3, 2018')
	cy.get('.data-test-date-unscheduled .data-test-dayHeader').contains('Unscheduled')

	// these assert the fixtures / results for each day
	cy.get('.data-test-dates .data-test-date-2018-06-04 .data-test-game:nth-Child(1)').within(() => {
		cy.get('.data-test-homeTeamName').contains('Blackwater')
		cy.get('.data-test-homeTeamGoals').contains('3')
		cy.get('.data-test-awayTeamGoals').contains('0')
		cy.get('.data-test-awayTeamName').contains('Clapham')
	})

	cy.get('.data-test-dates .data-test-date-2018-06-04 .data-test-game:nth-Child(2)').within(() => {
		cy.get('.data-test-homeTeamName').contains('Castle')
		cy.get('.data-test-homeTeamGoals').contains('2')
		cy.get('.data-test-awayTeamGoals').contains('1')
		cy.get('.data-test-awayTeamName').contains('Meridian')
	})

	cy.get('.data-test-dates .data-test-date-2018-06-03 .data-test-game:nth-Child(1)').within(() => {
		cy.get('.data-test-homeTeamName').contains('Battersea')
		cy.get('.data-test-datePlayed').contains('11:20')
		cy.get('.data-test-awayTeamName').contains('Clapham')
	})

	cy.get('.data-test-dates .data-test-date-unscheduled .data-test-game:nth-Child(1)').within(() => {
		cy.get('.data-test-homeTeamName').contains('Blackwater')
		cy.get('.data-test-awayTeamName').contains('Nomad')
	})
  })

  it('shows scorers', function() {
	cy.server() 
    
	cy.route(
	  'GET',      
	  '/.netlify/functions/google-api?leagueTitle=Regional Div 1',
	  'fixture:one-result-three-fixtures.json'
	)

	cy.visit('/results-fixtures/Regional%20Div%201') 
	
	// only played games should have scorers, even if scorers are entered
	cy.get('.data-test-dates .data-test-date-2018-06-04 .data-test-game:nth-Child(1) .data-test-homeTeamGoalScorers').contains('Will, Johnnie, Lisa')

	cy.get('.data-test-dates .data-test-date-2018-06-04 .data-test-game:nth-Child(2)').within(() => {
		cy.get('.data-test-homeTeamGoalScorers').contains('Cedd, Cedd')
		cy.get('.data-test-awayTeamGoalScorers').contains('Chad')
	})
  })
  
})