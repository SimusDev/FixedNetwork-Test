extends Node
class_name ItemStack

@export var object: R_Object

@export var _parameters: Dictionary = {
	"q": 1,
}

static func create_from_object(reference: R_Object) -> ItemStack:
	if not SD_Network.is_server():
		return null
	
	var stack := ItemStack.new()
	stack.object = reference
	return stack

func get_slot() -> InventorySlot:
	return get_parent()

func get_inventory() -> Inventory:
	return get_slot().get_inventory()

func _enter_tree() -> void:
	name = name.validate_node_name()
	
	get_slot()._item = self
	get_slot().on_item_added.emit(self)
	get_inventory().on_item_added.emit(self)

func _exit_tree() -> void:
	get_slot()._item = null
	get_slot().on_item_removed.emit(self)
	get_inventory().on_item_removed.emit(self)

func serialize() -> Dictionary:
	var data: Dictionary = {}
	data.id = object.id
	data.p = _parameters
	data.n = name
	_serialize_custom(data)
	return data

func _serialize_custom(data: Dictionary) -> void:
	pass

static func deserialize(data: Dictionary) -> ItemStack:
	var stack := ItemStack.new()
	stack.name = data.n
	stack._parameters = data.p
	stack.object = R_Object.find_by_id(data.id)
	_deserialize_custom(data, stack)
	return stack

static func _deserialize_custom(data: Dictionary, stack: ItemStack) -> void:
	pass
