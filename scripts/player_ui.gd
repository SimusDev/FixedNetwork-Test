extends Control

@onready var health_bar:ProgressBar = get_node("health_bar")
@onready var health_value:Label = health_bar.get_node("health_value")

@onready var mana_bar:ProgressBar = get_node("mana_bar")
@onready var mana_value:Label = mana_bar.get_node("mana_value")

var player:Player

func _ready() -> void:
	if is_multiplayer_authority():
		player = Player.local

func update() -> void:
	if not is_instance_valid(player):
		player = Player.local
		return
	
	set_bar_values(health_bar, health_value, player.health_component.health_points,
		player.health_component.max_health_points)
	set_bar_values(mana_bar, mana_value, player.mana_component.mana_points,
		player.mana_component.max_mana_points)

func set_bar_values(bar:ProgressBar, label:Label, val, max_val) -> void:
	bar.max_value = max_val
	
	var val_snapped = str(snappedf(val, 0.1))
	var max_val_snapped = str(snappedf(max_val, 0.1))
	
	var format_text:String = "%s / %s" % [val_snapped, max_val_snapped]
	label.text = format_text

func _process(_delta: float) -> void:
	update()
