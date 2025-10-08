class_name Storage extends Gear

@export var storage_type : StorageType = StorageType.POUCH
@export var can_equip : bool = false
@export var attachments : int = 0 # Number of attachment points needed
@export var slots : int = 1 # Number of slots added

## In general, these are in order from smallest to largest, and they can nest
## inside a larger item. Opening a nested item is NOT an allowed fast action, and
## has consequences in combat.
enum StorageType {
	POUCH,	# Can be attached to clothes for fast access
	SACK,	# Carried in inventory. Could include small lockboxes.
	PACK,	# Can be equipped for fast access
	CRATE,	# Very large, impacts movement. Includes chests.
}

var allowed_materials : Dictionary[StorageType, Array] = {
	StorageType.POUCH: [
		{ ItemMaterial.CLOTH: .75 }, 
		{ ItemMaterial.SILK: .15 }, 
		{ ItemMaterial.LEATHER: .85 }, 
		{ ItemMaterial.HORN: .05 },
	],
	StorageType.SACK:  [
		{ ItemMaterial.CLOTH: .9 }, 
		{ ItemMaterial.SILK: .05 }, 
		{ ItemMaterial.LEATHER: .25 },
	],
	StorageType.PACK:  [
		{ ItemMaterial.CLOTH: .25 }, 
		{ ItemMaterial.SILK: .01 }, 
		{ ItemMaterial.LEATHER: .85 },
	],
	StorageType.CRATE: [
		{ ItemMaterial.WOOD: .85 }, 
		{ ItemMaterial.COPPER: .2 }, 
		{ ItemMaterial.BRONZE: .15 }, 
		{ ItemMaterial.IRON: .35 }, 
		{ ItemMaterial.STEEL: .15 }, 
		{ ItemMaterial.ADAMANTINE: .01 }, 
		{ ItemMaterial.SILVER: .05 }, 
		{ ItemMaterial.GOLD: .02 }, 
		{ ItemMaterial.CRYSTAL: .005 },
	],
}

const category : Category = Category.GEAR
const type : Type = Type.STORAGE

func _get_type() -> String:
	return StorageType.keys()[storage_type].capitalize()
