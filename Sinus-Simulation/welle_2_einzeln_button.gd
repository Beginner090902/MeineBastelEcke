extends Button
var button_gedrückt := 0 

#func _ready():
	# Anfangszustand: Text, transparenter Hintergrund
	#self.add_theme_stylebox_override("normal", make_style(Color(0, 0, 0, 0)))  # Transparent

func _pressed():
	if button_gedrückt == 0:
		button_gedrückt = 1
	else:
		button_gedrückt = 0
	if button_gedrückt == 1:
		#Wenn gedrückt: Schwarzer Hintergrund
		self.add_theme_stylebox_override("normal", make_style(Color(0, 0, 0, 1)))
	else:
		self.add_theme_stylebox_override("normal", make_style(Color(0, 0, 0, 0.3)))


func make_style(bg_color: Color) -> StyleBoxFlat:
	var sb = StyleBoxFlat.new()
	sb.bg_color = bg_color
	sb.corner_radius_top_left = 8
	sb.corner_radius_top_right = 8
	sb.corner_radius_bottom_left = 8
	sb.corner_radius_bottom_right = 8
	return sb
