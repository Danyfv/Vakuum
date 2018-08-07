extends Area2D

var speed = -15

export (PackedScene) var Cervello_Protagonista
onready var alive = true
var BossDamage = false
var PlayerPosition = Vector2(0, 360)

func _ready():
	look_at(PlayerPosition)

func _process(delta):
	if alive == true:
		move_local_x(-speed)
		
	if position.y == 0:
		die()

	
func die():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.take_damage()


func _on_Area2D_area_entered(area):
	if area.get_name() == "Boss" and BossDamage == true:
		area.take_damage()
		die()

