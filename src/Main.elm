module Main exposing(..)

import Html exposing (..)
import Html.App as Html
import View
import Types exposing (..)
import State

init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

--WIRING
main =
    Html.program
        { init = init
        , update = State.update
        , view = View.root
        , subscriptions = (\m -> Sub.none)
        }

