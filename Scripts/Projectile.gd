extends KinematicBody2D

const THROW_VELOCITY = Vector2(800, -400)

var velocity = Vector2.ZERO





func _ready():
	set_physics_process(false)
# load gravity from player

func _physics_process(delta):
	velocity.y += 1 * delta
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		on_impact(collision.normal)
		
		
func launch(direction):
	var temp = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)		
	scene.add_child(self)
	global_transform = temp
	velocity = THROW_VELOCITY * Vector2(direction, 1)
	set_physics_process(true)
	
	
	
func on_impact(normal : Vector2):
	velocity = velocity.bounce(normal)
	velocity  *= 0.5 + rand_range(-0.05,0.05)
