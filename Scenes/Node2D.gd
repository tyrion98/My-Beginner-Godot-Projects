extends Node2D


func _on_WON_body_entered(body):
	if body is KinematicBody2D:
		$"WON!/Won/Label".visible = true

