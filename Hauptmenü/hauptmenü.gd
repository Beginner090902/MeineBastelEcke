extends Control




func _on_gotosettings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings/settings_scren.tscn")


func _on_conwaysgameoflifetilemap_pressed() -> void:
	get_tree().change_scene_to_file("res://Conway`s-game-of-life-tilemap/conways_game_slow.tscn")


func _on_test_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test.tscn")
