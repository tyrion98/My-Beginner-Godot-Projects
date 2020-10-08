extends Node2D





# change to main menu screen
func _on_Main_Menu_pressed():
	get_tree().change_scene("res://Scenes/Main_Menu.tscn")


# close application
func _on_Exit_pressed():
	get_tree().quit()
