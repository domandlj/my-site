module Counter exposing (
    CounterModel, 
    CounterMsg(..), 
    viewCounter, 
    updateCounter)

import Html.Events exposing (onClick)
import Html exposing (..)
import Html.Attributes exposing (..)

type alias CounterModel = Int 


type CounterMsg 
    = Increment 
    | Decrement

updateCounter : CounterMsg -> CounterModel -> CounterModel
updateCounter msg model =
    case msg of
      Increment ->
        model + 1

      Decrement ->
        model - 1

-- Use with Html.map Counter : Html CounterMsg -> Html Counter
viewCounter : CounterModel -> Html CounterMsg
viewCounter model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]