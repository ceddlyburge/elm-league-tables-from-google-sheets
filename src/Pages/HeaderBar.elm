module Pages.HeaderBar exposing (..)

import Pages.HeaderBarItem exposing (..)

type alias HeaderBar =
    {   leftItems: List HeaderBarItem
        , title: String
        , rightItems: List HeaderBarItem
    }


