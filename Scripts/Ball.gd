extends KinematicBody2D



# variables
export (int) var ball_speed = 2
var ball_initial_position = Vector2.ZERO
var direction = Vector2.RIGHT
var global_score = 0
# constants 
const MAX_BOUNCE_ANGLE = 0.75
const MAX_BALL_SPEED = 15000
const PADDLE_HEIGHT = 46





func _ready():
	ball_initial_position = self.position
	
	
	
# updates every frame
func _physics_process(delta):

	# check for collisions
	collision_checker()
	# move the ball defaulty to the right
	move_and_slide(direction * ball_speed * delta)
					
					
func collision_checker():
		# get the player and ai nodes
	var player_paddle = get_parent().get_node("Player_paddle")
	var AI_Paddle = get_parent().get_node("AI_Paddle")
	# check what the ball is colliding with
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.name == "Walls":
			direction.y = randf()*2.0 - 1
			direction = direction.normalized()
			
		# if colliding with the paddle
		elif collision.collider.name == "Player_paddle":
			if player_paddle != null:
				paddle_handler(player_paddle, -1)
				
		# if colliding with the paddle
		elif collision.collider.name == "AI_Paddle":
			if AI_Paddle != null:
				paddle_handler(AI_Paddle, 1)
				
		if ball_speed < MAX_BALL_SPEED:
			ball_speed *= 1.2
				

# handles paddle collisions
func paddle_handler(paddle, x_coord : int):
	if paddle != null:
		# determine hit
		var y_coord = hit(paddle.position)
		# calculate direction
		direction = Vector2(x_coord, y_coord)
		# normalize
		direction = direction.normalized()



# helps calculate hit 
func hit(paddle_position):
	# calculates angle if the hit
	return (self.position.y - paddle_position.y) / PADDLE_HEIGHT


# lost function
func lost(loser_msg : String):
	# update score
	score_updater(loser_msg)
	self.position = ball_initial_position
	# reset paddle positions
	get_parent().get_node("Player_paddle").position = get_parent().get_node("Player_paddle")._initial
	get_parent().get_node("AI_Paddle").position = get_parent().get_node("AI_Paddle")._initial
	# pause scene
	get_tree().paused = true
	# check for game over
	if global_score == 5:
		# show the game screen
		get_parent().get_node("GameScreen/Control").visible = true
	else:
		yield(get_tree().create_timer(3), "timeout")

		# unpause
		get_tree().paused = false 
		direction *= -1
	
func score_updater(value):
	# get labels
	var ai_label = get_parent().get_node("Points/Container/AI_SCORE")	
	var player_label = get_parent().get_node("Points/Container/PLAYER_SCORE")	
	# add to whichever one depending on who won
	if(value == "AI Lost!"):
		var score = int(player_label.text)
		score += 1
		global_score = score
		player_label.text = String(score)
	else:
		var score = int(ai_label.text)
		score += 1
		global_score = score
		ai_label.text = String(score)
	
# signal game over
# AI LOST
func _on_Lost_Area_body_entered(body):
	
	if(body.get_name() == "Ball"):
		lost("AI Lost!")



# player lost
func _on_Player_Lost_Area_body_entered(body):
	if(body.get_name() == "Ball"):
		lost("Player Lost!")

