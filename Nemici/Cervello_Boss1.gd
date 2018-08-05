extends Area2D


var life = 5
var velocity = Vector2()
var speed = 5
var alive = true
onready var life_Label = get_node("CanvasLayer/Life")
func _process(delta):
	print(life)
	control()
	#move_local_y(15.5)
	move_local_x(speed)
	

func control():
	if position.x < 70:
		speed = speed * (-1)
		
	elif position.x > 650:
		speed = speed * (-1)

func take_damage():
	life -= 1
	life_Label.text = str(life)
	
	if life == 0:
		alive = false 
	 
	


