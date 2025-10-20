extends Node3D
class_name Level3D

var _sections: Dictionary[String, LevelSection3D] = {}

func _ready() -> void:
	SD_Network.register_object(self)
	
	for tab in R_ObjectTab.get_reference_list():
		var section := LevelSection3D.new()
		section.name = tab.name
		_sections[tab.name] = section
		add_child(section)
	

func create_object(resource: R_Object) -> R_NodeReference:
	if not SD_Network.is_server():
		return null
	
	var ref: R_NodeReference = R_NodeReference.new()
	ref.object = resource
	return ref
