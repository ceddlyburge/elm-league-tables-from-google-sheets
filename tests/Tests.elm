module Tests exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)

import MainFunctions exposing (..)
import Models.League exposing (League)
import Models.Config exposing (Config)
import Models.Model exposing (Model)

-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!

-- These are an option for end to end type tests. I think I am preferring the elm-spec ones at the moment, as they are slightly more end to end and they allow you to interact. But I'm keeping this here in case I want to come back to it later.

all : Test
all =
    describe "League Table"
        [test "Displays available leagues" <|
            \() -> MainFunctions.view ( Model ( Config "" ""  ) [ League "Regional Div 2" ] )
                |> Query.fromHtml
                |> Query.has [ text "Regional Div 2" ]
        ]
