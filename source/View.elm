module View
    exposing
        ( Coordinates
        , about
        , banner
        , contacts
        , eventDescription
        , footer
        , header
        , map
        , registrationForm
        , sponsor
        )

import Html exposing (Html, a, button, div, img, hr, h2, h3, h1, h5, h6, span, section, text, p)
import Html.Attributes exposing (class, disabled, id, src, href, style, attribute)
import Html.Events exposing (onClick)
import Json.Encode as JSE
import Shared exposing (..)
import Content
import Header
import Form


twelveColumns =
    "col-xs-12 col-sm-12 col-md-12 col-lg-12"


sixColumns =
    "col-xs-12 col-sm-10 col-md-6 col-lg-4"


banner : Html msg
banner =
    let
        content =
            Content.banner
    in
        section [ id "home", class "row banner" ]
            [ h2 [] [ text content.h2 ]
            , h3 [] [ text content.h3 ]
            , p [] [ text content.p ]
            ]


footer : Html msg
footer =
    let
        content =
            Content.footer
    in
        Html.footer [ class "footer" ]
            [ div [ class twelveColumns ]
                [ div [ class "leftSide" ]
                    [ p [] [ text content.left.p ] ]
                , div [ class "rightSide" ] []
                ]
            ]


header : Bool -> Maybe Int -> (Bool -> msg) -> Html msg
header headerCollapsed active onNavigation =
    let
        content =
            Content.navigation

        brand =
            Header.buildItem "MaltaJS" [ "brand" ]

        logo =
            Header.buildLogo
                (img [ src "images/logo.jpg" ] [])
                [ "header-logo" ]

        links =
            List.map
                (\( title, url ) -> Header.buildActiveItem title url [])
                (List.map (\l -> ( l, "#" ++ l )) content.links)

        config : Header.Config msg
        config =
            Header.Config (Just logo) (Just brand) links (Just onNavigation)
    in
        Header.view config headerCollapsed active


makeSponsor content =
    div [ class "sponsor-block" ]
        [ div []
            [ a [ href content.website ] [ img [ src content.logoSrc, class "sponsors-logo" ] [] ] ]
        , div [ class twelveColumns ] [ content.description ]
        ]


sponsor : Html msg
sponsor =
    let
        list =
            List.map makeSponsor Content.sponsors

        children =
            [ h1 [] [ text "Thanks to..." ] ] ++ list
    in
        section [ id "sponsor", class "row sponsor" ]
            [ div [ class twelveColumns ] children ]


about : Html msg -> Html msg
about content =
    section [ id "about", class "row about" ]
        [ div [ class twelveColumns ]
            [ h1 [] [ text "About" ] ]
        , div [ class twelveColumns ]
            [ content ]
        ]


viewOrganizer : Organizer -> Html msg
viewOrganizer organizer =
    div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
        [ div [ class "organizer" ]
            [ div [ class "name" ]
                [ text organizer.name ]
            , div [ class "position" ]
                [ text "Event Organizer" ]
            , div []
                [ span [ class "glyphicon glyphicon-envelope" ]
                    []
                , p [ class "email" ]
                    [ text organizer.email ]
                ]
            ]
        ]


renderSchedule : Schedule -> Html msg
renderSchedule schedule =
    div [ class "row scheduleRow" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
            [ timeSpan schedule.start schedule.end
            , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
                [ text schedule.title ]
            ]
        ]


contacts : List Organizer -> Html msg
contacts organizers =
    section [ class "row contact", id "contact" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
            ([ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
                [ h1 []
                    [ text "Contact" ]
                ]
             ]
                ++ (List.map viewOrganizer organizers)
            )
        ]


timeSpan : String -> String -> Html msg
timeSpan start end =
    div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
        [ span []
            [ text start ]
        , span []
            [ text "-" ]
        , span []
            [ text end ]
        ]


renderExtendedSchedule : ExtendedSchedule -> Html msg
renderExtendedSchedule schedule =
    div [ class "row scheduleRow" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle" ]
            [ timeSpan schedule.start schedule.end
            , div [ class "col-xs-8 col-sm-10 col-md-10 col-lg-10 eventLine" ]
                [ hr [] [] ]
            ]
        , div [ class "col-xs-12 col-sm-9 col-md-9 col-lg-9 col-sm-offset-3 col-md-offset-3 col-lg-offset-3 eventSpeaker" ]
            ([ div
                -- speaker's image
                [ class "speakerImg", attribute "style" "background-image: url('/images/speakers/martin-nechvatal.jpg');" ]
                []
             , h5 []
                [ span []
                    [ text schedule.title ]
                , span [ class "compute" ]
                    [ text " with " ]
                , span []
                    [ text schedule.name ]
                ]
             , p []
                [ text schedule.description ]
             ]
                ++ (List.map (\( c, l ) -> a [ class c, href l ] []) schedule.links)
            )
        ]


eventDescription : List Schedule -> List ExtendedSchedule -> List Schedule -> Html msg
eventDescription pre main post =
    let
        prepend =
            List.map renderSchedule pre

        central =
            List.map renderExtendedSchedule main

        append =
            List.map renderSchedule post
    in
        section [ class "row schedule", id "schedule" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
                [ h1 []
                    [ text "Schedule" ]
                ]
            , div [] (prepend ++ central ++ append)
            ]


type alias Coordinates =
    { initialZoom : Int
    , latitude : Float
    , longitude : Float
    }


map : Coordinates -> Html msg
map coordinates =
    let
        json =
            JSE.object
                [ ( "initialZoom", JSE.int coordinates.initialZoom )
                , ( "mapCenterLat", JSE.float coordinates.latitude )
                , ( "mapCenterLng", JSE.float coordinates.longitude )
                ]
    in
        section [ id "location", class "row location" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
                [ h1 [] [ text "Location" ] ]
            , div
                [ id "map"
                , class "map-gic"
                , attribute "data-coordinates" (JSE.encode 0 json)
                ]
                []
            ]


alert : Model -> Html Msg
alert model =
    if (Form.isFormInvalid model.formModel) then
        div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
            [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
            , Content.formErrorView
            ]
    else if not ((String.isEmpty model.error)) then
        div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
            [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
            , p [] [ text model.error ]
            , p [ class "hide" ] [ text model.error ]
            ]
    else if (model.registered) then
        div [ class "alert alert-success small" ]
            [ span [ class "glyphicon glyphicon-info-sign" ] []
            , p [] [ text "You're registered for the event!" ]
            ]
    else
        Html.text ""


registrationForm : Model -> Html Msg
registrationForm model =
    let
        disableForm =
            False && (Form.isFormInvalid model.formModel) || model.registered
    in
        section [ id "subscribe", class "row subscribe" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
                [ h1 [] [ text "Subscribe" ], h6 [] [ text "Only 50 seats available." ] ]
            , mapMsgToForm model
            , div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter form-footer" ]
                [ alert model
                , button
                    [ onClick Register
                    , class "btn btn-default register"
                    , disabled disableForm
                    ]
                    [ text "Subscribe" ]
                ]
            ]
