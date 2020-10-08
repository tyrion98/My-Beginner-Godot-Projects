extends KinematicBody2D

#motion
var motion = Vector2.ZERO
const FRICTION = 200
# enemy health var
export(int) var enemyHealth = 1

# childs
onready var animTree = $AnimationTree
onready var animPlayer = $AnimationPlayer
onready var animState = animTree.get("parameters/playback")
onready var hitbox = $Hitbox/CollisionShape2D
onready var stats = $Stats
# load
onready var EnemyDeathEffect = preload("res://Scenes/EnemyDeathEffect.tscn")

enum{
	IDLE,
	HIT
}
var states
# begin with idle
func _ready():
	animTree.active = true
	states = IDLE
# movement
func _physics_process(delta):
	
	
	# match
	match states:
		IDLE:
			IDLE(delta)
		HIT:
			hurt()
			
	
func IDLE(delta):
	var input_vector = Vector2.ZERO
	
	# normalize 
	input_vector.normalized()
	# if not moving
	if input_vector == Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", input_vector)
		animTree.set("parameters/Hit/blend_position", input_vector)
		#animTree.set("parameters/Death/blend_position", input_vector)
		animState.travel("Idle")
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#actually move
	motion = move_and_slide(motion)
# if player detected
func _on_DetectionZone_body_entered(body):
	# follow player
	# reactivate hitbox
	pass
	

#when they are out of detection zone disable the hitbox
func _on_DetectionZone_body_exited(body):
	pass
	
# when injured
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	states = HIT

# hurt animation
func hurt():
	animState.travel("Hit")		
	
# hurt finished
func hurt_finish():
	states = IDLE
# dead animation		
	
# disappears		
func death_finished():
	queue_free()
	

# when no health die
func _on_Stats_no_health():
	queue_free()
	# create instance
	var enemyDeathEffect = EnemyDeathEffect.instance()
	# add child
	get_parent().add_child(enemyDeathEffect)
	# set position
	enemyDeathEffect.global_position = global_position
