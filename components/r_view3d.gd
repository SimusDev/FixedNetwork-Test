extends Resource
class_name R_View3D

enum TYPE {
	WORLD,
	FIRST_PERSON,
	THIRD_PERSON,
}

@export var type: TYPE = TYPE.WORLD
@export var prefab: PackedScene
@export var mesh: Mesh

@export var position: Vector3 = Vector3.ZERO
@export var rotation: Vector3 = Vector3.ZERO
@export var scale: Vector3 = Vector3.ONE
