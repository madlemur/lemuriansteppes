class_name InventoryItem extends Node2D

@onready var IconRect_path: TextureRect = $Icon

var item_id : int
## Array[Array[int]] of grid points around [0,0] that the item takes up in inventory
var item_grid : Array[Array] = []
var selected := false
var grid_anchor = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		global_position = global_position.lerp(get_global_mouse_position(), 25 * delta)

## Load the item texture and set up the grid layout
# TODO: integrate properly with the inventory system. i.e., use the Inventory system
# to manage the textures and inventory grids
func load_item(load_item_id: int) -> void:
	var item = DataHandler.item_data[str(load_item_id)]
	if item.has("region") and item.has("atlas"):
		IconRect_path.texture = DataHandler.icon_atlas[item.atlas].duplicate()
		IconRect_path.texture.region = Rect2(item.region.x, item.region.y, item.region.width, item.region.height)
	else:
		var Icon_path = "res://inventory/assets/" + item["Name"] + ".png"
		IconRect_path.texture = load(Icon_path)
	for grid in DataHandler.item_grid_data[str(load_item_id)]:
		var converter_array : Array[int] = []
		for i in grid.split(','):
			converter_array.push_back(int(i))
		item_grid.push_back(converter_array)
		
func rotate_item() -> void:
	if item_grid.size() == 1: return
	# rotate the slot grid that the item occupies
	for grid in item_grid:
		grid.reverse()
		grid[0] = -grid[0]
	# Rotate the icon
	rotation_degrees += 90
	if rotation_degrees >= 360 :
		rotation_degrees = 0

func snap_to(destination: Vector2):
	var tween = get_tree().create_tween()
	if int(rotation_degrees) % 180 == 0:
		destination += IconRect_path.size/2
	else:
		var temp_xy = Vector2(IconRect_path.size.y, IconRect_path.size.x)
		destination += temp_xy/2
	
	tween.tween_property(self, "global_position", destination, 0.15).set_trans(Tween.TRANS_SINE)
	selected = false
