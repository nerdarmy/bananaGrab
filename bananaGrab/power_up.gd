extends Area2D

@export var life_time = 2
var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	$LifeTimer.start(life_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_life_timer_timeout():
	queue_free()


func pickup():
	# disable the collision, but at the end of this frame cycle
	$CollisionShape2D.set_deferred("disabled", true)
	$LifeTimer.stop()
	# create a tween to enlarge and fade out the bananas
	var thisTween = create_tween()
	thisTween.set_parallel()
	thisTween.set_trans(Tween.TRANS_QUAD)
	thisTween.tween_property(self, "scale", scale * 3, 0.3)
	thisTween.tween_property(self, "modulate:a", 0, 0.3)
	await thisTween.finished
	# finally, destroy the banana
	queue_free()
