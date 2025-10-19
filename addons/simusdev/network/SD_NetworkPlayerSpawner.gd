@icon("res://addons/simusdev/icons/MultiplayerSpawner.svg")
extends Node
class_name SD_NetworkPlayerSpawner

@export var root: Node
@export var scenes: Array[PackedScene] = []
@export var spawnpoints: Array[Node] = []

@export_group("Custom")
@export var spawner: SD_NetworkSpawner

func _ready() -> void:
	if not root:
		root = get_parent()
	
	if not spawner:
		spawner = SD_NetworkSpawner.new()
		spawner.sync_at_start = false
		spawner.name = "spawner"
		add_child(spawner)
	
	spawner.sync_at_start = false
	
	spawner.register(root)
	
	if SD_Network.is_server():
		SD_Network.singleton.on_player_connected.connect(_on_player_connected)
		SD_Network.singleton.on_player_disconnected.connect(_on_player_disconnected)
		_on_player_connected(SD_NetworkPlayer.get_local())
	
	spawner.synchronize_all()

func pick_prefab() -> PackedScene:
	if scenes.is_empty():
		return null
	return scenes.pick_random()

func _teleport_node(node: Node, to: Node) -> void:
	if is_instance_valid(node) and is_instance_valid(to):
		if "transform" in node and "transform" in to:
			node.global_position = to.global_position

func pick_spawnpoint() -> Node:
	if spawnpoints.is_empty():
		return null
	return spawnpoints.pick_random()

func _on_player_connected(player: SD_NetworkPlayer) -> void:
	var prefab: PackedScene = pick_prefab()
	if not prefab:
		return
	
	var instance: Node = prefab.instantiate()
	player.set_in(instance)
	instance.name = str(player.get_peer_id())
	root.add_child(instance)
	_teleport_node(instance, pick_spawnpoint())

func _on_player_disconnected(player: SD_NetworkPlayer) -> void:
	var node: Node = player.get_player_node()
	if is_instance_valid(node):
		node.queue_free()
