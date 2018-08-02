extends Node2D

#Carica la scena del proiettile
var bullet_enemy = preload("res://Ambiente/Proiettile.tscn")
var cloud_enemy = preload("res://Ambiente/Nuvola.tscn")

onready var  player = get_node("KinematicBody2D")
var score = 0

func _ready():
	_bulletSpawn()
	pass
	
	
func _bulletSpawn():
	while true:
		var cloud_or_bullet = rand_range(0, 10)
		var enemy
		
		if player.alive == false:
			break
		
		player.gravity += 5
		 
		randomize()
		#Creo un istanza del proiettile e un vettore con la posizione
		if cloud_or_bullet < 2:
			enemy = cloud_enemy.instance()
			
		else:
			enemy = bullet_enemy.instance()
		
		var pos = Vector2()
		pos.x = rand_range(-10, 730)
		pos.y = player.position.y + 2000
		#setto la posizione del proiettile
		enemy.position = pos

		
		#aggiungo il nuovo nemico al container
		get_node("container").add_child(enemy)

		
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
