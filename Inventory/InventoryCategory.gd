class_name InventoryCategory extends Node

@export var category_name: String
@export var category_sprite: Sprite2D
@export var category_has_subcategories: bool = false
@export var subcategories: Array[InventoryCategory] = []

var category_loader: ResourceFormatLoader
