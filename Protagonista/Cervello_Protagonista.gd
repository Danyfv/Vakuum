extends KinematicBody2D

export (PackedScene) var Cervello_Proiettile

var gravity = 800

var velocity = Vector2()
var speed = 800
var alive = true
var life = 1
var pos = Vector2(0, 0)
var moved = false

onready var animation = get_node("Sprite/AnimationPlayer")

func _ready():
	animation.play("Normale")


func _physics_process(delta):
	pos = position
	if not alive:
		gravity = 0
		
	var force = Vector2(0, gravity)
		
	if alive:
		control(delta)
		move_and_slide(velocity)


func control(delta):
	var curr_speed = 0
	
	if (get_node("CanvasLayer/Right").is_pressed() or Input.is_action_pressed("ui_right")) and position.x < 700:
		curr_speed += speed
		
	if (get_node("CanvasLayer/Left").is_pressed() or Input.is_action_pressed("ui_left")) and position.x > 20:
		curr_speed -= speed
	
	velocity = Vector2(curr_speed, gravity)
	


func _on_Exit_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")



func take_damage():
	life -= 1
	
	if life == 0 and alive:
		get_node("Node/CanvasLayer/Popup").show()
		alive = false
		animation.play("NoScudo")
	
	else:
		animation.play("NoScudo")

func more_life():
	if life == 1:
		life = 2
		animation.play("Scudo")
		
func shot():
	if life == 2:
		animation.play("AttaccoConScudo")
	
	else:
		animation.play("Attacco")
	
	
func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		win()
		
		
func _on_TextureButton_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")

func win():
	alive = false
	get_node("CanvasLayer2/CanvasLayer/Popup").show()

	