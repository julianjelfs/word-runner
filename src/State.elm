module State exposing (..)

import String
import Types exposing (..)

update : Msg -> Model -> (Model,  Cmd Msg)
update msg model =
    case msg of
        None ->
            (model, Cmd.none)

        UpdateRawText txt ->
            ( { model | rawText = if txt == "" then Nothing else Just txt }, Cmd.none )

        Reset ->
            ( { model | words = []
               , state = Capturing }, Cmd.none )

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

