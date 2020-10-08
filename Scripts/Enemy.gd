extends Area2D


#var health
var health = 2
# death var
var dead = false

# sprite
onready var sprite = $AnimatedSprite

func _process(delta):
	

	# check if they are dead
	if dead == false:
		sprite.play("Idle")

# if player hits them
func _on_Enemy_area_entered(area):
	if area.is_in_group("Sword"):
		# subtract health
		health -= 1
		if health == 0:
			dead = true
			sprite.play("Dead")


# when the animation is finished they vanish
func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "Dead":
		queue_free()


#if AI hits the wall change directions
func _on_WallCollider_area_entered(area):
	pass
