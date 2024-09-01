extends Area2D

var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	$Timer.start(randf_range(2,6))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play("boink")
	$Timer.start(randf_range(2,6))


func pickup():
	# disable the collision, but at the end of this frame cycle
	$CollisionShape2D.set_deferred("disabled", true)
	# create a tween to enlarge and fade out the bananas
	var thisTween = create_tween()
	thisTween.set_parallel()
	thisTween.set_trans(Tween.TRANS_QUAD)
	thisTween.tween_property(self, "scale", scale * 3, 0.3)
	thisTween.tween_property(self, "modulate:a", 0, 0.3)
	await thisTween.finished
	# finally, destroy the banana
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("spikes"):
		position = Vector2( randi_range(0, screen_size.x), randi_range(0, screen_size.y))
