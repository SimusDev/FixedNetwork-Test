extends R_Object
class_name R_WorldObject

@export var viewmodel: R_ViewModel

func register() -> void:
	if not viewmodel:
		viewmodel = R_ViewModel.get_placeholder()
	
	super()

func unregister() -> void:
	super()
