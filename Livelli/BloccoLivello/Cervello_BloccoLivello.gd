extends Node2D

#Carica la scena del livello
var BlockLevel = preload("res://Livelli/BloccoLivello/Scena_Bottone.tscn")

var NumberLevel = 0


func _ready():
	_LevelGrid()
	pass


func _LevelGrid():
	while NumberLevel < 12:
		var level
		
		NumberLevel += 1
		
		level = BlockLevel.instance()
		level.name = str(NumberLevel)
		
		#aggiungo il nuovo livello al container
		get_node("CanvasLayer/GridContainer").add_child(level)
		level.get_node("Label").set_text(str(NumberLevel))
	pass


func _on_TextureButton_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")
