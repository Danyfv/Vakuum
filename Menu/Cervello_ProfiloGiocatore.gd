extends Node2D

var savegame_Level = File.new()
var savegame_Hightscore = File.new()
var save_data_Level = {"Level": 1}
var save_data_Hightscore = {"highscore": 0}

var save_level_path = "user://Salvataggio_LivelloCompletato.save"
var save_hightscore_path = "user://Salvataggio_InfiniteMode.save"

var Level_complete
var Hightscore

onready var Label_BestScore = get_node("CanvasLayer/BestScore")
onready var Label_LevelComplete = get_node("CanvasLayer/LevelComplete")

func _process(delta):
	if savegame_Level.file_exists(save_level_path) == false:
		Label_LevelComplete.text = "0"
	
	else:
		Level_complete = read_savegame(save_level_path, savegame_Level, save_data_Level, "Level")
		Label_LevelComplete.text = str(Level_complete - 1)
		
	if savegame_Hightscore.file_exists(save_hightscore_path) == false:
		Label_BestScore.text = "0"
		
	else:
		Hightscore = read_savegame(save_hightscore_path, savegame_Hightscore, save_data_Hightscore, "highscore")
		Label_BestScore.text = str(Hightscore)
		
		
		

func read_savegame(save_path, savegame, save_data, key):
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var() #get the value
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data[key] #return the value

func _on_TextureButton_button_down():
	get_tree().change_scene("Menu/Scena_menu.tscn")
