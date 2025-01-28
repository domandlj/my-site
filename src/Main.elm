module Main exposing (..)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Html.Events exposing (onClick)
import Window exposing (
    ModelWindow, 
    MsgWindow (..), 
    initWindow,
    updateWindow, 
    viewWindow,
    subscriptionsWindow)


-- MAIN
main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }



-- MODEL

type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , window : ModelWindow
  , window2 : ModelWindow
  , windowMe : ModelWindow
  , windowBachelier : ModelWindow
  , windowChip8 : ModelWindow
  , windowMapaVegano : ModelWindow
  , windowLambda : ModelWindow
  }

-- Model modifiers
updateWindowModel : ModelWindow -> Model -> Model
updateWindowModel newWindow model =
    { model | window = newWindow }

updateWindow2 : ModelWindow -> Model -> Model
updateWindow2 newWindow model =
    { model | window2 = newWindow }

updateWindowMe : ModelWindow -> Model -> Model
updateWindowMe newWindow model =
    { model | windowMe = newWindow }

updateWindowBachelier : ModelWindow -> Model -> Model
updateWindowBachelier newWindow model =
    { model | windowBachelier = newWindow }

updateWindowChip8 : ModelWindow -> Model -> Model
updateWindowChip8 newWindow model =
    { model | windowChip8 = newWindow }

updateWindowMapaVegano : ModelWindow -> Model -> Model
updateWindowMapaVegano newWindow model =
    { model | windowMapaVegano = newWindow }

updateWindowLambda : ModelWindow -> Model -> Model
updateWindowLambda newWindow model =
    { model | windowLambda = newWindow }
    

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
  ( Model key url 
    (initWindow 100 200) 
    (initWindow 200 300) 
    (initWindow 200 300) 
    (initWindow 200 300)  
    (initWindow 200 300) 
    (initWindow 200 300) 
    (initWindow 200 300), Cmd.none )



-- UPDATE
type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | Window MsgWindow
  | Window2 MsgWindow
  | WindowMe MsgWindow
  | WindowBachelier MsgWindow
  | WindowChip8 MsgWindow
  | WindowMapaVegano MsgWindow
  | WindowLambda MsgWindow
  | OpenWin1
  | OpenWin2
  | OpenWinMe
  | OpenWinBachelier
  | OpenWinChip8
  | OpenWinMapaVegano
  | OpenWinLambda




openWin model modelWin updateModel = 
  let
       modelwindow = modelWin
       updatedWindow = { modelwindow | visible = True}
  in
    (updateModel updatedWindow model, Cmd.none)

displayWin st model modelWin updateModel =
  let
    updatedWindow = updateWindow st modelWin
  in
    (updateModel updatedWindow model, Cmd.none)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }
      , Cmd.none
      )
    

    Window st -> displayWin st model model.window updateWindowModel    
    Window2 st -> displayWin st model model.window2 updateWindow2   
    WindowMe st -> displayWin st model model.windowMe updateWindowMe 
    WindowBachelier st -> displayWin st model model.windowBachelier updateWindowBachelier 
    WindowChip8 st ->  displayWin st model model.windowChip8 updateWindowChip8 
    WindowMapaVegano st -> displayWin st model model.windowMapaVegano updateWindowMapaVegano 
    WindowLambda st -> displayWin st model model.windowLambda updateWindowLambda 


    OpenWin1 -> openWin model model.window updateWindowModel
    OpenWin2 -> openWin model model.window2 updateWindow2
    OpenWinMe -> openWin model model.windowMe updateWindowMe
    OpenWinBachelier -> openWin model model.windowBachelier updateWindowMe 
    OpenWinChip8 -> openWin model model.windowChip8 updateWindowChip8
    OpenWinMapaVegano -> openWin model model.windowMapaVegano updateWindowMapaVegano
    OpenWinLambda -> openWin model model.windowLambda updateWindowLambda
    

    
    

-- SUBSCRIPTIONS



subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ 
    Sub.map Window (subscriptionsWindow model.window)
  , Sub.map Window2 (subscriptionsWindow model.window2)
  , Sub.map WindowMe (subscriptionsWindow model.windowMe)
  , Sub.map WindowBachelier (subscriptionsWindow model.windowBachelier)
  , Sub.map WindowChip8 (subscriptionsWindow model.windowChip8)
  , Sub.map WindowMapaVegano (subscriptionsWindow model.windowMapaVegano)
  , Sub.map WindowLambda (subscriptionsWindow model.windowLambda)

  ]

-- VIEW




imgUrl : String
imgUrl = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg6xEm2xylTH_ZlbWFLvKi2qEfXuVwt8Q4TFTVfaZFcDpq8EYZV2rEwl1uuiVL5Bs0lnA0zncF383RpNaPaHj7C6XybElcRawGp9T8lODS6MB7t9B2jHyDpCGCYccU_cE9sHL_rdgZ5uYtN/s1600/q176invento10.jpg"

