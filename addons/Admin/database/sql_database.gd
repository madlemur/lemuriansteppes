@tool
class_name sql_database extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("database", "./DatabaseConfig.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("database")
