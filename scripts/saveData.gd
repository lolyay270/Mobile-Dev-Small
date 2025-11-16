"""
This file is used to save/load data on the device running the game
The script is an edited version from the Godot docs 
https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html#saving-and-reading-data
"""

extends Node

var save_nodes = [GameManager]
var saveFileLocation: String = "user://savegame.save"


# Note: This can be called from anywhere inside the tree. This function is path independent.
# Go through everything in the persist category and ask them to return a dict of relevant variables.
func save_game():
	var save_file = FileAccess.open(saveFileLocation, FileAccess.WRITE)
	for node in save_nodes:
		# Check the node has a save function.
		if !node.has_method("save"):
			print("node ", node.name, " is missing a save() function, skipped")
			continue
		
		# Call the node's save function.
		var node_data = node.call("save")
		
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
		
		print("data saved to file")



# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		# Creates the helper class to interact with JSON.
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object.
		var node_data = json.data
		print("save data:   ", node_data)
		
		# Save data to the correct nodes
		if node_data["highscore"]:
			GameManager.highScore = node_data["highscore"]
		
		if node_data["discovered"]:
			GameManager.discovered = node_data["discovered"]
		
		else:
			print(node_data)
