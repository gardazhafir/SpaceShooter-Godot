extends Node2D
const MIN_SPAWN_TIME = 0.7
var preloadedEnemeis := [
	preload("res://enemy/Fastenemy.tscn"),
	preload("res://enemy/SlowShooter.tscn"),
	preload("res://enemy/bouncerEnemy.tscn")
]

var plMeteor := preload("res://meteor/meteor.tscn")

onready var spawnTimer := $spawnTimer

var nextSpawnTime := 5.0

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _on_spawnTimer_timeout():
	var viewRect : = get_viewport_rect()
	var yPos : = rand_range(viewRect.position.y,viewRect.end.y)
	if randf() < 0.1:
		var meteor: = plMeteor.instance()
		meteor.position = Vector2(position.x,yPos)
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload = preloadedEnemeis[randi() % preloadedEnemeis.size()]
		var Enemy : enemy = enemyPreload.instance()
		Enemy.position = Vector2(position.x,yPos)
		get_tree().current_scene.add_child(Enemy)
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
		
	spawnTimer.start(nextSpawnTime)

