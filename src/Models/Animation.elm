module Models.Animation exposing (..)

type Animation = 
    Inactive
    | SuccessfulFetch Int
    | FailedFetch Int

