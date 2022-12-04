extends enemy
class_name slowShooter
export var fireRate := 0.8
onready var firetimer: = $FireTimer

func _process(delta):
	if firetimer.is_stopped():
		fire()
		firetimer.start(fireRate)
