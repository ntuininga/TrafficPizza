extends Node2D

var score

func _start():
	score = 0
	$Player.start($StartPosition.position)
