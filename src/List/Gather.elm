module List.Gather exposing (..)

{-| Group equal elements together using a custom equality function. Elements will be
grouped in the same order as they appear in the original list. The same applies to
elements within each group.
gatherWith (==) [1,2,1,3,2]
--> [(1,[1]),(2,[2]),(3,[])]
-}

-- This is from List.Extra 8.0.0. I can't use this at the moment, as it targets elm 0.19 and
-- this project targets 0.18. After upgrading, remove this file.


gatherWith : (a -> a -> Bool) -> List a -> List ( a, List a )
gatherWith testFn list =
    let
        helper : List a -> List ( a, List a ) -> List ( a, List a )
        helper scattered gathered =
            case scattered of
                [] ->
                    List.reverse gathered

                toGather :: population ->
                    let
                        ( gathering, remaining ) =
                            List.partition (testFn toGather) population
                    in
                    helper remaining <| ( toGather, gathering ) :: gathered
    in
    helper list []
