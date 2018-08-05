extends Area2D
var speed = -100
var AttackMode = false 

export (PackedScene) var Cervello_Protagonista
onready var alive = true
onready var anim = get_node("Sprite/AnimationPlayer")

func _ready():
	anim.play("Normale")
	
func _process(delta):
	if alive == true:
		move_local_y(speed * delta)
		
	if position.y == 0:
		die()




func _on_Zampata_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		AttackMode = true
		speed = -body.gravity - 500
		body.shot()
		anim.play("Attacco")
		

func _on_Zampata_area_entered(area):
	if area.get_name().begins_with("@bullet_enemy") and AttackMode == true:
		print("colpitoooooooo")
		anim.play("Attacco")
		area.die()
		die()

		

func die():
	queue_free()
