extends KinematicBody2D

export (PackedScene) var Cervello_Proiettile

var GRAVITY = 1000

var velocity = Vector2()
var speed = 600
var alive = true



func _physics_process(delta):
	if not alive:
		print("Game over")
		
	var force = Vector2(0, GRAVITY)
		
	if alive:
		control(delta)
		move_and_slide(velocity)


func control(delta):

	if get_node("CanvasLayer/Right").is_pressed() or Input.is_action_pressed("ui_right"):
		velocity = Vector2(speed, GRAVITY - 100)
		
	elif get_node("CanvasLayer/Left").is_pressed() or Input.is_action_pressed("ui_left"):
		velocity = Vector2(-speed, GRAVITY - 100)

	
	else:
		velocity = Vector2(0, GRAVITY)
	


func _on_Exit_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")



func take_damage():
	if alive:
		get_node("Node/CanvasLayer/Popup").show()
		alive = false
	


func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		alive = false
		get_node("CanvasLayer2/Popup").show()
		GRAVITY = 0
		
func _on_TextureButton_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")

