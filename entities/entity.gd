extends CharacterBody3D
class_name Entity

signal stats_change

@export var stats_resource:R_EntityStats

@export_category("References")
@export var model:AnimatedModel
@export var state_machine:SD_NodeStateMachine

@export var health_component:HealthComponent
@export var mana_component:ManaComponent


var blend_position:Vector2 = Vector2.ZERO
var unit_velocity:Vector3 = Vector3.ZERO

var strength:float = 10.0 : set = set_strength
var agility:float = 10.0 : set = set_agility
var intelligence:float = 10.0 : set = set_intelligence

var move_speed:float = 300.0

func _ready() -> void:
	stats_change.connect(update_stats)
	update_stats()

func set_strength(value:float) -> void:
	strength = value
	stats_change.emit()
func set_agility(value:float) -> void:
	agility = value
	stats_change.emit()
func set_intelligence(value:float) -> void:
	intelligence = value
	stats_change.emit()

func get_max_health() -> float:
	return stats_resource.health + (stats_resource.health_per_strength * strength)
func get_health_regen() -> float:
	return stats_resource.health_regen_per_strength * strength

func get_max_mana() -> float:
	return stats_resource.mana + (stats_resource.mana_per_intelligence * intelligence)
func get_mana_regen() -> float:
	return stats_resource.mana_regen_per_intelligence * intelligence

func update_stats() -> void:
	if is_instance_valid(health_component):
		health_component.max_health_points = get_max_health()
	if is_instance_valid(mana_component):
		mana_component.max_mana_points = get_max_mana()

func regen_health(delta:float) -> void:
	if is_instance_valid(health_component):
		health_component.apply_health( (stats_resource.health_regen_per_strength * strength) * delta )
func regen_mana(delta:float) -> void:
	if is_instance_valid(mana_component):
		mana_component.apply_replenish( (stats_resource.mana_regen_per_intelligence * intelligence) * delta )


func _physics_process(delta: float) -> void:
	unit_velocity = velocity.normalized() * transform.basis
	blend_position = Vector2(unit_velocity.x, -unit_velocity.z)

	regen_health(delta)
	regen_mana(delta)
