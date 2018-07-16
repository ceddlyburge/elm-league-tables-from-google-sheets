module LeagueListView exposing (multipleLeagues)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Fuzz exposing (list, string)
import LeagueList.View exposing (view)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Config exposing (Config)
import Models.Model exposing (LeagueListModel)


multipleLeagues : Test
multipleLeagues =
    fuzz (list string) "Displays multiple leagues correctly" <|
        \leagueTitles ->
            view (modelWithLeagues leagueTitles)
                |> Query.fromHtml
                |> Query.has (List.map text leagueTitles)


modelWithLeagues : List String -> LeagueListModel
modelWithLeagues leagueTitles =
    LeagueListModel (Config "" "") (List.map LeagueSummary leagueTitles)
