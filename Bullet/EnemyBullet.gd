extends Area2D

var pbulletEffect := preload("res://Bullet/enemyBulletEffect.tscn")
export var speed: float = 300

func _physics_process(delta):
	position.x -= speed * delta



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if area is Player:
		var bulletEffect := pbulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
		area.damage(1)
		queue_free()

