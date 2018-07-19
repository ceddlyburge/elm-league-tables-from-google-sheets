module LeagueListView exposing (multipleLeagues)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Fuzz exposing (list, string)
import LeagueList.View exposing (view)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.LeagueTable exposing (LeagueTable)
import Models.Config exposing (Config)
import Models.Model exposing (Model)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
            view (modelWithLeagues leagueTitles)
                |> Query.fromHtml
                |> Query.has (List.map text leagueTitles)


modelWithLeagues : List String -> Model
modelWithLeagues leagueTitles =
    Model (Config "" "") (List.map LeagueSummary leagueTitles) (LeagueTable "" [])
