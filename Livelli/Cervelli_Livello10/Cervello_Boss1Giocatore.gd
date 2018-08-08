extends Area2D


var life = 1
var velocity = Vector2()
var speed = 6
var alive = true
onready var anim = get_node("Sprite/AnimationPlayer")

func _ready():
	anim.play("Hit")
	
func _process(delta):
	print(life)
	control()
	move_local_x(speed)
	

func control():
	if (get_node("CanvasLayer/Right").is_pressed() or Input.is_action_pressed("ui_right")) and position.x < 700:
		speed = 6
		
	elif (get_node("CanvasLayer/Left").is_pressed() or Input.is_action_pressed("ui_left")) and position.x > 20:
		speed = -6
	
	else:
		speed = 0
		
func take_damage():
	life -= 1
	anim.play("Hit")
	
	if life == 0:
		alive = false 
		speed = 0
	 
	

func _on_Exit_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")
