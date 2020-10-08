extends Control





# change to the game scene
func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


# end game
func _on_ExitButton_pressed():
	get_tree().quit()
	
