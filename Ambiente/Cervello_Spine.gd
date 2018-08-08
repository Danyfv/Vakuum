extends Area2D

export (PackedScene) var Cervello_Protagonista

var speed = 1800
var PlayerGravity = 0
onready var alive = true
var PlayerPosition = Vector2(0, 0)
var PopupPosition =  Vector2(0, 0)
var Warning_signal = true
var BossDamage = false

func ready():
	speed = speed + PlayerGravity

func _process(delta):
	if Warning_signal == false:
		get_node("CanvasLayer/Warning").hide()
	
	else:
		get_node("CanvasLayer/Warning").position.x = position.x
		
		if PlayerPosition.y - position.y < 500 and PlayerPosition.y - position.y > 100:
			get_node("CanvasLayer/Warning").show()

		else:
			get_node("CanvasLayer/Warning").hide()
			
	if alive == true:
		move_local_y((speed + (PlayerGravity/2)) * delta)


func _on_Bullet_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.take_damage()
		die()
	
func die():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.take_damage()


func _on_Area2D_area_entered(area):
	if area.get_name().begins_with("@bullet_enemy"):
		area.die()
		die()
	
	if area.get_name() == "Boss" and BossDamage == true:
		area.take_damage()
		die()
