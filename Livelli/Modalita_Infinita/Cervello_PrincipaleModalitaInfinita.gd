extends Node2D

var savegame = File.new() #file
var save_path = "user://Salvataggio_InfiniteMode.save" #place of the file
var save_data = {"highscore": 0} #variable to store data

onready var Spawner_enemy = get_node("Spawner_enemy")
onready var player = get_node("Spawner_enemy/KinematicBody2D")

func _process(delta):
	if savegame.file_exists(save_path) == false:
		create_save()
		
	if player.alive == false:
		if read_savegame() < Spawner_enemy.score:
			save(Spawner_enemy.score)
			get_node("CanvasLayer/Popup").show()
			print("Nuovo record!!!!!!!!!!!!!!")
	
	
	#get_node("CanvasLayer/Popup/BestScore").set_text(str(read_savegame()))
	
func save(score):    
   save_data["highscore"] = score #data to save
   savegame.open(save_path, File.WRITE) #open file to write
   savegame.store_var(save_data) #store the data
   savegame.close() # close the file

func read_savegame():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var() #get the value
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data["highscore"] #return the value
    

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()