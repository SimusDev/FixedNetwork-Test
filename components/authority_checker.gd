class_name AuthorityChecker extends Node

@export var target:Node
@export var dict:Dictionary[String, Variant] = {
	
}

func _ready() -> void:
	update()

func update() -> void:
	if not SD_Network.is_authority(target):
		return
	
	var keys = dict.keys()
	var count:int = 0
	for value in dict.values():
		print("key: %s, value: %s" % [keys[count], value])
		print("get: %s" %  target.get(keys[count]))
		
		target.set(keys[count], value)
		count += 1
