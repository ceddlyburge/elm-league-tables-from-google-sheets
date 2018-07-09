module LeagueListView exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)
import Fuzz exposing (string)

import LeagueList.View exposing (view)
import Models.League exposing (League)
import Models.Config exposing (Config)
import Models.Model exposing (Model)

-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!

-- These are an option for end to end type tests. I think I am preferring the elm-spec ones at the moment, as they are slightly more end to end and they allow you to interact. But I'm keeping this here in case I want to come back to it later.

all : Test
all =
    fuzz string "Displays available leagues" <|
        \(leagueTitle) -> view ( Model ( Config "" ""  ) [ League leagueTitle ] )
            |> Query.fromHtml
            |> Query.has [ text leagueTitle ]
    
