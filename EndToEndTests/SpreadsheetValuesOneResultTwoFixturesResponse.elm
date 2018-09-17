module SpreadsheetValuesOneResultTwoFixturesResponse exposing (spreadsheetValuesOneResultTwoFixturesResponse)


-- This is the based on the response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>
spreadsheetValuesOneResultTwoFixturesResponse: String
spreadsheetValuesOneResultTwoFixturesResponse =
  """{
    "range": "'Regional Div 1'!A1:Z1000",
    "majorDimension": "ROWS",
    "values": [
      [
        "Home Team",
        "Home Score",
        "Away Score",
        "Away Team",
        "Date Played",
      ],
      [
        "Castle",
        "3",
        "0",
        "Meridian",
        "2018-06-04"
      ],
      [
        "Battersea",
        "",
        "",
        "Clapham",
        "2018-06-03"
      ],
      [
        "Blackwater",
        "",
        "",
        "Nomad"
      ]
    ]
  }"""