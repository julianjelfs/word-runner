module Styles exposing (..)

import Animation
import Color exposing (black, rgba, white)
import Debug exposing (log)
import Time exposing (millisecond)


type FadeType
    = FadeIn
    | FadeOut


zoom t o =
    let
        ang =
            Animation.turn t

        zero =
            Animation.turn 0
    in
        Animation.interrupt
            [ Animation.to
                [ Animation.rotate3d zero ang zero
                , Animation.opacity o
                ]
            ]


toCapture model =
    { model
        | captureStyle = (zoom 0 1 model.captureStyle)
        , runnerStyle = (zoom -0.5 0 model.runnerStyle)
    }


toRun model =
    { model
        | captureStyle = (zoom -0.5 0 model.captureStyle)
        , runnerStyle = (zoom 0 1 model.runnerStyle)
    }


buttonFade fadeType style updater =
    let
        ( bg, fg ) =
            case fadeType of
                FadeIn ->
                    ( (rgba 0 0 0 0.2), white ) |> (log "fadein")

                FadeOut ->
                    ( (rgba 0 0 0 0.1), black ) |> (log "fadeout")
    in
        (Animation.interrupt
            [ Animation.to
                [ Animation.backgroundColor bg
                  --, Animation.color fg
                ]
            ]
            style
        )
            |> updater


spring =
    Animation.spring
        { stiffness = 250
        , damping = 10
        }


easing =
    Animation.easing
        { duration = 250 * millisecond
        , ease = (\x -> x ^ 2)
        }


flat =
    Animation.turn 0.0


back =
    Animation.turn -0.5


type alias Model =
    { captureStyle : Animation.State
    , runnerStyle : Animation.State
    , startStyle : Animation.State
    , pauseStyle : Animation.State
    , resetStyle : Animation.State
    , goStyle : Animation.State
    }


buttonInit =
    Animation.styleWith
        easing
        [ Animation.backgroundColor (rgba 0 0 0 0.1)
          --, Animation.color (rgba 0 0 0 1)
        ]


initialModel =
    Model
        (Animation.styleWith
            easing
            [ Animation.rotate3d flat flat flat
            , Animation.opacity 1
            ]
        )
        (Animation.styleWith
            easing
            [ Animation.rotate3d flat back flat
            , Animation.opacity 0
            ]
        )
        buttonInit
        buttonInit
        buttonInit
        buttonInit


type Msg
    = Animate Animation.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Animate sub ->
            { model
                | captureStyle = Animation.update sub model.captureStyle
                , runnerStyle = Animation.update sub model.runnerStyle
                , startStyle = Animation.update sub model.startStyle
                , pauseStyle = Animation.update sub model.pauseStyle
                , resetStyle = Animation.update sub model.resetStyle
                , goStyle = Animation.update sub model.goStyle
            }


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate
        [ model.captureStyle
        , model.runnerStyle
        , model.goStyle
        , model.pauseStyle
        , model.resetStyle
        , model.startStyle
        ]
