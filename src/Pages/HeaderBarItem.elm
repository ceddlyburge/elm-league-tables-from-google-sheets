module Pages.HeaderBarItem exposing (HeaderBarItem(..))

import Msg exposing (Msg)


type HeaderBarItem
    = HeaderButtonSizedSpace
    | RefreshHeaderButton Msg
    | ResultsFixturesHeaderButton Msg
    | TopScorersHeaderButton Msg Bool
    | BackHeaderButton Msg
