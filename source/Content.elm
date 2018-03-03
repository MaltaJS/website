module Content exposing (..)

{-| This module hosts the actual content of the page. Thus can be edited right here,
using Markdown.


# Definition

@docs Content


# Common Helpers

@docs aboutView, venueView, eventView

-}

import Html exposing (Html, h1, div, p, text)
import Html.Attributes exposing (class)
import Markdown
import Maybe.Extra as Mx
import String
import Shared exposing (..)


defaultClassesWith : List String -> String
defaultClassesWith customClasses =
    [ defaultClasses ]
        ++ customClasses
        |> String.join " "


defaultClasses =
    String.join " " [ "col-xs-12" ]


markDownWithDefault =
    Markdown.toHtml [ class defaultClasses ]



-- TODO: this list is holding a duplicated information (the presence or absence of a specific section) which is already known to the Main module.
-- Using the Model


navigation : Maybe Event -> List String
navigation event =
    let
        eventData =
            if Mx.isJust event then
                [ "schedule", "subscribe", "location" ]
            else
                []
    in
        "about" :: (eventData ++ [ "sponsor" ])


banner =
    { h2 = "Malta JS"
    , h3 = "Javascript community in Malta"
    , p = "talks - meetups - hackatons"
    }


footer =
    { left =
        { p = "Copyright Ⓒ MaltaJs 2017 All Rights Reserved" }
    }


sponsors : List SponsorType -> List Sponsor
sponsors whitelist =
    List.filter (\sponsor -> List.member sponsor.id whitelist)
        [ { id = GiG
          , website = "https://www.gaminginnovationgroup.com/"
          , logoSrc = "/images/companies/gig.jpg"
          , description =
                markDownWithDefault
                    """
### Gaming Innovation Group

Gaming Innovation Group is a rapidly growing technology business. The Group offers cutting-edge Cloud based services and Performance Marketing through its 3 B2B products. Owns 7 B2C gambling products, offering games from the best-of-breed suppliers across the online sports betting and casino industry.

        """
          }
        , { id = Evoke
          , website = "http://www.evokegaming.com/"
          , logoSrc = "/images/companies/evoke.png"
          , description =
                markDownWithDefault
                    """
### Evoke Gaming

Evoke Gaming Ltd is based in Malta, and is a regulated online gaming company, we have been offering a thrilling and enjoyable online gaming experience to millions through brands that include Redbet.com, Whitebet.com, Bertil.com, Vinnarum.com and Mamamiabingo.com.

The business remains true to its founding mission, to offer a fun and responsible gaming experience.

        """
          }
        , { id = Knipster
          , website = "https://meet.knipster.com/"
          , logoSrc = "/images/companies/knipster-logo.svg"
          , description =
                markDownWithDefault
                    """
### Knipster

Knipster Ltd is based in Malta.

        """
          }
        ]


organizers : List Organizer
organizers =
    [ Organizer "Andrei Toma" "andrei@maltajs.com"
    , Organizer "Bogdan Dumitru" "bogdan@maltajs.com"
    , Organizer "Pietro Grandi" "pietro@maltajs.com"
    , Organizer "Organization" "contact@maltajs.com"
    ]


mainEvent event =
    [ ExtendedSchedule "18:45" "19:45" event ]


preEvents =
    [ Schedule "18:00" "18.30" "WELCOME COFFEE & REGISTRATION"
    , Schedule "18.30" "18:45" "Welcome speech"
    ]


postEvents =
    [ Schedule "19:45" "21:00" "Networking" ]


{-| Renders the HTML for the About section: what is MaltaJS

    aboutView

-}
aboutView : Html a
aboutView =
    markDownWithDefault
        """
MaltaJS is the new front-end community in Malta: born in 2016 as internal guild at Betsson,
now it is open to all the developers on the island.

Our aim is to provide **a place to share knowledge and technologies**, through meetings and talks.

Do you think you have a good idea for a talk, hackathon, demo or peer-learning?

**Join us** [on Facebook](https://www.facebook.com/groups/941691142568690/) and be part of the community!
  """


{-| Renders the HTML for the Venue section: where there will be the event

    venueView

-}
formErrorView : Html a
formErrorView =
    markDownWithDefault
        """
Please fill in all the required field
  """
