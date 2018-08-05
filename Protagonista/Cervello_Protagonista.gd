extends KinematicBody2D

export (PackedScene) var Cervello_Proiettile

var gravity = 400

var velocity = Vector2()
var speed = 800
var alive = true
var life = 1

onready var animation = get_node("Sprite/AnimationPlayer")

func _ready():
	animation.play("Normale")


func _physics_process(delta):
	if not alive:
		gravity = 0
		
	var force = Vector2(0, gravity)
		
	if alive:
		control(delta)
		move_and_slide(velocity)


func control(delta):

	if (get_node("CanvasLayer/Right").is_pressed() or Input.is_action_pressed("ui_right")) and position.x < 700:
		velocity = Vector2(speed, gravity)
		
	elif (get_node("CanvasLayer/Left").is_pressed() or Input.is_action_pressed("ui_left")) and position.x > 20:
		velocity = Vector2(-speed, gravity)
		
	else:
		velocity = Vector2(0, gravity)
	


func _on_Exit_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")



func take_damage():
	life -= 1
	
	if life == 0 and alive:
		get_node("Node/CanvasLayer/Popup").show()
		alive = false
	
	else:
		animation.play("NoScudo")
		print("No scudo")

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
	get_node("CanvasLayer2/Popup").show()

	