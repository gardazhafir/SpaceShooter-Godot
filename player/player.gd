extends Area2D
class_name Player

var plBullet := preload("res://Bullet/Bullet.tscn")
const GameOverScreen = preload("res://HUD/GameOverScreen.tscn")

onready var animatedSprite := $AnimatedSprite
onready var FiringPositions := $FiringPositions
onready var firdelayTimer := $firedelayTimer
onready var invicibilityTimer := $invicibilityTimer
onready var shieldSprite := $shieldSprite
onready var Signal = $"/root/Signals"

export var speed: float = 100
export var fireDelay: float = 0.3
export var life: int = 3
export var damageInvicibilityTime = 1.5
export var Life := true

var vel := Vector2(0,0)
func _ready():
	Signals.emit_signal("on_player_life_changed" , life)
	shieldSprite.visible = false
	
func _process(delta):
	if vel.x < 0:
		animatedSprite.play("Left")
	elif vel.x > 0:
		animatedSprite.play("Right")
	else:
		animatedSprite.play("straight ")
	
	#check shooting
	if Input.is_action_pressed("shoot") and firdelayTimer.is_stopped():
		firdelayTimer.start(fireDelay)
		for child in FiringPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
			
		
func _physics_process(delta):
	var dirVec := Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x , 0 , viewRect.size.x)
	position.y = clamp(position.y , 0 , viewRect.size.y)

func damage(amount:int):
	if !invicibilityTimer.is_stopped():
		return
	invicibilityTimer.start(damageInvicibilityTime)
	shieldSprite.visible = true
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)
	
	if life <= 0 :
		Signals.emit_signal("on_player_died")
		queue_free()
		

func _on_invicibilityTimer_timeout():
	shieldSprite.visible = false
