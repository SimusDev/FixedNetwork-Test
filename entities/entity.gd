extends CharacterBody3D
class_name Entity

var blend_position:Vector2 = Vector2.ZERO
var unit_velocity:Vector3 = Vector3.ZERO

@export var model:AnimatedModel

func _physics_process(_delta: float) -> void:
	unit_velocity = velocity.normalized() * transform.basis
	blend_position = Vector2(unit_velocity.x, -unit_velocity.z)
