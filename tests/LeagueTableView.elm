module LeagueTableView exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Html exposing (div, ul, li, text)
import Html.Attributes exposing (class)
import LeagueTable.View exposing (view)
import Models.Config exposing (Config)
import Models.Model exposing (Model)
import Models.Team exposing (Team)
import Models.LeagueTable exposing (LeagueTable)


-- also wants to show the league title


oneTeam : Test
oneTeam =
    test "Displays one team correctly" <|
        \_ ->
            view (modelWithTeams [ Team "Castle" 1 3 6 4 2 ])
                |> Query.fromHtml
                |> Query.find [ Test.Html.Selector.class "team" ]
                |> Query.contains
                    [ Html.div [ Html.Attributes.class "name" ] [ Html.text "Castle" ]
                    , Html.div [ Html.Attributes.class "points" ] [ Html.text "3" ]
                    , Html.div [ Html.Attributes.class "gamesPlayed" ] [ Html.text "1" ]
                    , Html.div [ Html.Attributes.class "goalsFor" ] [ Html.text "6" ]
                    , Html.div [ Html.Attributes.class "goalsAgainst" ] [ Html.text "4" ]
                    , Html.div [ Html.Attributes.class "goalDifference" ] [ Html.text "2" ]
                    ]


modelWithTeams : List Team -> Model
modelWithTeams teams =
    Model (Config "" "") [] (LeagueTable "" teams)
