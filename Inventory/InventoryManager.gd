class_name InventoryManager extends Node

static var _singleton: InventoryManager = null
static var singleton: InventoryManager:
	get:
		return _singleton
		
func _init() -> void:
	if singleton == null:
		_singleton = self
	
