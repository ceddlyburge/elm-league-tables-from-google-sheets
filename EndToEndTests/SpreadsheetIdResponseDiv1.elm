module SpreadsheetIdResponseDiv1 exposing (spreadsheetIdResponseDiv1)


-- This is the response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE?key=<thekey>
spreadsheetIdResponseDiv1: String
spreadsheetIdResponseDiv1 =
  """{
  "spreadsheetId": "1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE",
  "properties": {
    "title": "Canoe Polo League Test Scores ",
    "locale": "en_US",
    "autoRecalc": "ON_CHANGE",
    "timeZone": "Europe/London",
    "defaultFormat": {
      "backgroundColor": {
        "red": 1,
        "green": 1,
        "blue": 1
      },
      "padding": {
        "top": 2,
        "right": 3,
        "bottom": 2,
        "left": 3
      },
      "verticalAlignment": "BOTTOM",
      "wrapStrategy": "OVERFLOW_CELL",
      "textFormat": {
        "foregroundColor": {},
        "fontFamily": "arial,sans,sans-serif",
        "fontSize": 10,
        "bold": false,
        "italic": false,
        "strikethrough": false,
        "underline": false
      }
    }
  },
  "sheets": [
    {
      "properties": {
        "sheetId": 1100994793,
        "title": "Regional Div 1",
        "index": 0,
        "sheetType": "GRID",
        "gridProperties": {
          "rowCount": 1000,
          "columnCount": 26
        }
      }
    }
  ],
  "spreadsheetUrl": "https://docs.google.com/spreadsheets/d/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/edit"
}"""