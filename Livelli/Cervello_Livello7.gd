extends Node2D


var savegame = File.new() #file
var save_path = "user://Salvataggio_LivelloCompletato.save" #place of the file
var save_data = {"Level": 1}
var Levelcomplete

var dart_enemy = preload("res://Ambiente/Dardo.tscn")
var shield = preload("res://Ambiente/Scudo.tscn")
var paw = preload("res://Ambiente/Zampata.tscn")

onready var player = get_node("KinematicBody2D")

func _ready():
	_bulletSpawn()
	
func _process(delta):
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
    


func _on_Area2D_body_entered(body):
	player.win()
	if body.get_name() == "KinematicBody2D":
		if Levelcomplete == 7:
			save(8)

func _bulletSpawn():
	while player.alive == true:
		var random_object = rand_range(0, 100)
		var object
		var SpawnTime = 1
		 
		randomize()
		#Creo un istanza del proiettile e un vettore con la posizione
		if random_object <= 10:
			object = shield.instance()
			object.name = "shield"
			SpawnTime = 0.1
		
		elif random_object > 10 and random_object < 20:
			object = paw.instance()
			object.name = "paw"
			SpawnTime = 0.3
		
		else:
			object = dart_enemy.instance()
			object.name = "dart_enemy"
			object.PlayerPosition = player.position
			SpawnTime = 0.2

		object.position.x = rand_range(10, 710)
		object.position.y = player.position.y + 1400
		
		#aggiungo il nuovo nemico al container
		get_node("container").add_child(object)

		
		#da il tempo di creazione dei proiettili
		var pauseTime = Timer.new()
		pauseTime.set_wait_time(SpawnTime)
		self.add_child(pauseTime)
		pauseTime.start()
		yield(pauseTime, "timeout")
		pauseTime.queue_free()

