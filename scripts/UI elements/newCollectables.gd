extends GridContainer

@onready var gameStart: Node = $"/root/Game"
@onready var newCollectHeading: Label = $"../newCollect"

func _ready() -> void:
	# get all objects to show
	var objs: Array[Resource] = gameStart.newCollected
	
	if objs.size() == 0:
		newCollectHeading.hide()
	
	else:
		newCollectHeading.show()
		
		# adjust columns to fit the number of fish
		# this will only look good until 10 objects, 11 looks BAD
		self.columns = ceil(objs.size() / 2.0)
		
		# add each object into the scene
		for object in objs:
			var collect: TextureRect = TextureRect.new()
			add_child(collect)
			
			# change to the correct texture and ensure it fills the grid's cell
			collect.texture = object.sprite
			collect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
			collect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			collect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			collect.size_flags_vertical = Control.SIZE_EXPAND_FILL
