extends Node3D
class_name GameWorld3D

func _ready() -> void:
	SD_Network.register_object(self)
	
	
