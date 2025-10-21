extends Node
class_name Inventory

@export var root: Node

func _ready() -> void:
	if not root:
		root = get_parent()

func network_call_func_on(peer: int, callable: Callable, args: Array = [], callmode: SD_Network.CALLMODE = SD_Network.CALLMODE.RELIABLE, channel: String = SD_NetTrunkCallables.CHANNEL_DEFAULT) -> void:
	_inventory

func network_call_func(callable: Callable, args: Array = [], callmode: SD_Network.CALLMODE = SD_Network.CALLMODE.RELIABLE, channel: String = SD_NetTrunkCallables.CHANNEL_DEFAULT) -> void:
	_inventory

func network_call_func_except_self(callable: Callable, args: Array = [], callmode: SD_Network.CALLMODE = SD_Network.CALLMODE.RELIABLE, channel: String = SD_NetTrunkCallables.CHANNEL_DEFAULT) -> void:
	_inventory

func network_call_func_on_server(callable: Callable, args: Array = [], callmode: SD_Network.CALLMODE = SD_Network.CALLMODE.RELIABLE, channel: String = SD_NetTrunkCallables.CHANNEL_DEFAULT) -> void:
	_inventory
