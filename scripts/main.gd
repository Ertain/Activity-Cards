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

# When the "Boy" button is clicked, assign the gender and switch to the "cards" scene.
func _on_Boy_pressed():
    if $FileDialog.get_current_file() == "":
        _show_error("Please choose a file.")
        return
    global_data.gender = "boy"
    get_tree().change_scene("res://scenes/cards.tscn")

func _on_Girl_pressed():
    if $FileDialog.get_current_file() == "":
        _show_error("Please choose a file.")
        return
    global_data.gender = "girl"
    get_tree().change_scene("res://scenes/cards.tscn")

func _show_error(error_msg):
    $"Error dialog/Error msg".set_text(error_msg)
    $"Error dialog".show()

func _on_Open_file_pressed():
    $FileDialog.show()
