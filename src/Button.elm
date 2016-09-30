module Button exposing (root)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Animation

root clickFn disabledPredicate txt style updater =
    button
        ( Animation.render style
            ++ [ onClick clickFn
                , onMouseOver (MouseOverButton style updater )
                , onMouseOut (MouseOutButton style updater )
                , disabled disabledPredicate ] )
        [ text txt ]
