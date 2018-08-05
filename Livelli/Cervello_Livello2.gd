extends Node2D


var savegame = File.new() #file
var save_path = "user://Salvataggio_LivelloCompletato.save" #place of the file
var save_data = {"Level": 1}
var Levelcomplete

var bullet_enemy = preload("res://Ambiente/Proiettile.tscn")
var shield = preload("res://Ambiente/Scudo.tscn")
var paw = preload("res://Ambiente/Zampata.tscn")

onready var player = get_node("Node2D/KinematicBody2D")

func _ready():
	_bulletSpawn()
	
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

func _bulletSpawn():
	while player.alive == true:
		var random_object = rand_range(0, 100)
		var object
		 
		randomize()
		#Creo un istanza del proiettile e un vettore con la posizione
		if random_object < 5:
			object = shield.instance()
			object.name = "shield"
		
		elif random_object > 5 and random_object < 15:
			object = paw.instance()
			object.name = "paw"
			
		else:
			object = bullet_enemy.instance()
			object.name = "bullet_enemy"
		
		var pos = Vector2()

		object.position.x = rand_range(10, 710)
		object.position.y = player.position.y + 2000

		
		#aggiungo il nuovo nemico al container
		get_node("container").add_child(object)

		
		#da il tempo di creazione dei proiettili
		var pauseTime = Timer.new()
		pauseTime.set_wait_time(0.5)
		self.add_child(pauseTime)
		pauseTime.start()
		yield(pauseTime, "timeout")
		pauseTime.queue_free()


