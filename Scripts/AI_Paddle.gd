extends KinematicBody2D


# movement var
var movement = Vector2.ZERO
var _initial = Vector2.ZERO
#constant
export (int) var speed = 45



# ready
func _ready():
	_initial = self.position
# has to move on its on
func _physics_process(delta):
	# get the balls values
	var game_ball = get_parent().get_node("Ball")
	
	
	# distance between the ball and the paddle
	var distance_y = game_ball.position.y - self.position.y
	# move based on the balls y position values
	movement.y += distance_y * speed * delta
	movement = move_and_slide(movement * speed * delta)
