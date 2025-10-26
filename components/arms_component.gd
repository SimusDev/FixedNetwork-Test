class_name ArmsComponent extends Node

@export var ik_nodes:Array[SkeletonIK3D]
@export var activate_at_start:bool = true
@export var should_authority:bool = false

func _ready() -> void:
	if activate_at_start:
		if is_multiplayer_authority() or (not should_authority):
			for x:SkeletonIK3D in ik_nodes:
				x.start()
