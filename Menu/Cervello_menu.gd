extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Exit_button_down():
	get_tree().quit()


func _on_Start_button_down():
	get_tree().change_scene("Livelli/Scena_Livelli.tscn")
