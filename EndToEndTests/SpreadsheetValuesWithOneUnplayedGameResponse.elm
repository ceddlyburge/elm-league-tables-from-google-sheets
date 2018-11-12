module SpreadsheetValuesWithOneUnplayedGameResponse exposing (spreadsheetValuesWithOneUnplayedGameResponse)

import ApiResponseFragments exposing (..)

-- This is the based on the response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>
spreadsheetValuesWithOneUnplayedGameResponse: String
spreadsheetValuesWithOneUnplayedGameResponse =
  """{
    "range": "'Regional Div 1'!A1:Z1000",
    "majorDimension": "ROWS",
    "values": [
  """
  ++ completeHeaderRow ++
  """, [
        "Castle",
        "",
        "",
        "Meridian",
        "2018-06-04",
        "1, 1, 1",
        "",
        "2, 3",
        "4",
        "Good game"
      ]
    ]
  }"""