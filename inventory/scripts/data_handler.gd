extends Node

var item_data : Dictionary = {}
var item_grid_data : Dictionary = {}
var icon_atlas : Dictionary = {}

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
		var temp_grid_array : Array[String] = []
		for point in item_data[item]["Grid"]:
			temp_grid_array.push_back(point)
		item_grid_data[item] = temp_grid_array
		if item_data[item].has("atlas") : _prep_atlas(item_data[item].atlas)
		
func _prep_atlas(atlas_path : String) -> void:
	if icon_atlas.has(atlas_path): return
	if not FileAccess.file_exists(atlas_path):
		push_error("No atlas file found at %s" % atlas_path)
		return
	var atlas_image : Texture2D = load(atlas_path)
	var new_atlas = AtlasTexture.new()
	new_atlas.atlas = atlas_image
	icon_atlas[atlas_path] = new_atlas
