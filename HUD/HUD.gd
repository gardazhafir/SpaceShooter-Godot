extends Control

const GameOverScreen = preload("res://HUD/GameOverScreen.tscn") 

onready var Signal = $"/root/Signals"
onready var lifeContainer := $LifeContainer
onready var scoreLabel := $score
var pLifeIcon := preload("res://HUD/lifeIcon.tscn")

var score:int = 0

func _ready():
	clearlives()
	Signals.connect("on_player_life_changed",self,"_on_player_life_changed")
	Signals.connect("on_score_increment" , self ,"_on_score_increment")
	Signals.connect("on_player_died", self, "_on_player_died")

func clearlives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func setLives(lives: int):
	clearlives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instance())

func _on_player_life_changed(life:int):
	setLives(life)

func _on_player_died():
	var game_over = GameOverScreen.instance()
	add_child(game_over)

func _on_score_increment(amount : int):
	score += amount
	scoreLabel.text = str(score)

