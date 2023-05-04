module Pages.Page exposing (Page)

import Element exposing (Element)
import Msg exposing (Msg)
import Pages.HeaderBar exposing (PageHeader)


type alias Page =
    { header : PageHeader
    , body : Element Msg
    }
