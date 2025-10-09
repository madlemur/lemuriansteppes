extends Node

var item_data : Dictionary = {}
var item_grid_data : Dictionary = {}

@onready var data_path = "res://inventory/assets/item_data.json"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data(data_path)
	set_grid_data()

# TODO: Integrate with the Inventory system.
func load_data(item_data_path: String) -> void:
	if not FileAccess.file_exists(item_data_path):
		push_error("Data file %s not found" % item_data_path)
		return
	var item_data_file = FileAccess.open(item_data_path, FileAccess.READ)
	item_data = JSON.parse_string(item_data_file.get_as_text())
	item_data_file.close()
	
func set_grid_data() -> void:
	for item in item_data.keys():
		var temp_grid_array : Array = []
		for point in item_data[item]["Grid"]:
			temp_grid_array.push_back(point)
		item_grid_data[item] = temp_grid_array
