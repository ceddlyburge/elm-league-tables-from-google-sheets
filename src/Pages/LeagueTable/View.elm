module Pages.LeagueTable.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import RemoteData exposing (WebData)
import Http exposing (decodeUri)

import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Models.LeagueTable exposing (LeagueTable)
import Models.Team exposing (Team)
import Pages.Gaps exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.HeaderBar exposing (..) 
import Pages.HeaderBarItem exposing (..)

type alias LeagueTableHeaderText = 
    { position: String
        , team: String
        , played: String
        , won: String
        , drawn: String
        , lost: String
        , goalsFor: String
        , goalsAgainst: String
        , goalDifference: String
        , points: String
    }

page : String -> WebData LeagueTable -> Device -> Page
page leagueTitle response device =
    Page
        ( SingleHeader <| 
            HeaderBar 
                [ BackHeaderButton AllSheetSummaryRequest
                , ResultsFixturesHeaderButton <| IndividualSheetRequestForResultsFixtures leagueTitle ] 
                (Maybe.withDefault "" (decodeUri leagueTitle))
                [ RefreshHeaderButton <| IndividualSheetRequest leagueTitle ] )
        ( maybeResponse response (leagueTableElement device) )


leagueTableElement : Device -> LeagueTable -> Element Styles variation Msg
leagueTableElement device leagueTable =
    let
        gaps = gapsForDevice device
    in
        column None [ class "teams" ]
        (
            [ headerRow device gaps ]
            ++ 
            (List.map (teamRow device gaps) leagueTable.teams)
        )

headerRow : Device -> Gaps -> Element Styles variation Msg
headerRow device gaps = 
    let
        headers = headerText device
    in
        row LeagueTableHeaderRow [ padding gaps.medium, spacing gaps.small, center ] 
        [
            small device "" headers.position
            , big device "" headers.team
            , small device "" headers.played
            , small device "" headers.won
            , small device "" headers.drawn
            , small device "" headers.lost
            , smallWithWrap device "" headers.goalsFor
            , smallWithWrap device "" headers.goalsAgainst
            , mediumWithWrap device "" headers.goalDifference
            , small device "" headers.points
        ]



teamRow : Device -> Gaps -> Team -> Element Styles variation Msg
teamRow device gaps team = 
    row LeagueTableTeamRow [ padding gaps.medium, spacing gaps.small, center, class "team" ] 
    [ 
        small device "" "0"  -- team.position
        , bigWithWrap device "name" team.name
        , small device "gamesPlayed" (toString team.gamesPlayed)
        , small device "" "0" -- headers.won
        , small device "" "0" -- headers.drawn
        , small device "" "0" -- headers.lost
        , small device "goalsFor" (toString team.goalsFor)
        , small device "goalsAgainst" (toString team.goalsAgainst)
        , medium device "goalDifference" (toString team.goalDifference)
        , small device "points" (toString team.points)
    ]

small: Device -> String -> String -> Element Styles variation Msg
small  device cssClass cellContents = 
    el None [ smallWidth device, class cssClass ] (text cellContents)

smallWithWrap: Device -> String -> String -> Element Styles variation Msg
smallWithWrap  device cssClass cellContents = 
    paragraph None [ smallWidth device, class cssClass ] [text cellContents]

medium: Device -> String -> String -> Element Styles variation Msg
medium device cssClass cellContents = 
    el None [ mediumWidth device, class cssClass ] (text cellContents)

mediumWithWrap: Device -> String -> String -> Element Styles variation Msg
mediumWithWrap  device cssClass cellContents = 
    paragraph None [ mediumWidth device, class cssClass ] [text cellContents]

big: Device -> String -> String -> Element Styles variation Msg
big device cssClass cellContents = 
    el None [ bigWidth device, class cssClass ] (text cellContents)

bigWithWrap: Device -> String -> String -> Element Styles variation Msg
bigWithWrap  device cssClass cellContents = 
    paragraph None [ bigWidth device, class cssClass ] [text cellContents]

headerText: Device -> LeagueTableHeaderText
headerText device = 
    if device.width < 400 then
        LeagueTableHeaderText
            ""
            "Team"
            "P"
            "W"
            "D"
            "L"
            ""
            ""
            "GD"
            "Pts"
    else
        LeagueTableHeaderText
            ""
            "Team"
            "Played"
            "Won"
            "Drawn"
            "Lost"
            "Goals For"
            "Goals Against"
            "Goal Difference"
            "Points"

smallWidth: Device -> Element.Attribute variation msg
smallWidth device = 
    if device.phone then
        width (px 20)
    else
        width (px 80)

mediumWidth: Device -> Element.Attribute variation msg
mediumWidth device = 
    if device.phone then
        width (px 20)
    else
        width (px 120)

bigWidth: Device -> Element.Attribute variation msg
bigWidth device = 
    if device.phone then
        width fill
    else
        width (px 200)
