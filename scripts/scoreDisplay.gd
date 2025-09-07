extends Label

func _ready() -> void:
	GameManager.scoreUpdated.connect(UpdateDisplay)


func UpdateDisplay():
	self.text = str(GameManager.score)
