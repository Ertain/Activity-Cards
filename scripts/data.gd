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
extends Node

# This is a singleton used to keep track of which deck is used, the level of the deck, and the decks themselves.

# This is for a user-generated deck.
var deck: Dictionary
var gender: String = ""
var girl_deck: Dictionary
var boy_deck: Dictionary
# For this to work, the number of levels must start at 1. That means you can't start at level 0
# and then go to level 1, then level 2, and so on.
var level: int = 1
# Each key of the dictionary corresponds to the level of the set of cards
# in the dictionary. So it sort of looks like this:
#    Level 1 -> [card 1, card 2, card 3]
#    Level 2 -> [card 1, card 2, card 3]
#    Level 3 -> [card 1, card 2, card 3]
# ...and so on.
#var boy_deck: Dictionary = {
#    1 : [
#            "Run around the room.", "Name your friends.", "Pet a dog."
#       ],
#    2 : [
#            "Help with the dishes.", "Water the plants.", "Tell a funny joke."
#    ]
#   }
#var girl_deck: Dictionary = {
#    1 : [
#        "Tell us about your day.", "Tell us about your family.", "Skip rope."
#    ],
#    2 : [
#        "Bake a cake.", "Lie on the floor.", "Hug the person you love the most."
#    ]
#   }