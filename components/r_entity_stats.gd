class_name R_EntityStats extends Resource

enum Attribute {
	STRENGTH = 0,
	AGILITY,
	INTELLGIGENCE
} 

@export_category("Attribute")
@export var main_attribute:Attribute = Attribute.STRENGTH
@export var strength:float = 10.0
@export var agility:float = 10.0
@export var intelligence:float = 10.0

@export_category("Base Stats")
@export var health:float = 350.0
@export var mana:float = 150.0
@export var move_speed:float = 300.0

@export_category("")
@export var health_per_strength:float = 22.0
@export var health_regen_per_strength:float = 0.1

@export var armor_per_agility:float = 0.167
@export var attack_speed_per_agility:float = 1.0

@export var mana_per_intelligence:float = 12.0
@export var mana_regen_per_intelligence:float = 0.05
@export var magic_resistance_per_intelligence:float = 0.001