imgUrl2 : String
imgUrl2 = "https://phantom-elmundo.unidadeditorial.es/215c5d4a7810a8ae7cd275c297d0b2a6/crop/168x72/1032x648/resize/828/f/webp/assets/multimedia/imagenes/2021/08/26/16299752237253.jpg"

meUrl : String
meUrl = "data:image/jpeg;base64,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"


bachelierUrlIcon : String
bachelierUrlIcon = "https://raw.githubusercontent.com/domandlj/bachelier-front/refs/heads/main/public/logo512.png"



windowButton : String -> String -> String -> String -> Msg -> Html Msg
windowButton left top textIcon iconUrl msg = div [ style "position" "absolute"
               , style "left" left
               , style "top"  top 
      
               , style "display" "flex"
               , style "justify-content" "center"
               , style "align-items" "center"
               , style "z-index" "1"
               , style "color" "white"
               , style "background-color" "rgba(255, 255, 255, 0)"
               , style "flex-direction" "column"
               , style "border-radius" "0px"
               ]  [ button
            [ 
              onClick msg
            , class "iconbutton"
            ]
            [ img [ src iconUrl, style "width" "30px", style "height" "30px", style "margin" "5px" ] []
            , text textIcon
            ]
        ]

window1button : Html Msg
window1button = windowButton "10px" "50px" "btc" "https://cdn-icons-png.flaticon.com/512/5968/5968260.png" OpenWin1


window2button : Html Msg
window2button = windowButton "10px" "120px" "github" "https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_640.png" OpenWin2

window3button : Html Msg
window3button = windowButton "10px" "190px" "whoami" meUrl OpenWinMe

window4button : Html Msg
window4button = windowButton "10px" "260px" "bachelier" bachelierUrlIcon OpenWinBachelier

window5button : Html Msg
window5button = windowButton "10px" "330px" "CHIP-8" "https://chip-8.github.io/links/c8.png" OpenWinChip8

window6button : Html Msg
window6button = windowButton "10px" "400px" "Veganmap" "https://static.vecteezy.com/system/resources/thumbnails/016/314/482/small/map-pointer-art-icons-and-graphics-free-png.png" OpenWinMapaVegano

window7button : Html Msg
window7button = windowButton "10px" "470px" "Lambda" "https://f.hubspotusercontent10.net/hubfs/3042464/Imported_Blog_Media/2017-11-09-lambda-calculus-for-mortal-developers.png" OpenWinLambda


