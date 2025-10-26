extends R_Object
class_name R_UI

@export var scene: PackedScene

func get_default_tab() -> R_ObjectTab:
	return R_ObjectTab.get_by_name("ui")

func register() -> void:
	super()

func unregister() -> void:
	super()
