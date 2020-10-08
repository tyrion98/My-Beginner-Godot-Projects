extends KinematicBody2D

#motion var
var motion = Vector2.ZERO
const GRAVITY = 5
const JUMP_HEIGHT = 200

# call animation player
onready var sprite = $Sprite
onready var n = preload("res://Scenes/Transition.tscn")
onready var sound = $AudioStreamPlayer2D
# movement
func _physics_process(delta):
	
	# jump if click
	if Input.is_action_just_pressed("left_click"):
		motion.y -= JUMP_HEIGHT
		sprite.play("Jump")
		sound.play(0.0)
	else:
		sprite.play("Idle")
		#sound.stop()
		

	


	# gravity
	motion.y += GRAVITY
	
	# move and slide
	motion = move_and_slide(motion)


# bodies
func _on_Area2D_body_entered(body):
	if body.get_name() == 'Troll':
		get_tree().paused = true
		# get the screen
		var screen = get_parent().get_node("CanvasLayer/Control")
		screen.visible = true
		# set a timer
		yield(get_tree().create_timer(3.0) , "timeout")
		# do transition
		var new_ = n.instance()
		get_parent().add_child(new_)
		new_.get_node("ColorRect/AnimationPlayer").play("Fade")
		yield(get_tree().create_timer(1.0) , "timeout")
		get_tree().paused = false
		get_tree().change_scene("res://Scenes/Main_Menu.tscn")
		
