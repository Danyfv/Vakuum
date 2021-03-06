extends TextureButton

var Levelcomplete = 0

var savegame = File.new() #file
var save_path = "user://Salvataggio_LivelloCompletato.save" #place of the file
var save_data = {"Level": 1}

func _process(delta):
	if savegame.file_exists(save_path) == false:
		create_save()
	
	Levelcomplete = read_savegame()
	
	if int(get_node("Label").text) <= Levelcomplete:
		disabled = false
	else:
		disabled = true
		
func _on_TextureButton_button_down():
	var NumberOfLevel = get_node("Label").text
	get_tree().change_scene("Livelli/Livello" + NumberOfLevel + ".tscn")



func read_savegame():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var() #get the value
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	print(save_data)
	savegame.close() #close the file
	return save_data["Level"] #return the value
    

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()