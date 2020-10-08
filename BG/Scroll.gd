extends Sprite


# speed of the scroll
export(int) var VELOCITY = -5.0

# image width
export (float) var g_texture_width = 0.0


# set text width to the textures horizontal size & scale
func _ready():
	g_texture_width = texture.get_size().x * scale.x
	
	
# process function
func _process(delta):
	position.x += VELOCITY
	attempt_reposition()
	
	
# repositions it after it passes through the screen
func attempt_reposition():
	if position.x < -g_texture_width:
		position.x += 2 * g_texture_width
