describe('The League List Page', function() {
  it('shows leagues, based on the tabs in the google sheet', function() {
	cy.server() 
    
	cy.route(
	  'GET',      
	  '/.netlify/functions/google-api',
	  'fixture:league-list.json'
	)

	cy.visit('/') 
	
	cy.contains('Regional Div 1')
	cy.contains('Regional Div 2')
  })
})