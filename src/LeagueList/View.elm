module LeagueList.View exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import RemoteData exposing (WebData)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueSummary exposing (LeagueSummary)
import ViewComponents exposing (..)
import ErrorMessages exposing (httpErrorMessage, unexpectedNotAskedMessage)


view : WebData (List LeagueSummary) -> Device -> Html Msg
view response device =
    let
        gaps = gapsForDevice device
    in
        Element.layout (stylesheet device) <|         
            column Body [ width (percent 100), spacing gaps.big, center ]
                [
                    row 
                        Title 
                        [ width (percent 100), padding gaps.big, verticalCenter, center ] 
                        [
                            row None [ center, spacing gaps.big, width (percent 100)   ]
                            [
                                el Hidden [ ] backIcon
                                , el Title [ width fill, center ] (text "Leagues")
                                , el TitleButton [ class "refresh", onClick AllSheetSummaryRequest ] refreshIcon
                            ]
                        ]
                    , maybeLeagueList gaps response
                ]

maybeLeagueList : Gaps -> WebData (List LeagueSummary) -> Element Styles variation Msg
maybeLeagueList gaps response =
    case response of
        RemoteData.NotAsked ->
            -- This situation occurs when going to the url for a league table. I'm not sure why this view is shown first, it looks from the model history as though it shouldn't be the case
            unhappyPathText "" --unexpectedNotAskedMessage

        RemoteData.Loading ->
            loading

        RemoteData.Success leagues ->
            leagueList gaps leagues

        RemoteData.Failure error ->
            unhappyPathText <| httpErrorMessage error


leagueList: Gaps -> List LeagueSummary -> Element Styles variation Msg
leagueList gaps leagueSummaries =
            column 
                None 
                [ 
                    width (percent 100)
                    , class "leagues"   
                ] 
                (List.map (leagueTitle gaps) leagueSummaries)

leagueTitle : Gaps -> LeagueSummary -> Element Styles variation Msg
leagueTitle gaps league =
    el 
        LeagueListLeagueTitle 
        [ 
            padding gaps.medium
            , spacing gaps.small
            , width (percent gaps.percentageWidthToUse)
            , class "league"
            , center
            , onClick <| IndividualSheetRequest league.title
        ] 
        (text league.title)
