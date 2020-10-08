extends Control


# set up the pause function
func _input(event):
	
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
	
# if button is pressed return to main menu
func _on_ExitButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainScreen.tscn")

