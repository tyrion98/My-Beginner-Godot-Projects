extends KinematicBody2D


# variables
var velocity = Vector2.ZERO
var UP = Vector2.UP
var speed = 200
var gravity = 4000
var JUMP_HEIGHT = -1000
# enable double jumping
var jump_count = 0
const MAX_JUMP = 2
#checks if the player is attacking
var isAttacking = false
# load animated sprite
onready var sprite = $AnimatedSprite
# attack area
onready var attackArea = $AttackArea/CollisionShape2D
# the attack areas actual node
onready var attackPosition = $AttackArea
# physics process
func _physics_process(delta):
	# movement function
	movement(delta)

# movement function
func movement(delta):
	
	# if on floor reset the jump count
	if is_on_floor(): jump_count = 0
	# movement
	if Input.is_action_pressed("ui_left") && isAttacking == false:
		velocity.x = -speed 
	elif Input.is_action_pressed("ui_right") && isAttacking == false:
		velocity.x = speed
	else:
		# is idle
		velocity.x = 0
	# attack code
	if Input.is_action_just_pressed("attack"):
		isAttacking = true
	# jump code
	if Input.is_action_just_pressed("ui_up") && isAttacking == false:
		if jump_count < MAX_JUMP:
			velocity.y = JUMP_HEIGHT
			jump_count += 1
			
		
	# call animations
	all_animations()
	# do it
	velocity.y += gravity * delta
	# move and slide
	velocity = move_and_slide(velocity,Vector2.UP * delta)
	
	
# func that does all the animations
func all_animations():
	# check if character in on the floor
	if is_on_floor():
		if velocity.x == 0:		
			#  IDLE
			if isAttacking == false:
				sprite.play("Idle")
		if velocity.x > 0:
			# WALK RIGHT
			sprite.play("Walk")
			sprite.flip_h = 0
			attackPosition.scale.x = 1
		elif velocity.x < 0:
			# WALK LEFT
			sprite.play("Walk")
			# flip
			sprite.flip_h = -1
			attackPosition.scale.x = -1
		elif isAttacking == true:
			# ATTACK
			sprite.play("Slash")
			# activate the attack area
			attackArea.disabled = false
	else:
		if velocity.y > 0:
			pass
			# sprite.play("Fall")
		# if i had a fall animation i would play it here (else)
		else:
			sprite.play("Jump")
				
			
	


# when attack finished
func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "Slash":
		# deactivate the area
		attackArea.disabled = true
		isAttacking = false
	# for jump anim
