extends Area2D

@export var speed = 200
@export var direction = Vector2.ZERO
var spawn_weight: int

func _ready():
	add_to_group("vehicles")
	direction = Vector2.DOWN
	$Sprite2D.flip_v = true

func _process(delta):
	position += direction.normalized() * speed * delta
