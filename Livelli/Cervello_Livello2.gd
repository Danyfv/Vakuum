extends Node2D


var savegame = File.new() #file
var save_path = "user://Salvataggio_LivelloCompletato.save" #place of the file
var save_data = {"Level": 1}
var Levelcomplete

func _process(delta):
	if savegame.file_exists(save_path) == false:
		create_save()
	
	Levelcomplete = read_savegame()
		
func _on_TextureButton_button_down():
	var NumberOfLevel = get_node("Label").text
	get_tree().change_scene("Livelli/Livello" + NumberOfLevel + ".tscn")


func save(score):    
   save_data["Level"] = score #data to save
   savegame.open(save_path, File.WRITE) #open file to write
   savegame.store_var(save_data) #store the data
   savegame.close() # close the file

func read_savegame():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var() #get the value
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data["Level"] #return the value
    

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()


func _on_Area2D_body_entered(body):
	if body.get_name() == "KinematicBody2D":
		if Levelcomplete == 2:
			save(3)
		
