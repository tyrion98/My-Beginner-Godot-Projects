extends Node2D




var timer = 25
signal point_trigger

# on ready var
onready var swords = preload("res://Scenes/Swords.tscn")
# load gameover
onready var game_over = $Camera2D/GAMEOVER/Control
func _ready():
	pass
	
func _process(delta):
	# if they press r then restart the level
	if Input.is_action_pressed("restart"):
		game_over.visible = false
		get_tree().change_scene("res://Scenes/Universe.tscn")
	
	timer+=1
	if timer >= 100:
		timer = 25
		var sword = swords.instance()
		add_child(sword)
		# set position at the swords position
		sword.position.x = 320
		yield(get_tree().create_timer(10.0), "timeout")
		sword.queue_free()



# go back to main menu
func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main_Menu.tscn")


func _on_DeadArea_body_entered(body):
	#unhide the gameover screen
	if body.get_name() == "Troll":
		game_over.visible = true
		get_tree().paused = true
