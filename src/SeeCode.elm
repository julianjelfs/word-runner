module SeeCode exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

root: Html msg
root =
   div
         [ class "see-code" ]
         [ span []
             [ text "See the code "
             , a [ target "_blank", href "https://github.com/julianjelfs/word-runner"] [ text "here" ]
             ]
         ]
