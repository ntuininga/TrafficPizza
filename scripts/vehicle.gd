extends Area2D

@export var speed = 200
@export var direction = Vector2.ZERO

func _ready():
	direction = Vector2.DOWN

func _process(delta):
	position += direction.normalized() * speed * delta
