module Pages.HeaderBarItem exposing ( HeaderBarItem(..) )

import Msg exposing (..)

type HeaderBarItem =
    HeaderButtonSizedSpace
    | RefreshHeaderButton Msg
    | ResultsFixturesHeaderButton Msg
    | BackHeaderButton Msg
    


