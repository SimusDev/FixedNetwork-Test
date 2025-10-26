class_name PlayerCanvas extends CanvasLayer

@export var ui_scene:PackedScene

static var instance: PlayerCanvas

func _ready() -> void:
	if is_multiplayer_authority():
		instance = self
		var ui = ui_scene.instantiate()
		add_child(ui)
