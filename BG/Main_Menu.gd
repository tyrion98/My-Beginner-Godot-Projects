extends Control



# change to universe scene
func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Universe.tscn")



# exit game
func _on_Quit_pressed():
	get_tree().quit()
