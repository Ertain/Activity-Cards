Card Activities
===

This is a prototype for someone who needs to go through activity cards at various levels.  Originally designed to answer [this question](https://godotengine.org/qa/47715/is-godot-overkill-for-what-i-want-to-do) in the Godot Engine Q&A page.

![First screen](Screenshot1.png?raw=true)

![Second screen](Screenshot2.png?raw=true)

###Formatting of the JSON "deck" file

The JSON file which comprises the deck is formatted like this:

    {
      "boy" : {
        "1" : ["Some activity"],
        "2" : ["Another activity"]
      },
      "girl" : {
        "1" : ["Some activity"],
        "2" : ["More activities"]
      }
    }

There are two sections to the deck: one meant for boys, and one meant for girls. This is because the original poster wanted to have decks which could be split between boys and girls. The next element to the deck is the level. These levels _must_ be in ascending order, i.e. 1, 2, 3, and so forth. The purpose for this level, though, is unknown at this time, as the original poster did not describe the reason for the levels. In each level, there is an array which contains the actual text of the "card". This text describes some activity for the boy or girl to perform. Each piece of text is an element in the array. When the application is started, this array is suffled, again as per the requirements from the original poster.
