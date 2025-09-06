class_name InventoryItem extends Resource

@export var item_name: String
@export var item_texture: Texture2D
@export var item_description: String
@export_enum(
	"1", 
	"2", 
	"3", "r", 
	"4", "L", "o", "~", 
	"5", "[", "b", "S", 
	"6", "6[", "B", "{", "6S"
) var item_shape = "1"
@export var item_weight: float = 1.0
@export var item_category: InventoryCategory
@export var item_is_unique: bool = false
