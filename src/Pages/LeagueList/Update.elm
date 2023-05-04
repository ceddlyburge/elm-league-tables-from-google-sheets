module Pages.LeagueList.Update exposing (allSheetSummaryResponse, refreshLeagueList, showLeagueList)

import GoogleSheet.Api exposing (fetchLeagueSummaries)
import Models.LeagueSummary exposing (LeagueSummary)
import Models.Model exposing (Model)
import Models.Route as Route
import Msg exposing (Msg(..))
import RemoteData exposing (WebData)


showLeagueList : Model -> ( Model, Cmd Msg )
showLeagueList model =
    let
        modelWithRoute : Model
        modelWithRoute =
            { model | route = Route.LeagueList }
    in
    case model.leagueSummaries of
        RemoteData.Success _ ->
            ( modelWithRoute, Cmd.none )

        RemoteData.Loading ->
            ( modelWithRoute, Cmd.none )

        _ ->
            refreshLeagueList modelWithRoute


refreshLeagueList : Model -> ( Model, Cmd Msg )
refreshLeagueList model =
    ( { model | leagueSummaries = RemoteData.Loading }
    , fetchLeagueSummaries model.config AllSheetSummaryResponse
    )


allSheetSummaryResponse : Model -> WebData (List LeagueSummary) -> ( Model, Cmd Msg )
allSheetSummaryResponse model response =
    ( { model | leagueSummaries = response }, Cmd.none )