view : Model -> Browser.Document Msg
view model =
    let
      windowView = Html.map Window (
         viewWindow model.window [img [src imgUrl, width 230, height 230, style "border-radius" "10px"] []])
      


        
      windowView2 = Html.map Window2
        (viewWindow model.window2
            [ div 
                [ style "display" "flex"
                , style "justify-content" "center"
                , style "align-items" "center"
                , style "height" "100%"
                ]
                [ div 
                    [ style "text-align" "center" ]
                    [ img 
                        [ src "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh6FV0oqnoHbbOLwehIbyfN1-EeHTF6LBSLQ&s"
                        , width 100
                        , style "border-radius" "10px"
                        ] 
                        [] 
                    , p 
                        [ style "margin-top" "10px"
                        , style "margin-bottom" "10px"
                        , style "font-family" "'Lucida Grande', 'Helvetica Neue', Helvetica, Arial, sans-serif"
                        , style "font-size" "14px"
                        , style "color" "#333"
                        ]
                        [ text "WYSIWYG" ]
                    , a
                        [ href "https://github.com/domandlj"
                        , class "cool-link"
                        ]
                        [ text "GitHub" ]
                    ]
                ]
            ]
        )
      windowView3 =
          Html.map WindowMe
              (viewWindow model.windowMe
                  [ div [ style "text-align" "center" ]
                      [ img
                          [ src "static/me.jpg"
                          , width 230
                          , style "border-radius" "10px"
                          , style "margin-top" "20px"
                          ]
                          []
                      , p
                          [ style "font-size" "18px"
                          , style "color" "#333"
                          , style "font-family" "Arial, sans-serif"
                          ]
                          [ text "I'm Juan Domandl. Finishing a Computer Science degree at FAMAF-UNC, Argentina." ]
                      ]
                  ]
              )
      
      windowView4 = Html.map WindowBachelier
        (viewWindow model.windowBachelier
            [ div 
                [ style "display" "flex"
                , style "justify-content" "center"
                , style "align-items" "center"
                , style "height" "100%"
                ]
                [ div 
                    [ style "text-align" "center" ]
                    [ img 
                        [ src "https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2Fa47cb380-cc8d-410b-b16c-299cd15fa72d_2646x1744.jpeg"
                        , width 230
                        , style "border-radius" "10px"
                        ] 
                        [] 
                    , p 
                        [ style "margin-top" "10px"
                        , style "margin-bottom" "10px"
                        , style "font-family" "'Lucida Grande', 'Helvetica Neue', Helvetica, Arial, sans-serif"
                        , style "font-size" "14px"
                        , style "color" "#333"
                        ]
                        [ text "Little webapp to run python financial apps. Made with react.js, python-fastapi and mongodb." ]
                    , a
                        [ href "https://bachelier.site/"
                        , class "cool-link"
                        ]
                        [ text "Bachelier" ]
                    ]
                ]
            ]
        )
      
            
      windowView5 = Html.map WindowChip8
        (viewWindow model.windowChip8
            [ div 
                [ style "display" "flex"
                , style "justify-content" "center"
                , style "align-items" "center"
                , style "height" "100%"
                ]
                [ div 
                    [ style "text-align" "center" ]
                    [ img 
                        [ src "https://github.com/domandlj/CHIP8/raw/main/chip8.png"
                        , width 200
                        , style "border-radius" "10px"
                        ] 
                        [] 
                    , p 
                        [ style "margin-top" "10px"
                        , style "margin-bottom" "10px"
                        , style "font-family" "'Lucida Grande', 'Helvetica Neue', Helvetica, Arial, sans-serif"
                        , style "font-size" "14px"
                        , style "color" "#333"
                        ]
                        [ text "A fantasy 8bit computer emulator, I wrote it in C." ]
                    , a
                        [ href "https://github.com/domandlj/CHIP8"
                        , class "cool-link"
                        ]
                        [ text "Chip8" ]
                    ]
                ]
            ]
        )

      windowView6 = Html.map WindowMapaVegano
        (viewWindow model.windowMapaVegano
            [ div 
                [ style "display" "flex"
                , style "justify-content" "center"
                , style "align-items" "center"
                , style "height" "100%"
                ]
                [ div 
                    [ style "text-align" "center" ]
                    [ img 
                        [ src "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEURDnjn6etJXsyykMpBm2ELT9eEACe8iOPA&s"
                        , height 100
                        , style "border-radius" "10px"
                        ] 
                        [] 
                    , p 
                        [ style "margin-top" "10px"
                        , style "margin-bottom" "10px"
                        , style "font-family" "'Lucida Grande', 'Helvetica Neue', Helvetica, Arial, sans-serif"
                        , style "font-size" "14px"
                        , style "color" "#333"
                        ]
                        [ text "Proof of concept of a map of vegan places in Córdoba. Just React.js" ]
                    , a
                        [ href "https://domandlj.github.io/mapa-vegano/"
                        , class "cool-link"
                        ]
                        [ text "VeganMap" ]
                    ]
                ]
            ]
        )
        
      windowView7 = Html.map WindowLambda
          (viewWindow model.windowLambda
            [ div 
                [ style "display" "flex"
                , style "justify-content" "center"
                , style "align-items" "center"
                , style "height" "100%"
                ]
                [ div 
                    [ style "text-align" "center" ]
                    [ img 
                        [ src "https://i.redd.it/tq00sm5zamt71.jpg"
                        , height 100
                        , style "border-radius" "10px"
                        ] 
                        [] 
                    , p 
                        [ style "margin-top" "10px"
                        , style "margin-bottom" "10px"
                        , style "font-family" "'Lucida Grande', 'Helvetica Neue', Helvetica, Arial, sans-serif"
                        , style "font-size" "14px"
                        , style "color" "#333"
                        ]
                        [ text "Untyped lambda calculus interpreter, made with haskell using parser combinators" ]
                    , a
                        [ href "https://domandlj.github.io/mapa-vegano/"
                        , class "cool-link"
                        ]
                        [ text "Lambda" ]
                    ]
                ]
            ]
        )


    
      layout = 
          [ div [ class "container" ] [
            div [ class "layout" ]
                [ div [ class "sidebar" ]
                    [ 
                    a [ href "/" ] [ text "🍊" ]
                  , button [ onClick OpenWinMe 
                        , style "background" "none"
                        , style "border" "none"
                        , style "color" "inherit"
                        , style "font" "inherit"
                        , style "cursor" "pointer"
                        , style "padding" "0"
                        , style "text-decoration" "underline"]
                          [ text "whoami" ]
                    ]
                
                ], div [ class "page" ][]
                , windowView
                , windowView2
                , windowView3
                , windowView4
                , windowView5
                , windowView6
                , windowView7
                , window1button
                , window2button
                , window3button
                , window4button
                , window5button
                , window6button
                , window7button ]
          ]
    in
      { 
        title = "Juan Domandl Web" , 
        body = layout
      }