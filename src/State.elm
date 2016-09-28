module State exposing (..)

import String
import Types exposing (..)
import Debug exposing (log)

update : Msg -> Model -> (Model,  Cmd Msg)
update msg model =
    case msg of
        None ->
            (model, Cmd.none)

        Tick t ->
            let
                updated =
                    case model.words of
                        [] -> { model | state = Finished }
                        [x] -> { model | words = [] }
                        x::xs -> { model | words = xs }
            in
                (updated, Cmd.none)

        UpdateRawText txt ->
            ( { model | rawText = if txt == "" then Nothing else Just txt }, Cmd.none )

        Reset ->
            ( { model | words = []
               , state = Capturing }, Cmd.none )

        Start ->
            ( { model | state = Playing }, Cmd.none )

        UpdateWpm str ->
            ( { model | wpm = (Result.withDefault 200 (String.toInt str)) }, Cmd.none )

        Pause ->
            ( { model | state = Paused }, Cmd.none )

        SpeedRead ->
            let
                words =
                    case model.rawText of
                        Nothing -> []
                        Just txt ->
                            String.split " " txt
            in
            ( { model | state = Paused
              , words = words }, Cmd.none )

