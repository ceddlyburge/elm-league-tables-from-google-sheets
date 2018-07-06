module Models.Model exposing (Model)

import Models.League exposing (League)
import Models.Config exposing (Config)

type alias Model =
    { config: Config,
    leagues: List League
    }


