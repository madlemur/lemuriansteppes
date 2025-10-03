class_name Inventory extends Resource

signal item_added(item, qty, total)
signal item_removed(item, qty, total)

@export var max_capacity : int = 1
@export var items : Array[Item] = []

func _init(cap : int = 1):
	max_capacity = cap

func find(item : Item) -> Item:
	var _id : int
	if item is Gem:
		var _items = items.filter(
			func(_item: Item):
				return _item is Gem and _item.type == item.type and _item.quality == item.quality				
		)
	else:
		_id = items.find(item)
	if _id != -1:
		return items[_id]
	return
	
func add(item: Item, qty: int = 1) -> void:
	var i = find(item)
	
	if !i:
		items.append(item)
		item.inventory = self
		i = item
		i.quantity = qty
		item_added.emit(i, qty, i.quantity)
	elif i.max_stack > 1 :
		i.quantity += qty
		item_added.emit(i, qty, i.quantity)
