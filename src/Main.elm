module Main exposing(..)

import Html exposing (..)
import Html.App as Html
import View
import Types exposing (..)
import State
import Time exposing (Time, second)
import Animation exposing (px)
import Styles

init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

main =
    Html.program
        { init = init
        , update = State.update
        , view = View.root
        , subscriptions = subscriptions
        }

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ case model.state of
            Playing ->
                Time.every ((60 / (toFloat model.wpm)) * second) Tick
            _ -> Sub.none
        , Sub.map StylesMsg (Styles.subscriptions model.styles)
        ]
