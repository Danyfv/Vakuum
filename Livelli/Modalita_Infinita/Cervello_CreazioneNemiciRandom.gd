extends Node2D

#Carica la scena del proiettile
var bullet_enemy = preload("res://Ambiente/Proiettile.tscn")
var cloud_enemy = preload("res://Ambiente/Nuvola.tscn")
var shield = preload("res://Ambiente/Scudo.tscn")
var paw = preload("res://Ambiente/Zampata.tscn")

onready var  player = get_node("KinematicBody2D")
var score = 0

func _ready():
	_bulletSpawn()
	pass
	
	
func _bulletSpawn():
	while true:
		var random_object = rand_range(0, 100)
		var object
		
		if player.alive == false:
			break
		
		player.gravity += 5
		 
		randomize()
		#Creo un istanza del proiettile e un vettore con la posizione
		if random_object < 5:
			object = shield.instance()
			object.name = "shield"
		
		elif random_object > 5 and random_object < 15:
			object = cloud_enemy.instance()
			object.name = "cloud_enemy"
		
		elif random_object > 15 and random_object < 25:
			object = paw.instance()
			object.name = "paw"
			
		else:
			object = bullet_enemy.instance()
			object.name = "bullet_enemy"
		
		var pos = Vector2()
		pos.x = rand_range(-10, 730)
		pos.y = player.position.y + 2000
		#setto la posizione del proiettile
		object.position = pos

		
		#aggiungo il nuovo nemico al container
		get_node("container").add_child(object)

		
		#da il tempo di creazione dei proiettili
		var pauseTime = Timer.new()
		pauseTime.set_wait_time(0.35)
		self.add_child(pauseTime)
		pauseTime.start()
		yield(pauseTime, "timeout")
		pauseTime.queue_free()

		score += 1
		get_node("CanvasLayer/ScoreLabel").set_text(str(score))

	pass
