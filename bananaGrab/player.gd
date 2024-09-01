extends Area2D

@export var move_speed = 350

var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# GET VECTOR INPUT FOR 8-DIRECTIONAL MOVEMENT
	var move_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# MOVE THE PLAYER POSITION
	position += move_dir * move_speed * delta

	# PREVENT THE USER FROM MOVING OFFSCREEN
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# PLAY THE CORRECT ANIMATION
	if move_dir.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"

	# FLIP THE SPRITE IF PLAYER MOVING LEFT
	if move_dir.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif move_dir.x > 0:
		$AnimatedSprite2D.flip_h = false


func start():
	position = screen_size/ 2
	$AnimatedSprite2D.animation = "idle"
	show()
	set_process(true)
	
	
func dead():
	$AnimatedSprite2D.animation = "dead"
	set_process(false)
	


