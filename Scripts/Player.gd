extends KinematicBody2D


# movement vars
var motion = Vector2.ZERO
const MAX_SPEED = 80
const ACCELERATION = 40
const FRICTION = 300
# is attacking var
var isAttacking = false

# enum for stats
enum {
	WALK,
	IDLE,
	ATTACK
	
}
var states
# children
onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var hitbox = $HitboxPivot/Hitbox/CollisionShape2D
onready var hitboxPosition = $HitboxPivot
onready var playerStats = $PlayerStats
#summon the death effect
onready var deathEffect = preload("res://Scenes/PlayerDeathEffect.tscn")

# default is in idle
func _ready():
	states = WALK
	animTree.active = true

func _physics_process(delta):
	
	# case 
	match states:
		WALK:
			walk(delta)
		ATTACK:
			attack()
	
	

func walk(delta):
	var input_vector = Vector2.ZERO
	# movement vars
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# normalized
	input_vector.normalized()
	
	
	# if the player is moving
	if input_vector != Vector2.ZERO:
		#set up blend positions
		animTree.set("parameters/Idle/blend_position", input_vector)
		animTree.set("parameters/Walk/blend_position", input_vector)
		animTree.set("parameters/Hit/blend_position", input_vector)
		animTree.set("parameters/Attack/blend_position", input_vector)
		animTree.set("parameters/Death/blend_position", input_vector)
		animState.travel("Walk")
		motion = motion.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animState.travel("Idle")
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
		
	move()
	# if attack
	if Input.is_action_just_pressed("attack"):
		states = ATTACK

	#input vector	
	if input_vector.x == 0:
		hitboxPosition.scale.x = 1	
	else:
		# positions
		hitboxPosition.scale.x = input_vector.x

		
		
func attack():
	motion = Vector2.ZERO
	hitbox.disabled = false
	isAttacking = true
	# play animation (DO THIS LATER
	animState.travel("Attack")
		
#move sprite/player
func move():
	# move
	motion = move_and_slide(motion)


# when attack finishes deactive the collision of hitbox
func attack_animation_finished():
	isAttacking = false
	hitbox.disabled = true
	states = WALK

# if enemy then player dies and resets the level
func _on_Hurtbox_area_entered(area):
	playerStats.health -=1


# when player runs out of health reload
func _on_PlayerStats_no_health():
	queue_free()
	var playerDeath = deathEffect.instance()
	get_parent().add_child(playerDeath)
	#queue_free()
	playerDeath.global_position = global_position

