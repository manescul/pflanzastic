module Pflanzastic exposing (..)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (Html)
import Url exposing (Url)


type alias Flags =
    {}


type alias Model =
    { name : String }


type Msg
    = NoOp


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        _ =
            Debug.log "url" url
    in
    ( Model "Start water plants", Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Pflanzastic"
    , body =
        [ Html.p [] [ Html.text "Pflanzastic" ]
        ]
    }


onUrlRequest : UrlRequest -> Msg
onUrlRequest urlRequest =
    NoOp


onUrlChange : Url -> Msg
onUrlChange url =
    NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        }
