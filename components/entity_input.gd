extends Node
class_name EntityInput

@export var interact_input: StringName = "interact"
@export var root: Node

var _raycast: EntityRayCast3D
var _node_input: SD_NodeInput

func _ready() -> void:
	SD_Network.register_object(self)
	SD_Network.register_functions([
		
	])
	
	if !root:
		root = get_parent()
	
	SD_Components.append_to(root, self)
	
	_raycast = SD_Components.find_first(root, EntityRayCast3D)
	
	if SD_Network.is_authority(self):
		_node_input = SD_NodeInput.new()
		_node_input.on_action_just_released.connect(_on_action_just_released)

func _on_action_just_released() -> void:
	pass
