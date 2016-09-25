module State exposing (..)

import Types exposing (..)

update : Msg -> Model -> (Model,  Cmd Msg)
update msg model =
    case msg of
        None ->
            (model, Cmd.none)
        UpdateRawText txt ->
            ( { model | rawText = if txt == "" then Nothing else Just txt }, Cmd.none )
        SpeedRead ->
            ( { model | state = Paused }, Cmd.none )

