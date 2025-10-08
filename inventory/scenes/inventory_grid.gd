extends Control

## Item and InvSlot are a couple of barebones control scenes to give the scripts something to grab
## on to when creating and manipulating a grid inventory.
@onready var slot_scene = preload("uid://nvl6g4cxlmfh") # InvSlot.tscn
@onready var item_scene = preload("uid://duf1fjmxumhxj") # Item.tscn
@onready var scroll_container: ScrollContainer = $BGColor/MarginContainer/VBoxContainer/ScrollContainer
@onready var grid_container: GridContainer = $BGColor/MarginContainer/VBoxContainer/ScrollContainer/GridContainer
@onready var col_count: int = grid_container.columns

@export var inventory : Inventory

var grid_array : Array = []
var item_held = null
var current_slot = null
var can_place := false
var icon_anchor : Vector2

func _ready() -> void:
	for i in range(36) :
		create_slot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func create_slot() -> void:
	var new_slot = slot_scene.instantiate()
	new_slot.slot_id = grid_array.size()
	grid_array.push_back(new_slot)
	grid_container.add_child(new_slot)
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
	var new_item = item_scene.instantiate()
	add_child(new_item)
	new_item.load_item(1)
	new_item.selected = true
	item_held = new_item


func check_slot_availability(a_slot) -> void:
	for grid in item_held.item_grid:
		var grid_to_check = a_slot.slot_id + grid[0] + grid[1] * col_count
		var line_switch_check = a_slot.slot_id % col_count + grid[0]
		if line_switch_check < 0 or line_switch_check >= col_count:
			can_place = false
			return
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			can_place = false
			return
		if grid_array[grid_to_check].state == grid_array[grid_to_check].States.TAKEN:
			can_place = false
			return
		can_place = true
		
func set_grid(a_slot) -> void:
	for grid in item_held.item_grid:
		var grid_to_check = a_slot.slot_id + grid[0] + grid[1] * col_count
		var line_switch_check = a_slot.slot_id % col_count + grid[0]
		if line_switch_check < 0 or line_switch_check >= col_count:
			continue
		if grid_to_check < 0 or grid_to_check >= grid_array.size():
			continue
		if can_place:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.FREE)
			if grid[1] < icon_anchor.x: icon_anchor.x = grid[1]
			if grid[0] < icon_anchor.y: icon_anchor.y = grid[0]
		else:
			grid_array[grid_to_check].set_color(grid_array[grid_to_check].States.TAKEN)

func clear_grid() -> void:
	for grid in grid_array:
		grid.set_color(grid.States.DEFAULT)
