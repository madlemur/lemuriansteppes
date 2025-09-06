@tool
class_name InventoryCategory extends Resource

## Short name of the category
@export var category_name: String
## Texture for the category
@export var category_texture: Texture
## Does the category have subcategories?
@export var category_has_subcategories: bool = false
## What is the parent category?
@export var parent_category: InventoryCategory = null:
	set(parent):
		self.parent_category = parent
		self.can_equip = parent.can_equip
		self.can_consume = parent.can_consume
		self.can_use = parent.can_use
## Can the items in the category be equipped?
@export var can_equip: bool = false
## Can the items in the category be consumed?
@export var can_consume: bool = false
## Can the items in the category be used?
@export var can_use: bool = false

func getName() -> String:
	return category_name
	
func getTexture() -> Texture:
	return category_texture

func hasSubcategories() -> bool:
	return category_has_subcategories
	
func getParentCategory() -> InventoryCategory:
	return parent_category
	
func canEquip() -> bool:
	return can_equip
	
func canConsume() -> bool:
	return can_consume
	
func canUse() -> bool:
	return can_use
