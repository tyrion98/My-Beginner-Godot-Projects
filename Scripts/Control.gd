extends Control


func _input(event):
	
	# check
	if event.is_action_pressed("pause"):
		var paused_state = not get_tree().paused 
		get_tree().paused = paused_state
		visible = paused_state
	
		
# return to main scene
func _on_Button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainScreen.tscn")
