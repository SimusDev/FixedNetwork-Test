extends Node
class_name Inventory

@export var root: Node

@export var debug: bool = false

@export var _slots: Array[InventorySlot] = []

func get_slots() -> Array[InventorySlot]:
	return _slots

func _ready() -> void:
	SD_Network.register_object(self)
	SD_Network.register_functions([
		_send,
		_recieve,
	])
	
	if not root:
		root = get_parent()
	
	SD_Components.append_to(root, self)
	
	if root is Player:
		Synchronization.create_state("inventory")
	
	if SD_Network.is_server():
		Synchronization.apply_state("inventory")
	else:
		for slot in _slots:
			slot.queue_free()
		
		SD_Network.call_func_on_server(_send)

func _send() -> void:
	var to_send: Array = []
	for slot in get_slots():
		to_send.append(slot.serialize())
	SD_Network.call_func_on(SD_Network.get_remote_sender_id(), _recieve, [SD_Variables.compress(to_send)])

func _recieve(serialized: PackedByteArray) -> void:
	for i in SD_Variables.decompress(serialized):
		var deserialized: InventorySlot = InventorySlot.deserialize(i)
		add_child(deserialized)
	
	Synchronization.apply_state("inventory")
