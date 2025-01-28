module Window exposing (
    ModelWindow, 
    MsgWindow (..), 
    initWindow,
    updateWindow, 
    viewWindow,
    subscriptionsWindow)

import Browser.Events exposing (onMouseMove)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Browser.Events exposing (onClick)


type alias ModelWindow =
    { 
      message : String, 
      x : Int, 
      y : Int, 
      dragging : Bool,
      visible : Bool
    }

initWindow : Int -> Int -> ModelWindow
initWindow x y =
      { message = "Move the mouse pointer on the page"
        , x = x
        , y = y
        , dragging = False
        , visible = False
      }
type MsgWindow
  = Visible
  | Draggable
  | Position (Int, Int)

updateWindow : MsgWindow -> ModelWindow -> ModelWindow
updateWindow msg model =
    case msg of
        Position ( x, y ) ->
            if model.dragging then { model
                | message =
                    "You moved the mouse to page coordinates "
                        ++ String.fromInt x
                        ++ ", "
                        ++ String.fromInt y,
                 x = x,
                 y = (if y>20 then y else model.y)
              } else model
        Draggable -> 
            {model | dragging = not model.dragging}
        Visible ->
            {model | visible = not model.visible} 


viewWindow : ModelWindow -> List (Html MsgWindow) -> Html MsgWindow
viewWindow model content = if model.visible then (
    div []
        [ div [ style "position" "absolute"
               , style "left" (String.fromInt (model.x-150) ++ "px")
               , style "top" (String.fromInt (model.y-10) ++ "px")
               , style "width" "310px"
               , style "height" "310px"
               , style "background-color" "white"
               , style "display" "flex"
               , style "justify-content" "center"
               , style "align-items" "center"
               , style "z-index" "2"
               , style "border-radius" "10px"
               , style "box-shadow" "10px 10px 15px rgba(0, 0, 0, 0.5)"
               ]
        
            (( div [if model.dragging then (class "winborderDragging") else (class "winborder"), Html.Events.onClick Draggable] [
                button [Html.Events.onClick Visible, class "redbutton"] []
                ] )::content)
      
        ]
    ) else div [] []

--img [src "", width 300, height 300] []
subscriptionsWindow : ModelWindow -> Sub MsgWindow
subscriptionsWindow model =
    onMouseMove
        (Decode.map2 (\x y -> Position (x, y))
            (Decode.field "pageX" Decode.int)
            (Decode.field "pageY" Decode.int)
        )