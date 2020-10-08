extends Timer

var timer = 100
func _ready():
	pass

# on ready var
onready var swords = preload("res://Scenes/Main_Menu.tscn")
func _process(delta):
	timer+=1
	if timer >= 100:
		timer = 0
		var sword = swords.instance()
		# set position at the swords position
		sword.position.x = 21
		sword.position.y = 21 + rand_range(-2,2)
		queue_free()
