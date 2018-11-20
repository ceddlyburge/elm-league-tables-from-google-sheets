module Pages.Page exposing (..)

import Element exposing (..)
import LeagueStyleElements exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)

type alias Page =
    {   headerBar: HeaderBar
        , body: Element Styles Variations Msg
    }


