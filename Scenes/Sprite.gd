extends Node2D

# speed of the scroll
export(int) var VELOCITY = 10.0
func _ready():
	$Sword.position.y = $Sword.position.y + rand_range(-12,12)
	$Sword2.position.y = $Sword2.position.y + rand_range(-12,12)

func _process(delta):
	# constantly move	
	self.position = lerp(position, Vector2(position.x - VELOCITY, position.y), 0.1)



func _on_Area2D_body_entered(body):

	if body.get_name() == "Troll":
		var label = get_parent().get_node("Camera2D/Control2/Score")
		label.score +=1
		label.text = str(label.score)
