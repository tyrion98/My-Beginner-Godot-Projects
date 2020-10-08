extends Camera2D

onready var node_to_follow = get_node("../YSort/Player")
onready var node_next = get_node("../YSort/Enemy")
onready var info = load("res://Scripts/Player.gd")

func _process(delta):


	if node_to_follow == null:
		position = node_next.position
		zoom.x = 1
		zoom.y = 1
	else:
		
		position = node_to_follow.position
