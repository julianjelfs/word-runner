module Button exposing (root)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Animation

root clickFn disabledPredicate txt style =
    button
        ( Animation.render style
            ++ [ onClick clickFn
                , onMouseOver MouseOverButton
                , onMouseOut MouseOutButton
                , disabled disabledPredicate ] )
        [ text txt ]
