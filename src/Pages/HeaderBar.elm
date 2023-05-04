module Pages.HeaderBar exposing (HeaderBar, PageHeader(..), SubHeaderBar)

import Pages.HeaderBarItem exposing (HeaderBarItem)


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
