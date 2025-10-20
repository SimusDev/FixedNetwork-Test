extends Resource
class_name R_ViewModel

static var _placeholder: R_ViewModel = preload("res://viewmodels/placeholder.tres")

@export var list: Array[R_View3D] = []

static func get_placeholder() -> R_ViewModel:
	return _placeholder
