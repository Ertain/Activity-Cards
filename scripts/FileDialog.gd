extends FileDialog
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

# This script is for choosing a deck and checking to see whether it's syntactically correct.
var deck = {}
var foo
var okay: bool = false
var error_dialog

func _ready():
    error_dialog = $"../Error dialog"

# Signal for when the user selects and/or clicks the OK button.
func _on_FileDialog_file_selected(path):
    var file = File.new()
    # Check to see whether the file exists on the filesystem.
    if file.file_exists(path):
#    if ResourceLoader.exists(path):
        file.open(path, File.READ)
        # Read the file and check for any JSON formatting.
        var text = file.get_as_text()
        foo = JSON.parse(text)
        file.close()
        if foo.error == OK: # It's a JSON file.
            deck = foo.result
        else:
            # Not a JSON file. Print an error.
            error_dialog.dialog_text = "Not a JSON file: \"%s\". Please specify a valid JSON file that's correctly formatted." % path
            error_dialog.show()
            return
    else:
        # Don't really think I'll be encountering this one.
        error_dialog.dialog_text = "Error! File does not exist! %s" % path
        error_dialog.show()
        return

    # Check to see if the deck is a dictionary and whether it has the proper keys.
    if typeof(deck) == TYPE_DICTIONARY and deck.keys().size() > 0:
        for key in deck.keys():
            # Check for the "boy" and "girl" keys.
            if not key in ["boy", "girl"]:
                $"../Error dialog".dialog_text = "Deck is invalid: please make the first set of keys either \"boy\", \"girl\", or both."
                $"../Error dialog".show()
                break
            else:
                # Check for the proper level formatting in the JSON file.
                # Sadly, this is a weak way of checking for the proper formatting in the JSON file.
                for part in deck[key].keys():
                    if int(part) == 0:
                        $"../Error dialog".dialog_text = "Deck is invalid: second array of keys in the file aren't integers."
                        $"../Error dialog".show()
                        break
                    # Check to see whether the deck at a certain level has any cards in it.
                    elif deck[key][part].size() == 0:
                        $"../Error dialog".dialog_text = "The deck level %s has no cards in it." % part
                        $"...Error dialog".show()
                    else:
                        okay = true
        if okay:
            global_data.boy_deck = deck["boy"]
            global_data.girl_deck = deck["girl"]
    