module Main exposing (..)

import Platform.Sub
import String
import Html exposing (Html, div, img, h2, h3, h4, h6, span, section, text, p)
import Html.Attributes exposing (class, id, src)
import Content
import Shared exposing (..)
import HttpUtils exposing (registerMe, errorExtractor)
import View
import Header
import Form


-- PROGRAM


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( Shared.initialModel, Cmd.none )


initialView =
    view Shared.initialModel



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleNavigation show ->
            ( { model | showNavigation = show }, Cmd.none )

        FormMsg subMsg ->
            let
                ( updatedFormModel, widgetCmd ) =
                    Form.update subMsg model.formModel
            in
                ( { model | formModel = updatedFormModel }, Cmd.map FormMsg widgetCmd )

        Register ->
            ( { model | signed = True }, registerMe model )

        PostResult (Ok result) ->
            ( { model | registered = True }, Cmd.none )

        PostResult (Err httpError) ->
            let
                error =
                    errorExtractor httpError
            in
                ( { model | error = error }, Cmd.none )


simpleView : Model -> Html Msg
simpleView { nextEvent, showNavigation } =
    div [ id "container" ]
        [ View.header nextEvent showNavigation Nothing (\c -> ToggleNavigation (not c))
        , View.banner
        , View.about Content.aboutView
        , View.contacts Content.organizers
        , View.footer
        ]


view : Model -> Html Msg
view model =
    let
        toggleNavigation c =
            ToggleNavigation (not c)

        eventView =
            Maybe.map
                (\e ->
                    [ View.eventDescription
                        Content.preEvents
                        (Content.mainEvent e)
                        Content.postEvents
                    , View.registrationForm model
                    , View.map (View.Coordinates 15 35.8969459 14.4978039)
                    ]
                )
                model.nextEvent
                |> Maybe.withDefault []
    in
        [ View.header model.nextEvent model.showNavigation Nothing toggleNavigation
        , View.banner
        ]
            ++ eventView
            ++ [ View.about Content.aboutView
               , View.sponsor model.sponsors
               , View.contacts Content.organizers
               , View.footer
               ]
            |> div [ id "container" ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
