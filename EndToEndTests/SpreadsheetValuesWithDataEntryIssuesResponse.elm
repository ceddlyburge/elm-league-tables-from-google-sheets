module SpreadsheetValuesWithDataEntryIssuesResponse exposing (spreadsheetValuesWithDataEntryIssuesResponse)

import ApiResponseFragments exposing (..)

-- This is the based on the response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>
-- The first row should be parsed successfully
-- There is a row with only 3 cells, which isn't enough information so should be ignore
-- There is a row with enough cells, but a blank team name, this should also be ignored
spreadsheetValuesWithDataEntryIssuesResponse: String
spreadsheetValuesWithDataEntryIssuesResponse =
  """{
    "range": "'Regional Div 1'!A1:Z1000",
    "majorDimension": "ROWS",
    "values": [
  """
  ++ completeHeaderRow ++
  """, [
        "Castle",
        "1",
        "0",
        "Meridian"
      ],
      [
        "asd",
        "",
        ""
      ],
      [
      ],
      [
        "asdf",
        "3",
        "3",
        ""
      ]
    ]
  }"""