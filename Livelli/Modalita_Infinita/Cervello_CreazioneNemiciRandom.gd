extends Node2D

#Carica la scena del proiettile
var bullet_enemy = preload("res://Ambiente/Proiettile.tscn")

onready var gamer = get_node("KinematicBody2D")
var score = 0

func _ready():
	_bulletSpawn()
	pass
	
	
func _bulletSpawn():
	while true:
		if gamer.alive == false:
			break
			
		gamer.gravity += 5
		 
		randomize()
		#Creo un istanza del proiettile e un vettore con la posizione
		var enemy = bullet_enemy.instance()
		
		var pos = Vector2()
		pos.x = rand_range(0, 720)
		pos.y = gamer.position.y + 2000
		#setto la posizione del proiettile
		enemy.position = pos

		
		#aggiungo il nuovo nemico al container
		get_node("container").add_child(enemy)

		
		#da il tempo di creazione dei proiettili
		var pauseTime = Timer.new()
		pauseTime.set_wait_time(0.5)
		self.add_child(pauseTime)
		pauseTime.start()
		yield(pauseTime, "timeout")
		pauseTime.queue_free()

		score += 1
		get_node("CanvasLayer/ScoreLabel").set_text(str(score))

	pass
