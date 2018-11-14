module Pages.LeagueTable.View exposing (..)

import Html exposing (Html, span)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (Team)
import Pages.ViewComponents exposing (..)
import Pages.MaybeResponse exposing (..)


view : String -> WebData LeagueTable -> Device -> Html Msg
view leagueTitle response device =
    let
        gaps = gapsForDevice device
    in
        Element.layout (stylesheet device) <|         
            column Body [ width (percent 100), spacing gaps.big, center ]
            [
                row 
                    Title 
                    [ width (percent 100), padding gaps.big, verticalCenter ] 
                    [
                        row None [ center, spacing gaps.big, width (percent 100)   ]
                        [
                            el TitleButton [ onClick AllSheetSummaryRequest ] backIcon
                            , el TitleButton [ onClick <| IndividualSheetRequestForResultsFixtures leagueTitle ] resultsFixturesIcon
                            , el Title [ width fill, center ] (text <| Maybe.withDefault "" (decodeUri leagueTitle))
                            , el TitleButton [ onClick <| IndividualSheetRequest leagueTitle ] refreshIcon
                        ]
                    ]
                    , maybeResponse response (leagueTableElement device gaps)
                ]

leagueTableElement : Device -> Gaps -> LeagueTable -> Element Styles variation Msg
leagueTableElement device gaps leagueTable =
    column None [ class "teams" ]
    (
        [ headerRow device gaps ]
        ++ 
        (List.map (teamRow device gaps) leagueTable.teams)
    )

headerRow : Device -> Gaps -> Element Styles variation Msg
headerRow device gaps = 
    if device.width < 400 then
        compactHeaderRow device gaps 
    else
        fullHeaderRow device gaps 

fullHeaderRow : Device -> Gaps -> Element Styles variation Msg
fullHeaderRow device gaps = 
    row LeagueTableHeaderRow [ padding gaps.medium, spacing gaps.small, center ] 
    [
        paragraph None [ bigColumnWidth device ] [ text "Team" ]
        , el None [ width (px (smallColumnWidth device)) ] (text "Points")
        , el None [ width (px (smallColumnWidth device)) ] (text "Played")
        , el None [ width (px (mediumColumnWidth device)) ] (text "Goal\nDifference")
        , el None [ width (px (smallColumnWidth device)) ] (text "Goals\nFor")
        , el None [ width (px (smallColumnWidth device)) ] (text "Goals\nAgainst")
    ]

compactHeaderRow : Device -> Gaps -> Element Styles variation Msg
compactHeaderRow device gaps = 
    row LeagueTableHeaderRow [ padding gaps.medium, spacing gaps.small, center ] 
    [
        el None [ width (px (smallColumnWidth device)) ] (text "Points")
        , el None [ width (px (smallColumnWidth device)) ] (text "Played")
        , paragraph None [ width (px (mediumColumnWidth device)) ] [ text "Goal Difference" ]
        , paragraph None [ width (px (smallColumnWidth device)) ] [ text "Goals For" ]
        , paragraph None [ width (px (smallColumnWidth device)) ] [ text "Goals Against" ]
    ]

teamRow : Device -> Gaps -> Team -> Element Styles variation Msg
teamRow device gaps team = 
    if device.width < 400 then
        compactTeamRow device gaps team
    else
        fullTeamRow device gaps team

fullTeamRow : Device -> Gaps -> Team -> Element Styles variation Msg
fullTeamRow device gaps team =
    row LeagueTableTeamRow [ padding gaps.medium, spacing gaps.small, center, class "team" ] 
    [ 
        paragraph None [ bigColumnWidth device, class "name" ] [ text team.name ]
        , el None [ width (px (smallColumnWidth device)), class "points" ] (text (toString team.points) )
        , el None [ width (px (smallColumnWidth device)), class "gamesPlayed" ] (text (toString team.gamesPlayed) )
        , el None [ width (px (mediumColumnWidth device)), class "goalDifference" ] (text (toString team.goalDifference) )
        , el None [ width (px (smallColumnWidth device)), class "goalsFor" ] (text (toString team.goalsFor) )
        , el None [ width (px (smallColumnWidth device)), class "goalsAgainst" ] (text (toString team.goalsAgainst) )
    ]

compactTeamRow : Device -> Gaps -> Team -> Element Styles variation Msg
compactTeamRow device gaps team =
    row LeagueTableTeamRow [ padding gaps.medium, spacing gaps.small, center, class "team" ] 
    [ 
        column None []
        [
            paragraph None [ width fill, class "name" ] [text team.name]
            , row None []
                [
                    el None [ width (px (smallColumnWidth device)), class "points" ] (text (toString team.points) )
                    , el None [ width (px (smallColumnWidth device)), class "gamesPlayed" ] (text (toString team.gamesPlayed) )
                    , el None [ width (px (mediumColumnWidth device)), class "goalDifference" ] (text (toString team.goalDifference) )
                    , el None [ width (px (smallColumnWidth device)), class "goalsFor" ] (text (toString team.goalsFor) )
                    , el None [ width (px (smallColumnWidth device)), class "goalsAgainst" ] (text (toString team.goalsAgainst) )
                ]
        ]
    ]

smallColumnWidth: Device -> Float
smallColumnWidth device = 
    if device.phone then
        50
    else
        100

mediumColumnWidth: Device -> Float
mediumColumnWidth device = 
    if device.phone then
        70
    else
        120

bigColumnWidth: Device -> Element.Attribute variation msg
bigColumnWidth device = 
    if device.phone then
        width fill
    else
        width (px 200)