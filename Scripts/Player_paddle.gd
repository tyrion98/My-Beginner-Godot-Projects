extends KinematicBody2D



# movement var
var movement = Vector2.ZERO
var _initial = Vector2.ZERO
export (float) var speed = 50


# ready
func _ready():
	_initial = self.position
# move the paddle
func _physics_process(_delta):
	
	var input_vector = Vector2.ZERO
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# normalize
	input_vector = input_vector.normalized()

	# if player presses the button 
	# move the paddle
	if input_vector != Vector2.ZERO:
		# move and slide
		movement = move_and_slide(input_vector * speed, Vector2.DOWN)
		
