extends Node
class_name Inventory

@export var root: Node

@export var debug: bool = false

@export var _slots: Array[InventorySlot] = []

signal on_slot_added(slot: InventorySlot)
signal on_slot_removed(slot: InventorySlot)

signal on_item_added(slot: InventorySlot)
signal on_item_removed(slot: InventorySlot)

signal on_slot_selected(slot: InventorySlot)

signal on_initialized()

var _selected_slot: InventorySlot

func get_selected_slot() -> InventorySlot:
	return _selected_slot

func set_selected_slot(slot: InventorySlot) -> void:
	if SD_Network.is_server():
		SD_Network.call_func(_set_selected_slot_local, [slot.id])

func _set_selected_slot_local(id: int) -> void:
	_selected_slot = _slots.get(id)
	on_slot_selected.emit(_selected_slot)

func change_slot(to: InventorySlot) -> void:
	SD_Network.call_func_on_server(_change_slot_net, [to.id])

func _change_slot_net(id: int) -> void:
	set_selected_slot(_slots.get(id))

func get_slots() -> Array[InventorySlot]:
	return _slots

func _ready() -> void:
	SD_Network.register_object(self)
	SD_Network.register_functions([
		_send,
		_recieve,
		_change_slot_net,
		_set_selected_slot_local,
	])
	
	if not root:
		root = get_parent()
	
	SD_Components.append_to(root, self)
	
	if root is Player:
		#Synchronization.create_state("inventory")
		pass
	
	if SD_Network.is_server():
		
		_try_initialize()
		#Synchronization.apply_state("inventory")
		
	else:
		for slot in _slots:
			slot.queue_free()
		
		SD_Network.call_func_on_server(_send)

var initialized: bool = false

func _try_initialize() -> void:
	if initialized:
		return
	
	initialized = true
	on_initialized.emit()

func _send() -> void:
	var to_send: Array = []
	for slot in get_slots():
		to_send.append(slot.serialize())
	
	SD_Network.call_func_on(SD_Network.get_remote_sender_id(), _recieve, [SD_Variables.compress(to_send), get_selected_slot().id])

func _recieve(serialized: PackedByteArray, selected_slot_id: int) -> void:
	for i in SD_Variables.decompress(serialized):
		var deserialized: InventorySlot = InventorySlot.deserialize(i)
		add_child(deserialized)
	
	_selected_slot = _slots.get(selected_slot_id)
	
	_try_initialize()
	
	#Synchronization.apply_state("inventory")
	
