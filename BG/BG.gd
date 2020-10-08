extends ParallaxBackground


const VELOCITY  = -5.0
# text



func _process(delta):
	scroll_offset.x += VELOCITY 
