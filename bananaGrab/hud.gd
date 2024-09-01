extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()


func _on_timer_timeout():
	show_start_new_game()


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

func update_score(value):
	$MarginContainer/Score.text = str(value)


func update_time(value):
	$MarginContainer/Time.text = str(value)


func show_game_over():
	$Message.text = "Game Over"
	$Message.show()
	$Timer.start(2)
	
func show_start_new_game():
	$Message.text = "Banana Grab!"
	$Message.show()
	$StartButton.show()




