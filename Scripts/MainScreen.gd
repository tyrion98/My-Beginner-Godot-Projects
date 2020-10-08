extends Control






# exit screen
func _on_ExitButton_pressed():
	get_tree().quit()


# enter game
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
