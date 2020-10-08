extends Node


export (int) var max_health = 1

#setget
onready var health = max_health setget set_health


# set up signal
signal no_health

# make a set health
func set_health(value):
	# set the health to the value
	health = value
	if health <= 0: 
		emit_signal("no_health")
