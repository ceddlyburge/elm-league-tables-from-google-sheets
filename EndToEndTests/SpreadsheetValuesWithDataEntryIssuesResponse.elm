module SpreadsheetValuesWithDataEntryIssuesResponse exposing (spreadsheetValuesWithDataEntryIssuesResponse)

import ApiResponseFragments exposing (..)

-- This is the based on the response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>
-- The first two rows should be parsed successfully, but with no goals
-- The last two rows should be parsed successfully, but without creating a Game. That is, they should be ignored.
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
      ]
    ]
  }"""