extends Node2D


func _on_Exit_button_down():
	get_tree().quit()


func _on_Start_button_down():
	get_tree().change_scene("Livelli/BloccoLivello/CervelloGriglia.tscn")


func _on_InfiniteMode_button_down():
	get_tree().change_scene("Livelli/Modalita_Infinita/Scena_PrincipaleModalitaInfinita.tscn")
