extends Control

@onready var ip_line:LineEdit = $settings/mp/VBoxContainer/ip

@export var port: int = 7856

func _on_button_pressed() -> void:
	create_client()

func _on_button_2_pressed() -> void:
	create_server()

func create_client() -> void:
	if ip_line.text == "":
		return
	
	SD_Network.create_client(ip_line.text, port)
	await SD_Network.singleton.on_connected_to_server
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func create_server() -> void:
	if ip_line.text == "":
		return
	
	SD_Network.create_server(port)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_nickname_text_changed(new_text: String) -> void:
	SD_Network.singleton.set_nickname(new_text)


func _on_port_text_submitted(new_text: String) -> void:
	port = int(new_text)
