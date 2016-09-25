module Types exposing (..)

type alias Model =
    { rawText : Maybe String
    , state: State
    }

type State =
    Capturing
    | Paused
    | Playing
    | Finished

type Msg =
    None
    | UpdateRawText String
    | SpeedRead

initialModel : Model
initialModel =
    Model Nothing Capturing
