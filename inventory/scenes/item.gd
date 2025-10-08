extends Node2D

@onready var IconRect_path: TextureRect = $Icon

var item_id : int
var item_grid := []
var selected := false
var grid_anchor = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func load_item(load_item_id: int) -> void:
	var Icon_path = "res://inventory/assets/" + DataHandler.item_data[str(load_item_id)]["Name"] + ".png"
	IconRect_path.texture = load(Icon_path)
	print(DataHandler.item_grid_data[str(load_item_id)])
	for grid in DataHandler.item_grid_data[str(load_item_id)]:
		var converter_array = []
		for i in grid.split(','):
			converter_array.push_back(int(i))
		item_grid.push_back(converter_array)
