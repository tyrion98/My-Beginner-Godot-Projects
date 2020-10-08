extends Camera2D


func _process(delta):
	if get_parent().isAttacking == true:
		$ScreenShake.start()
		

