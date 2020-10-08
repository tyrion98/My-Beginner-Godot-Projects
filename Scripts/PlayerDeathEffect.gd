extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	play("Death")


# anim finished
func _on_animation_finished():
	queue_free()
	get_tree().reload_current_scene()
