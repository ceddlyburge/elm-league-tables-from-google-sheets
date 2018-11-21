module Pages.HeaderBar exposing (..)

import Pages.HeaderBarItem exposing (..)

type PageHeader =
    Single HeaderBar
    | Double HeaderBar SubHeaderBar

type alias HeaderBar =
    {   leftItems: List HeaderBarItem
        , title: String
        , rightItems: List HeaderBarItem
    }

type alias SubHeaderBar =
    {   title: String
    }

