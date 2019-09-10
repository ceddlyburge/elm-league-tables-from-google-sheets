module Pages.HeaderBarItem exposing ( HeaderBarItem(..) )

import Msg exposing (..)

type HeaderBarItem =
    HeaderButtonSizedSpace
    | RefreshHeaderButton Msg
    | ResultsFixturesHeaderButton Msg
    | TopScorersHeaderButton Msg
    | BackHeaderButton Msg
    


