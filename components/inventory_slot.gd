extends Node
class_name InventorySlot

@export var _parameters: Dictionary = {}

var _item: ItemStack

func get_inventory() -> Inventory:
	return get_parent()

func get_item() -> ItemStack:
	return _item

func _enter_tree() -> void:
	name = name.validate_node_name()
	
	get_inventory()._slots.append(self)

func _exit_tree() -> void:
	get_inventory()._slots.erase(self)

func _ready() -> void:
	SD_Network.register_object(self)

func serialize() -> Dictionary:
	var data: Dictionary = {}
	data.n = name
	data.p = _parameters
	var classname: String = SD_Variables.get_class_from(self)
	if classname != "InventorySlot":
		data.c = SD_Variables.get_class_from(self)
	
	if get_item():
		data.i = get_item().serialize()
	
	return data

static func deserialize(data: Dictionary) -> InventorySlot:
	var slot: InventorySlot = SD_Variables.instantiate_class(data.get("c", "InventorySlot"))
	slot._parameters = data.p
	slot.name = data.n
	
	if data.has("i"):
		var itemstack: ItemStack = ItemStack.deserialize(data.i)
		slot._item = itemstack
		slot.add_child(itemstack)
	
	return slot
