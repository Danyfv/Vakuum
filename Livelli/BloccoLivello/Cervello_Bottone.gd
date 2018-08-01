extends TextureButton


func _process(delta):
	if get_node("Label").text == "1":
		disabled = false
	else:
		disabled = true
		
func _on_TextureButton_button_down():
	var NumberOfLevel = get_node("Label").text
	get_tree().change_scene("Livelli/Livello" + NumberOfLevel + ".tscn")

