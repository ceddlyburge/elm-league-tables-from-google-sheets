module SpreadsheetValuesOneResultThreeFixturesResponse exposing (spreadsheetValuesOneResultThreeFixturesResponse)


-- This is the based on the response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>
spreadsheetValuesOneResultThreeFixturesResponse: String
spreadsheetValuesOneResultThreeFixturesResponse =
  """{
    "range": "'Regional Div 1'!A1:Z1000",
    "majorDimension": "ROWS",
    "values": [
      [
        "Home Team",
        "Home Score",
        "Away Score",
        "Away Team",
        "Date Played"
      ],
      [
        "Blackwater",
        "",
        "",
        "Nomad"
      ],
      [
        "Castle",
        "2",
        "1",
        "Meridian",
        "2018-06-04 10:40"
      ],
      [
        "Blackwater",
        "3",
        "0",
        "Clapham",
        "2018-06-04 10:20"
      ],
      [
        "Battersea",
        "",
        "",
        "Clapham",
        "2018-06-03"
      ]
    ]
  }"""