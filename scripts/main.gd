extends Node2D

signal game_over

var score = 0 
var start_position  

func _ready():
	_start()

	$Player.vehicle_hit.connect(_on_player_vehicle_hit)

func _start():
	score = 0
	$Player.start($StartPosition.position)

func _game_over():
	print("Game Over!")
	score = 0
	$Player.start($StartPosition.position)
	game_over.emit()

func _on_player_vehicle_hit() -> void:
	print("Vehicle Hit!")
	_game_over()
