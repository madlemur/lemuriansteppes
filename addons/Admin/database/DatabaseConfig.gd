@tool
class_name DatabaseConfig extends Resource

@export var filename : String = "res://database.db"
@export var foreign_keys : bool = false
@export var read_only : bool = true
@export var in_memory : bool = false
static var database : SQLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	if in_memory :
		database.path = ":memory:"
	else :
		database.path = filename
	database.foreign_keys = foreign_keys
	database.read_only = read_only
	database.open_db()

## Repack the database tables to ensure efficiency (utilizes the vacuum function of SQLite)
## Mostly for use during development when the tables may be in the most flux. A database is
## likely not the best solution for in-game data.
func repack_tables() -> void:
	database.query("VACUUM")
