module LeagueList.View exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import RemoteData exposing (WebData)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import ViewComponents exposing (backIcon, refreshIcon, loading)
import ErrorMessages exposing (httpErrorMessage, unexpectedNotAskedMessage)


view : WebData (List LeagueSummary) -> Html Msg
view response =
    Element.layout stylesheet <|         
        column Body [ width (percent 100), spacing 25, center ]
            [
                row 
                    Title 
                    [ width (percent 100), padding 25, verticalCenter, center ] 
                    [
                        row None [ center, spacing 25, width (percent 100)   ]
                        [
                            el Hidden [ ] backIcon
                            , el Title [ width fill, center ] (text "Leagues")
                            , el TitleButton [ class "refresh", onClick AllSheetSummaryRequest ] refreshIcon
                        ]
                    ]
                , maybeLeagueList response
            ]

maybeLeagueList : WebData (List LeagueSummary) -> Element Styles variation Msg
maybeLeagueList response =
    case response of
        RemoteData.NotAsked ->
            -- This situation occurs when going to the url for a league table. I'm not sure why this view is shown first, it looks from the model history as though it shouldn't be the case
            leagueListText "" --unexpectedNotAskedMessage

        RemoteData.Loading ->
            loading

        RemoteData.Success leagues ->
            leagueList leagues

        RemoteData.Failure error ->
            leagueListText <| httpErrorMessage error


leagueList: List LeagueSummary -> Element Styles variation Msg
leagueList leagueSummaries =
            column 
                None 
                [ 
                    width (percent 100)
                    , class "leagues"   
                ] 
                (List.map leagueTitle leagueSummaries)

leagueTitle : LeagueSummary -> Element Styles variation Msg
leagueTitle league =
    el 
        LeagueListLeagueTitle 
        [ 
            padding 10
            , spacing 7
            , width (percent 60)
            , class "league"
            , center
            , onClick <| IndividualSheetRequest league.title
        ] 
        (text league.title)

leagueListText: String -> Element Styles variation Msg
leagueListText string =
    el LeagueListText [] <| text string