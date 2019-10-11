module Pages.HeaderBar exposing (..)

import Pages.HeaderBarItem exposing (..)


type PageHeader
    = SingleHeader HeaderBar
    | DoubleHeader HeaderBar SubHeaderBar


type alias HeaderBar =
    { leftItems : List HeaderBarItem
    , title : String
    , rightItems : List HeaderBarItem
    }


type alias SubHeaderBar =
    { title : String
    }
