extends Area2D

@export var speed = 0
@onready var flap_timer = $FlapTimer
@onready var animated_sprite = $AnimatedSprite2D
var flap_time : float
var flap_count: int
var current_flap_count = 0

var screen_size : Vector2
var direction : int

func _ready():
	randomize()
	flap_time = randf_range(1.0, 5.0)
	flap_count = randi_range(2,5)
	flap_timer.start(flap_time)
	
	screen_size = get_viewport_rect().size
	if position.x < screen_size.x / 2:
		direction = 1
		animated_sprite.flip_h = true
	else:
		direction = -1

func _process(delta):
	position.x += speed * delta * direction

func _on_flap_timer_timeout() -> void:
	current_flap_count = 0
	
	#start animation playing
	animated_sprite.play("Flap")
	current_flap_count += 1
	
	#Reset flap values randomly and restart timer
	flap_count = randi_range(2,5)
	flap_time = randf_range(1.0, 5.0)
	flap_timer.start(flap_time)


func _on_animated_sprite_2d_animation_finished() -> void:
	if current_flap_count < flap_count:
		current_flap_count += 1
		animated_sprite.play()
