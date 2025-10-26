class_name PlayerCanvas extends CanvasLayer

@export var ui_scene:PackedScene

func _ready() -> void:
	if is_multiplayer_authority():
		var ui = ui_scene.instantiate()
		add_child(ui)
