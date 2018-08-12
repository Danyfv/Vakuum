extends Area2D
var speed = rand_range(1, 4)
var VerticalMove = false

export (PackedScene) var Cervello_Protagonista
onready var alive = true
var BossDamage = false

func _process(delta):
	if position.y == 0:
		die()
		
	control()
	if alive == true:
		move_local_x(speed)
		if VerticalMove == true:
			move_local_y(-2.5)

func control():
	if position.x < -20:
		speed = speed * (-1)
		
	elif position.x > 740:
		speed = speed * (-1)

	
func die():
	queue_free()

func feeds():
	scale.x += 1
	scale.y += 1

func _on_Area2D_area_entered(area):
	if area.get_name() == "Boss" and BossDamage == true:
		area.take_damage()
		die()


func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.take_damage()