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

var boy_deck = global_data.boy_deck
var girl_deck = global_data.girl_deck
var level = global_data.level

func _ready():
    # Set the scene to an initial state. A card will be displayed, and will be
    # removed from the deck.
    # Since we only have boys or girls, we can split it like this.
    if global_data.gender == "boy":
        # Get a random card from the deck, then discard the card.
        var rand_number = randi() % boy_deck[level].size()
        $"Panel/Media container/Card text".text = boy_deck[level][ rand_number ]
        boy_deck[level].remove( rand_number )
        $"Panel/Media container/Level".set_text("Level %s" % level)
    else:
        # Get a random card from the deck, then discard the card.
        var rand_number = randi() % girl_deck[level].size()
        $"Panel/Media container/Card text".text = girl_deck[level][ rand_number ]
        girl_deck[level].remove( rand_number )
        $"Panel/Media container/Level".set_text("Level %s" % level)

# When the "change card" button is pressed, check to see what
# level we're at, along with any other cards we have. If we
# don't have any more cards, give an error.
func _on_Change_card_pressed():
    if global_data.gender == "boy":
        if boy_deck[level].size() > 1:
            var rand_number = randi() % boy_deck[level].size()
            $"Panel/Media container/Card text".text = boy_deck[level][ rand_number ]
            boy_deck[level].remove( rand_number )
        # One card left. Set that one, and then remove it.
        elif boy_deck[level].size() == 1:
            $"Panel/Media container/Card text".text = boy_deck[level][ 0 ]
            boy_deck[level].remove( 0 )
        if level < boy_deck.keys().size() and boy_deck[level].size() == 0:
            level += 1
            level = int( clamp(level, 1,  boy_deck.keys().size() ) )
        else:
            $"AcceptDialog/Error msg".show()
    else:
        if girl_deck[level].size() > 1:
            var rand_number = randi() % girl_deck[level].size()
            $"Panel/Media container/Card text".text = girl_deck[level][ rand_number ]
            girl_deck[level].remove( rand_number )
        # One card left. Set that one, and then remove it.
        elif girl_deck[level].size() == 1:
            $"Panel/Media container/Card text".text = girl_deck[level][ 0 ]
            girl_deck[level].remove( 0 )
        if level < girl_deck.keys().size() and girl_deck[level].size() == 0:
            level += 1
            level = int( clamp(level, 1,  girl_deck.keys().size() ) )
        else:
            $"AcceptDialog/Error msg".show()
    # Update the "Level" label, if necessary.
    $"Panel/Media container/Level".set_text("Level %s" % level)
