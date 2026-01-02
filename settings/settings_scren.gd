extends Control




func _on_auflösungaussuchen_item_selected(index: int) -> void:
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1280,720))
		2:
			DisplayServer.window_set_size(Vector2i(900,500))


func _on_scenexit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Hauptmenü/hauptmenü.tscn")





func _on_vollbild_pressed() -> void:
	if DisplayServer.window_get_mode() == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
