extends Area2D
var speed = -200

export (PackedScene) var Cervello_Protagonista
onready var alive = true


func _process(delta):
	if alive == true:
		move_local_y(speed * delta)


func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		body.more_life()
