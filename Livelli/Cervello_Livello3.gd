extends Node2D


onready var player = get_node("KinematicBody2D")
onready var boss = get_node("Boss")

var bullet_enemy = preload("res://Ambiente/Proiettile.tscn")
var shield = preload("res://Ambiente/Scudo.tscn")
var paw = preload("res://Ambiente/Zampata.tscn")

var savegame = File.new() #file
var save_path = "user://Salvataggio_LivelloCompletato.save" #place of the file
var save_data = {"Level": 1}
var Levelcomplete



func _ready():
	_bulletSpawn()
	player.gravity = 0
	
func _process(delta):
	Levelcomplete = read_savegame()
	
	if boss.alive == false:
		player.win()
		if Levelcomplete == 3:
			save(4)

	
func _bulletSpawn():
	while player.alive == true and boss.alive == true:
		var random_object = rand_range(0, 100)
		var object
		 
		randomize()
		#Creo un istanza del proiettile e un vettore con la posizione
		if random_object < 10:
			object = shield.instance()
			object.name = "shield"

		
		elif random_object > 10 and random_object < 30:
			object = paw.instance()
			object.name = "paw"
			
		else:
			object = bullet_enemy.instance()
			object.name = "bullet_enemy"
		
		var pos = Vector2()

		object.position.x = boss.position.x + rand_range(-150, 150)
		object.position.y = boss.position.y + rand_range(-80, 80)

		
		#aggiungo il nuovo nemico al container
		get_node("container").add_child(object)

		
		#da il tempo di creazione dei proiettili
		var pauseTime = Timer.new()
		pauseTime.set_wait_time(0.5)
		self.add_child(pauseTime)
		pauseTime.start()
		yield(pauseTime, "timeout")
		pauseTime.queue_free()



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
    
