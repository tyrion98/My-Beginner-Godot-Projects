extends Node

#constants
const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

# amplitude
var amplitude = 0
# priority of shakes
var priority

# make a var for the tween and camera
onready var tween = $Tween
onready var freq = $Frequency
onready var duration = $Duration
#cam
onready var camera = get_parent()

# the function that starts it
func start(duration = 0.1, frequency = 3, amplitude = 10):
	

	# assign vals to variable
	self.amplitude = amplitude
		
	self.duration.wait_time = duration
	self.freq.wait_time = 1/float(frequency)
		
	# start the timers
	self.duration.start()
	self.freq.start()
	# start the shake
	new_shake()
	

# screen shake function
func new_shake():
	var rand = Vector2.ZERO
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	tween.interpolate_property(camera, "offset", camera.offset, rand, freq.wait_time)
	tween.start()
	
# reset the shake / finish
func reset():
	tween.interpolate_property(camera, "offset", camera.offset, Vector2.ZERO, freq.wait_time)
	tween.start()


# when time runs out 
func _on_Frequency_timeout():
	new_shake()

# shake should be over
func _on_Duration_timeout():
	reset()
	freq.stop()
