module DecodeGoogleSheetToGameListTest exposing (decodeBlankTeamName, decodeJustEnoughColumnsSpreadsheetIdResponse, decodeNotEnoughColumnsSpreadsheetIdResponse, decodeSpreadsheetIdResponse, trimWhitespaceFromTeamNames)

import Expect
import GoogleSheet.DecodeGoogleSheetToGameList exposing (decodeSheetToLeagueGames)
import Helpers exposing (vanillaDecodedGame)
import Json.Decode exposing (decodeString)
import Models.DecodedGame exposing (DecodedGame)
import Models.LeagueGames exposing (LeagueGames)
import Test exposing (Test, test)
import Time exposing (Month(..), utc)
import Time.Extra exposing (Parts, partsToPosix)



-- I could probably fuzz test this by writing a custom fuzzer that created Game 's.
-- The values from these could be used to create the json string, and to assert against.
-- Seems like a faff though, I might come back to it later.


decodeSpreadsheetIdResponse : Test
decodeSpreadsheetIdResponse =
    test "Decodes all properties of Game" <|
        \() ->
            spreadsheetValuesResponse
                |> decodeString (decodeSheetToLeagueGames "Regional Div 1")
                |> Expect.equal
                    (Ok
                        (LeagueGames
                            "Regional Div 1"
                            [ DecodedGame
                                "Castle"
                                (Just 3)
                                "Meridian"
                                (Just 1)
                                (Just (partsToPosix utc (Parts 2018 Jun 4 0 0 0 0)))
                                [ "Cedd", "Lisa", "Barry" ]
                                [ "Nobody" ]
                                "Green 3, Yellow 5"
                                "Red 14"
                                "good game"
                            ]
                        )
                    )


decodeJustEnoughColumnsSpreadsheetIdResponse : Test
decodeJustEnoughColumnsSpreadsheetIdResponse =
    test "Decode games, even if supplementary information is missing" <|
        \() ->
            justEnoughColumnsSpreadsheetValuesResponse
                |> decodeString (decodeSheetToLeagueGames "Regional Div 1")
                |> Expect.equal
                    (Ok
                        (LeagueGames
                            "Regional Div 1"
                            [ { vanillaDecodedGame | homeTeamName = "Castle", awayTeamName = "Meridian" } ]
                        )
                    )


decodeNotEnoughColumnsSpreadsheetIdResponse : Test
decodeNotEnoughColumnsSpreadsheetIdResponse =
    test "Decoding ignores invalid games, instead of returning an error" <|
        \() ->
            notEnoughColumnsSpreadsheetValuesResponse
                |> decodeString (decodeSheetToLeagueGames "doesnt matter")
                |> isError
                |> Expect.equal False


decodeBlankTeamName : Test
decodeBlankTeamName =
    test "Decoding ignores games with blank team names, instead of returning an error or creating a game with blank team names" <|
        \() ->
            blankTeamNameSpreadsheetValuesResponse
                |> decodeString (decodeSheetToLeagueGames "Regional Div 1")
                |> Expect.equal (Ok (LeagueGames "Regional Div 1" []))


trimWhitespaceFromTeamNames : Test
trimWhitespaceFromTeamNames =
    test "Trims whitespace from team names" <|
        \() ->
            teamNamesWithWhitespaceSpreadsheetValuesResponse
                |> decodeString (decodeSheetToLeagueGames "Regional Div 1")
                |> Expect.equal
                    (Ok
                        (LeagueGames
                            "Regional Div 1"
                            [ { vanillaDecodedGame | homeTeamName = "Castle", awayTeamName = "Meridian" } ]
                        )
                    )


isError : Result error value -> Bool
isError result =
    case result of
        Err _ ->
            True

        Ok _ ->
            False



-- This is a cut down response from the test spreadsheet, at https://sheets.googleapis.com/v4/spreadsheets/1Ai9H6Pfe1LPsOcksN6EF03-z-gO1CkNp8P1Im37N3TE/values/Regional%20Div%201?key=<thekey>


spreadsheetValuesResponse : String
spreadsheetValuesResponse =
    createSpreadsheetValuesResponse
        """
    [
      "Castle",
      "3",
      "1",
      "Meridian",
      "2018-06-04T00:00:00",
      "Cedd, Lisa , Barry",
      "Nobody",
      "Green 3, Yellow 5",
      "Red 14",
      "good game"
    ]
    """


justEnoughColumnsSpreadsheetValuesResponse : String
justEnoughColumnsSpreadsheetValuesResponse =
    createSpreadsheetValuesResponse
        """
    [
      "Castle",
      "",
      "",
      "Meridian"
    ]
    """


notEnoughColumnsSpreadsheetValuesResponse : String
notEnoughColumnsSpreadsheetValuesResponse =
    createSpreadsheetValuesResponse
        """
    [
      "Castle",
      "",
      ""
    ]
    """


blankTeamNameSpreadsheetValuesResponse : String
blankTeamNameSpreadsheetValuesResponse =
    createSpreadsheetValuesResponse
        """
    [
      "Castle",
      "1",
      "3",
      ""
    ]
    """


teamNamesWithWhitespaceSpreadsheetValuesResponse : String
teamNamesWithWhitespaceSpreadsheetValuesResponse =
    createSpreadsheetValuesResponse
        """
    [
      "Castle ",
      "",
      "",
      " Meridian"
    ]
    """


createSpreadsheetValuesResponse : String -> String
createSpreadsheetValuesResponse rows =
    spreadsheetValuesHeader ++ rows ++ spreadsheetValuesFooter


spreadsheetValuesHeader : String
spreadsheetValuesHeader =
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
      "Home Scorers",
      "Away Scorers",
      "Home Cards",
      "Away Cards",
      "Notes"
    ],"""


spreadsheetValuesFooter : String
spreadsheetValuesFooter =
    """]
  }
  """
