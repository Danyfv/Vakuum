extends Area2D


var life = 5
var velocity = Vector2()
var speed = 3
var alive = true
var PlayerPosition = Vector2(360, 0)

onready var StartPosition = position
onready var life_Label = get_node("CanvasLayer/Life")
onready var anim = get_node("Sprite/AnimationPlayer")

func _ready():
	anim.play("Hit")
	
func _process(delta):
	look_at(PlayerPosition)
	print(life)
	control()
	move_local_y(speed)
	#move_local_x(speed)
	

func control():
	if position.x < 70:
		speed = speed * (-1)
		
	elif position.x > 650:
		speed = speed * (-1)
	
	if StartPosition.y - position.y < 0:
		move_local_x(1)

func take_damage():
	life -= 1
	life_Label.text = str(life)
	anim.play("Hit")
	
	if life == 0:
		alive = false 
		speed = 0
	 
	

