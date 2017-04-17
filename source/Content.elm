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
import String
import Shared exposing (..)

defaultClassesWith : List String -> String
defaultClassesWith customClasses =
  [ defaultClasses ] ++ customClasses
  |> String.join " "

defaultClasses = String.join " " [ "col-xs-12" ]

markDownWithDefault = Markdown.toHtml [ class defaultClasses ]

navigation =
  { links =
    [ ("About") ]
    -- Schedule, Subscribe, Sponsor, Location
  }

banner =
  { h2 = "Malta JS"
  , h3 = "Javascript community in Malta"
  , p = "5th of APRIL | Royal Malta Yacht Club"
  }

footer =
  { left =
    { p = "Copyright Ⓒ MaltaJs 2017 All Rights Reserved" }
  }

sponsor =
  { website = ""
  , logoSrc = ""
  , description =
    markDownWithDefault
      """
      ##Gaming Innovation Group

    Gaming Innovation Group is a rapidly growing technology business. The Group offers cutting-edge Cloud based services and Performance Marketing through its 3 B2B products. Owns 7 B2C gambling products, offering games from the best-of-breed suppliers across the online sports betting and casino industry.

      """
  }

organizers : List Organizer
organizers =
  [ Organizer "Andrei Toma" "andrei@maltajs.com"
  , Organizer "Bogdan Dumitru" "bogdan@maltajs.com"
  , Organizer "Pietro Grandi" "pietro@maltajs.com"
  , Organizer "Organization" "contact@maltajs.com"
  ]


mainEvent =
  [
    ExtendedSchedule
      "18:45" "19:45"
      "An introduction to Progressive Web Apps"
      "Kevin Farrugia"
      """
      PWAs are web-based applications, accessible and discoverable through your browser as any ordinary web app; but also with the ability to be installed to your mobile’s home screen and enable native-like behavior, including the ability to work offline, be viewed in fullscreen and receive push notifications.
      """
      [ ("linkedin", "https://mt.linkedin.com/in/https://www.linkedin.com/in/kevin-farrugia-69ba8881/")
      , ("github", "https://github.com/kevinfarrugia")
      , ("site", "https://www.incredible-web.com/")
      ]
  ]

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

