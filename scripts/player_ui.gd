extends Control

@onready var health_bar:ProgressBar = get_node("health_bar")
@onready var health_value:ProgressBar = health_bar.get_node("health_value")

var player:Player

func _ready() -> void:
	pass

func update() -> void:
	if not is_instance_valid(player):
		return
	
	health_bar.max_value = 2


func _process(_delta: float) -> void:
	update()
