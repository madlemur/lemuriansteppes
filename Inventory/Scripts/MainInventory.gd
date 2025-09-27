@tool
class_name MainInventory extends Control

const ITEM_ICON_SIZE : Vector2 = Vector2(32,32)
const ITEM_RESOURCE_PATH : String = "res://Inventory/Resources"

const database_path : String = "res://database.db"
const item_table : String = "item_tbl"
const category_table : String = "category_tbl"
@onready var item_type : Resource = ResourceLoader.load("res://addons/madlemur/grid_inventory/Scripts/InventoryItem.gd")
@onready var category_type : Resource = ResourceLoader.load("res://addons/madlemur/grid_inventory/Scripts/InventoryCategory.gd")


func _enter_tree() -> void:
	#print(typeof(self.item_type.item_name))
	pass
	
static func getItem(_id):
	return null
