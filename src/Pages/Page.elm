module Pages.Page exposing (..)

import Element exposing (..)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)


type alias Page =
    { header : PageHeader
    , body : Element Msg
    }
