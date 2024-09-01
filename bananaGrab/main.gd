extends Node

var banana_scene = preload("res://banana.tscn")
var powerup_scene = preload("res://power_up.tscn")

@export var starting_play_time = 10

var screen_size = Vector2.ZERO

var level = 1
var score = 0
var time_left = 10
var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	$Player.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing  and get_tree().get_nodes_in_group("bananas").size() == 0:
		next_level()
	$HUD.update_score(score)
	$HUD.update_time(time_left)


func _on_hud_start_game():
	new_game()


func _on_game_timer_timeout():
	time_left -= 1
	if time_left <= 0:
		game_over()


func _on_powerup_timer_timeout():
	spawn_powerup()


func _on_player_area_entered(area):
	# "area" represents the area2D node that the player entered
	if area.is_in_group("bananas"):
		score += 1
		$BananaSound.play()
		area.pickup()
	if area.is_in_group("spikes"):
		$GameOverSound.play()
		game_over()
	if area.is_in_group("powerups"):
		time_left += 5
		$PowerupSound.play()
		area.pickup()

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

func new_game():
	playing = true
	level = 1
	score = 0
	time_left = starting_play_time
	$Player.start()
	spawn_level_bananas()
	$GameTimer.start()
	
func next_level():
	$LevelSound.play()
	level += 1
	time_left += 5
	spawn_level_bananas()
	$PowerupTimer.start(randi_range(1,3))

func game_over():
	$GameTimer.stop()
	playing = false
	get_tree().call_group("bananas", "queue_free")
	$Player.dead()
	$HUD.show_game_over()
	
func spawn_level_bananas():
	for i in 4 + level:
		spawn_banana()

	
func spawn_banana():
	var thisBanana = banana_scene.instantiate()
	thisBanana.position = Vector2( randi_range(0,screen_size.x), randi_range(0, screen_size.y))
	add_child(thisBanana)
	

func spawn_powerup():
	var thisPowerup = powerup_scene.instantiate()
	thisPowerup.position = Vector2(randi_range(0,screen_size.x), randi_range(0,screen_size.y))
	add_child(thisPowerup)

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 






