extends Control




# change to main game scene
func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	

# exit window
func _on_Exit_pressed():
	get_tree().quit()
