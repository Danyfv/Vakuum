extends KinematicBody2D

export (PackedScene) var Cervello_Proiettile

var gravity = 0

var velocity = Vector2()
var speed = 600
var alive = true
var life = 10
var PlayerPosition = Vector2(0, 0)

onready var animation = get_node("Sprite/AnimationPlayer")

func _ready():
	animation.play("Normale")


func _physics_process(delta):
	get_node("CanvasLayer/Life").text = str(life)
	
	if not alive:
		win()
		gravity = 0
		
	var force = Vector2(0, gravity)
		
	if alive:
		control(delta)
		move_and_slide(velocity)


func control(delta):
	randomize()
	var randomChange = rand_range(1, 40)
	
	if position.x < 70 or PlayerPosition.x == position.x or randomChange < 2:
		speed = speed * (-1)
		
	elif position.x > 650:
		speed = speed * (-1)
		
	velocity = Vector2(speed, gravity)


func take_damage():
	life -= 1
	
	if life == 0 and alive:
		alive = false
		animation.play("NoScudo")
	
	else:
		animation.play("NoScudo")
		print("No scudo")

func more_life():
	if life < 6:
		life += 1
		if life == 6:
			animation.play("Scudo")
		
func shot():
	if life == 6:
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

func gameorver():
	get_node("Node/CanvasLayer/Popup").show()
	