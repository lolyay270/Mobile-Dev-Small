extends Label

func _ready() -> void:
	GameManager.scoreUpdated.connect(UpdateDisplay)
	GameManager.playStateUpdated.connect(HideDisplay)


func UpdateDisplay():
	self.text = str(GameManager.score)


func HideDisplay():
	self.hide()
