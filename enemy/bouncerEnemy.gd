extends slowShooter
export var horizontalSpeed := 50.0

var horizontalDirection: int = 1

func _physics_process(delta):
	position.y += horizontalSpeed * delta * horizontalDirection
	var viewRect := get_viewport_rect()
	if position.y < viewRect.position.y or position.y > viewRect.end.y:
		horizontalDirection *= -1
	
