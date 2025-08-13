extends Control




func _on_gotosettings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings/settings_scren.tscn")
