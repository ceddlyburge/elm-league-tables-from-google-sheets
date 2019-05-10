module Pages.LeagueList.Update exposing (showLeagueList, refreshLeagueList,  allSheetSummaryResponse)

import Navigation exposing (newUrl)
import RemoteData exposing (WebData)

import Msg exposing (..)
import Models.Model exposing (Model)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Route as Route exposing (Route)
import Routing exposing (toUrl)
import GoogleSheet.Api exposing (fetchLeagueSummaries)

showLeagueList : Model -> ( Model, Cmd Msg )
showLeagueList model =
    let
        modelWithRoute = { model | route = Route.LeagueListRoute }
    in
        case model.leagues of
            RemoteData.Success _ ->
                (modelWithRoute, Cmd.none)
            RemoteData.Loading ->
                (modelWithRoute, Cmd.none)
            _ ->
                refreshLeagueList modelWithRoute


refreshLeagueList : Model -> ( Model, Cmd Msg )
refreshLeagueList model =
    ( { model | leagues = RemoteData.Loading}
      , fetchLeagueSummaries model.config AllSheetSummaryResponse )

allSheetSummaryResponse: Model -> WebData (List LeagueSummary) -> ( Model, Cmd Msg )
allSheetSummaryResponse model response = 
    ( { model | leagues = response }, newUrl <| toUrl <| model.route )

