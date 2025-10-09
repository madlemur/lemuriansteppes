class_name InventoryGrid extends Control

## Item and InvSlot are a couple of barebones control scenes to give the scripts something to grab
## on to when creating and manipulating a grid inventory.
@onready var scroll_container: ScrollContainer = $BGColor/MarginContainer/VBoxContainer/ScrollContainer
@onready var item_grid: GridContainer = $BGColor/MarginContainer/VBoxContainer/ScrollContainer/PanelContainer/ItemGrid
@onready var status_grid: GridContainer = $BGColor/MarginContainer/VBoxContainer/ScrollContainer/PanelContainer/StatusGrid
@onready var col_count: int = item_grid.columns

const INVENTORY_FILTER = preload("uid://d2abr6edilasy")
const INVENTORY_SLOT = preload("uid://nvl6g4cxlmfh")
const INVENTORY_ITEM = preload("uid://duf1fjmxumhxj")

@export var inventory : Inventory

var grid_array : Array[InventorySlot] = []
var filter_array : Array[InventoryFilter] = []
var item_held : InventoryItem = null
var current_slot = null
var can_place := false
var icon_anchor : Vector2

func _ready() -> void:
	for i in range(36) :
		create_slot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if item_held:
		if Input.is_action_just_pressed("Rotate Item"):
			rotate_item()
		if Input.is_action_just_pressed("Left Mouse Click"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				place_item()
			
	else:
		if Input.is_action_just_pressed("Left Mouse Click"):
			if scroll_container.get_global_rect().has_point(get_global_mouse_position()):
				pick_item()
	
func create_slot() -> void:
	var new_slot = INVENTORY_SLOT.instantiate()
	var new_filter = INVENTORY_FILTER.instantiate()
	new_slot.slot_id = grid_array.size()
	new_filter.slot_id = filter_array.size()
	grid_array.push_back(new_slot)
	filter_array.push_back(new_filter)
	item_grid.add_child(new_slot)
	status_grid.add_child(new_filter)
	new_slot.slot_entered.connect(_on_slot_entered)
	new_slot.slot_exited.connect(_on_slot_exited)
	
## If dragging an Item, check the underlying slots to see if the item will fit into availble empty
## slot(s). If so, highlight as FREE, otherwise, highlight as TAKEN
func _on_slot_entered(a_slot):
	icon_anchor = Vector2(10000, 10000)
	current_slot = a_slot
	if item_held:
		check_slot_availability(current_slot)
		set_grid.call_deferred(current_slot)
	
## Reset highlighting to DEFAULT
func _on_slot_exited(_a_slot):
	if item_held:
		clear_grid()

func _on_button_pressed() -> void:
	var new_item = INVENTORY_ITEM.instantiate()
	add_child(new_item)
	new_item.load_item(randi_range(1,4))
	new_item.selected = true
	item_held = new_item
	item_held.modulate = 0xffffff66

func check_slot_availability(a_slot) -> void:
	for grid in item_held.item_grid:
		# grid slot you are checking
		var grid_to_check = a_slot.slot_id + grid[0] + grid[1] * col_count
		# X position of the grid slot you are checking (ignoring Y position)
		var line_switch_check = a_slot.slot_id % col_count + grid[0]
		# Is the grid slot within the bounds of the row
		if line_switch_check < 0 or line_switch_check >= col_count:
			can_place = false
			return
		# is the grid slot within the bounds of the entire grid
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			can_place = false
			return
		# Is there something already in the slot
		# TODO: Check for stackable items
		if grid_array[grid_to_check].state == InventorySlot.State.TAKEN:
			can_place = false
			return
		can_place = true
		
func set_grid(a_slot) -> void:
	for grid in item_held.item_grid:
		# grid slot you are checking
		var grid_to_check = a_slot.slot_id + grid[0] + grid[1] * col_count
		# X position of the grid slot you are checking (ignoring Y position)
		var line_switch_check = a_slot.slot_id % col_count + grid[0]
		# Is the grid slot within the bounds of the row
		if line_switch_check < 0 or line_switch_check >= col_count:
			continue
		# is the grid slot within the bounds of the entire grid
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			continue
		if can_place:
			filter_array[grid_to_check].set_filter(InventorySlot.State.FREE)
			if grid[0] < icon_anchor.x: icon_anchor.x = grid[0]
			if grid[1] < icon_anchor.y: icon_anchor.y = grid[1]
		else:
			filter_array[grid_to_check].set_filter(InventorySlot.State.TAKEN)

func clear_grid() -> void:
	for grid in filter_array:
		grid.set_filter(InventorySlot.State.DEFAULT)

func rotate_item():
	item_held.rotate_item()
	clear_grid()
	if current_slot:
		_on_slot_entered(current_slot)

func place_item():
	if not can_place or not current_slot:
		return
		
	var calculated_grid_id = current_slot.slot_id + icon_anchor.x + icon_anchor.y * col_count
	item_held.snap_to(grid_array[calculated_grid_id].global_position)
	item_held.modulate = 0xffffffff
	
	item_held.get_parent().remove_child(item_held)
	item_grid.add_child(item_held)
	item_held.global_position = get_global_mouse_position()

	item_held.grid_anchor = current_slot
	for grid in item_held.item_grid:
		var grid_to_check = current_slot.slot_id + grid[0] + grid[1] * col_count
		grid_array[grid_to_check].state = InventorySlot.State.TAKEN
		grid_array[grid_to_check].item_stored = item_held
		
	item_held = null
	clear_grid()

func pick_item():
	if not current_slot or not current_slot.item_stored:
		return
	
	item_held = current_slot.item_stored
	item_held.selected = true
	
	item_held.get_parent().remove_child(item_held)
	add_child(item_held)
	item_held.global_position = get_global_mouse_position()
	item_held.modulate = 0xffffff66

	
	for grid in item_held.item_grid:
		var grid_to_check = item_held.grid_anchor.slot_id + grid[0] + grid[1] * col_count
		grid_array[grid_to_check].state = InventorySlot.State.FREE
		grid_array[grid_to_check].item_stored = null
		
	check_slot_availability(current_slot)
	set_grid.call_deferred(current_slot)
