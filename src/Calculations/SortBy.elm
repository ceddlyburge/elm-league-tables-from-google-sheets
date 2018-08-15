module Calculations.SortBy exposing (..)

type Direction
    = ASC
    | DESC


by : (a -> comparable) -> Direction -> (a -> a -> Order)
by toCmp direction a b =
    case ( compare (toCmp a) (toCmp b), direction ) of
        ( LT, ASC ) ->
            LT

        ( LT, DESC ) ->
            GT

        ( GT, ASC ) ->
            GT

        ( GT, DESC ) ->
            LT

        ( EQ, _ ) ->
            EQ


andThen : (a -> comparable) -> Direction -> (a -> a -> Order) -> (a -> a -> Order)
andThen toCmp direction primary a b =
    case primary a b of
        EQ ->
            by toCmp direction a b

        ineq ->
            ineq

