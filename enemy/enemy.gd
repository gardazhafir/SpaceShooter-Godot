extends Area2D
class_name enemy
var plBullet := preload("res://Bullet/EnemyBullet.tscn")
var plEnemyExplosion : = preload("res://enemy/enemyExplosion.tscn")
onready var FiringPositions := $FiringPositions
export var horizontallSpeed := 9.0
export var health: int = 15


var playerInArea = null

func _physics_process(delta):
	position.x -= horizontallSpeed*delta


func fire():
	for child in FiringPositions.get_children():
		var bullet := plBullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _process(delta):
	if playerInArea!= null:
		playerInArea.damage(1)

func damage(amount: int):
	if health <= 0:
		return
	health -= amount
	if health <= 0:
		var effect = plEnemyExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		Signals.emit_signal("on_score_increment" , 10)
		
		queue_free()


func _on_enemy_area_entered(area):
	if area is Player:
		playerInArea= area

func _on_enemy_area_exited(area):
	if area is Player:
		playerInArea = null
