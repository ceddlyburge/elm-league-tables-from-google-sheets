module ResultsFixturesViewForUnplayedGameTest exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Time exposing (..)
import Time.Extra exposing (..)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import Models.Game exposing (vanillaGame)


oneUnplayedGame : Test
oneUnplayedGame =
    describe "Displays scheduled time for unplayed games"
        [ 
        test "time" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-datePlayed" ]
                |> Query.has [ Test.Html.Selector.text "10:20" ]
        ]

dayElement: Query.Single Msg
dayElement =
    html { vanillaGame | 
        datePlayed = Just (Time.Extra.Parts 2006 Mar 23 10 20 0 0 |> Time.Extra.partsToPosix utc)
        , homeTeamName = "Castle"
        , awayTeamName = "Meridian" }
    |> Query.find [ Test.Html.Selector.class "data-test-day" ]

