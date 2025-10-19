extends Control

@export var port: int = 7856

func _on_button_pressed() -> void:
	SD_Network.create_client($LineEdit.text, port)
	await SD_Network.singleton.on_connected_to_server
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_2_pressed() -> void:
	SD_Network.create_server(port)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
