class_name Weapon extends Gear

@export var weapon_type : WeaponType = WeaponType.CLUB :
	set(type):
		if type in two_handed_types:
			is_2handed = true
		weapon_type = type
@export var weapon_material : ItemMaterial = ItemMaterial.WOOD
@export var is_2handed : bool = false :
	set(is2h):
		# Certain types of weapons are ALWAYS two-handed...
		if not is2h and weapon_type in two_handed_types:
			push_warning("Cannot set 1-handed for Weapon Type ", WeaponType.keys()[weapon_type].capitalize())
			is_2handed = true
		else:
			is_2handed = is2h

enum WeaponType {
	CLUB,
	AXE,
	SWORD,
	SPEAR,
	STAFF,
	BOW,
	DAGGER,
	WAND,
	POLEARM,
	SLING,
	JAVELIN,
	CROSSBOW,
	OFFHAND,
}

## There are certain types of weapons that are always two-handed, either by nature of their size, or
## because they require the use of both hands to properly manipulate.
const two_handed_types : Array[WeaponType] = [
	WeaponType.STAFF,
	WeaponType.BOW,
	WeaponType.POLEARM,
	WeaponType.SLING,
	WeaponType.CROSSBOW,
]
