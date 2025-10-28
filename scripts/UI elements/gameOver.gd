extends Node

@onready var finalScoreDisplay: Label = $BG/score
@onready var scoreManager = $"/root/Game/Score/Value"

func _ready() -> void:
	if scoreManager.score > GameManager.highScore:
		manageHighScore()
	
	scoreManager.get_parent().hide() #hide the scoreDisplay
	finalScoreDisplay.text = "SCORE: " + str(scoreManager.score)
	
	#TODO: show highscore value


func _on_new_game_button_up() -> void:
	get_tree().reload_current_scene()


func manageHighScore():
	#temp
	print("new highscore! ", scoreManager.score, " > ", GameManager.highScore)
	
	GameManager.highScore = scoreManager.score
	SaveData.save_game()
	
	#TODO: show "new highscore" banner
