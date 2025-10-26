extends RayCast3D
class_name EntityRayCast3D

@export var root: Node

func _ready() -> void:
	SD_Network.register_object(self)
	SD_Network.register_functions([
		_interact_server,
		_interact_net,
	])
	
	if !root:
		root = get_parent()
	
	SD_Components.append_to(root, self)

func try_interact() -> void:
	if not SD_Network.is_authority(self):
		return
	
	SD_Network.call_func_on_server(_interact_server)

func _interact_server() -> void:
	SD_Network.call_func(_interact_net)

func _interact_net() -> void:
	pass
