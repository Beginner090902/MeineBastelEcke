extends Button


func _ready():
	# Anfangszustand: Text, transparenter Hintergrund
	self.add_theme_stylebox_override("normal", make_style(Color(0, 0, 0, 1)))
	


func _pressed():
	if  CONWAYSVARIABEL.dead_buton_t == 0:
		CONWAYSVARIABEL.dead_buton_t = 1
	else:
		CONWAYSVARIABEL.dead_buton_t = 0
	if  CONWAYSVARIABEL.dead_buton_t == 1:
		#Wenn gedrückt: Schwarzer Hintergrund
		self.add_theme_stylebox_override("normal", make_style(Color(255, 255, 255, 1)))
	else:
		self.add_theme_stylebox_override("normal", make_style(Color(0, 0, 0, 1)))


func make_style(bg_color: Color) -> StyleBoxFlat:
	var sb = StyleBoxFlat.new()
	sb.bg_color = bg_color
	return sb
