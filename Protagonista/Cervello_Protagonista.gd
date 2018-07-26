extends KinematicBody2D

export (PackedScene) var Cervello_Proiettile

var gravity = 900

var velocity = Vector2()
var speed = 800
var alive = true



func _physics_process(delta):
	if not alive:
		print("Game over")
		
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
	if alive:
		get_node("Node/CanvasLayer/Popup").show()
		alive = false
	


func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		alive = false
		get_node("CanvasLayer2/Popup").show()
		gravity = 0
		
func _on_TextureButton_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")

