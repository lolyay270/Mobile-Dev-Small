"""
This script controls the display of the player's high score
"""

extends Label

# when ever the high score is shown, get new data
func _ready() -> void:
	UpdateScore(GameManager.highScore)


# allow other scripts to update as needed, especially if a new high score has just been made
func UpdateScore(newScore: int):
	text = "HIGH SCORE: " + str(newScore)
