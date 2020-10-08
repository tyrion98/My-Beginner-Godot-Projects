extends Label


var score = 0

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.get_name() == "Troll":
		score += 1
		self.text = str(score)

