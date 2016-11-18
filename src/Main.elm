module Main exposing (..)

import Html exposing (..)
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


subscriptions : Model -> Sub Msg
subscriptions { state, wpm, styles } =
    Sub.batch
        [ case state of
            Playing ->
                Time.every ((60 / (toFloat wpm)) * second) Tick

            _ ->
                Sub.none
        , Sub.map StylesMsg (Styles.subscriptions styles)
        ]
