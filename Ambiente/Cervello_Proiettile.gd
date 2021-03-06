extends Area2D
var speed = -800

export (PackedScene) var Cervello_Protagonista
onready var alive = true
var BossDamage = false

func _process(delta):
	if alive == true:
		move_local_y(speed * delta)
		
	if position.y == 0:
		die()

func _on_Bullet_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.take_damage()
	
func die():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.get_name() == "Boss" and BossDamage == true:
		area.take_damage()
		die()
