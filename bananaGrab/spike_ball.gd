extends Area2D

var rotate_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_speed = randi_range(160, 180)
	if randf() < 0.5:
		rotate_speed = -rotate_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += rotate_speed * delta
