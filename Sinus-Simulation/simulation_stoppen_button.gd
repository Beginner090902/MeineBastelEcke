extends CheckButton




func _on_pressed() -> void:
	if SinusWellen.simulatoin_anhalten == 0:
		SinusWellen.simulatoin_anhalten = 1
	else:
		SinusWellen.simulatoin_anhalten = 0
