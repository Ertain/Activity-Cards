# Copyright (C) 2019  Jason Anderson

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.
extends Control

var boy_deck
var girl_deck
var level

# Set the scene to an initial state. A card will be displayed, and will then be
# removed from the deck.
func _ready():
    boy_deck = global_data.boy_deck
    girl_deck = global_data.girl_deck
    level = global_data.level

    # Since we only have boys or girls, we can split it like this.
    if global_data.gender == "boy":
        # Get a random card from the deck, then discard the card.
        for tier in boy_deck.keys():
            boy_deck[ tier ].shuffle()
        $"Panel/Media container/ColorRect/Card text".text = boy_deck[ str(level) ].pop_front()
        $"Panel/Media container/Level".set_text("Level %s" % level)
    else:
        # Get a random card from the deck, then discard that card.
        for tier in girl_deck.keys():
            girl_deck[ tier ].shuffle()
        $"Panel/Media container/ColorRect/Card text".text = girl_deck[ str(level) ].pop_front()
        $"Panel/Media container/Level".set_text("Level %s" % level)

# Choose a random card from the deck. When the deck is out of cards, raise the level.
func _choose_card(deck, level):
    if not typeof(deck) == TYPE_DICTIONARY:
        # The deck isn't a dictionary. Show an error message and then return.
        $"AcceptDialog/Error msg".set_text("The deck is not a dictionary type!")
        $"AcceptDialog".show()
        return
    # When the deck has some cards, take one and assign it to the container's label.
    if deck[ str(level) ].size() > 0:
        $"Panel/Media container/ColorRect/Card text".text = deck[ str(level) ].pop_front()
    # When the deck is out of cards, increase the level. If the maximum level has been reached,
    # show a message telling the user about the situation.
    elif deck[ str(level) ].size() == 0 and level < deck.keys().size():
        level += 1
        level = int( clamp(level, 1,  deck.keys().size() ) )
    # The highest level has been reached.
    elif deck[ str(level) ].size() == 0 and level == deck.keys().size():
        $"AcceptDialog".show()
    
    # Assign the local variable "level" to the global version of the variable.
    self.level = level

func _on_Change_card_pressed():
    if global_data.gender == "boy":
        _choose_card(boy_deck, level)
    else:
        _choose_card(girl_deck, level)
    $"Panel/Media container/Level".set_text("Level %s" % level)
