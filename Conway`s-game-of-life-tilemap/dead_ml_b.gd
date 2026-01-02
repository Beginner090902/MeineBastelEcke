extends Button

var active_color := Color(1, 1, 1, 1)    # weiß
var inactive_color := Color(0, 0, 0, 1)  # schwarz
var button := CONWAYSVARIABEL.dead_buton_l


func _ready():
	# Anfangszustand: Text, transparenter Hintergrund
	self.add_theme_stylebox_override("normal", make_style(inactive_color))
	


func _pressed():
	if button == 0:
		button = 1
	else:
		button = 0
	if button == 1:
		#Wenn gedrückt: Schwarzer Hintergrund
		self.add_theme_stylebox_override("normal", make_style(active_color))
	else:
		self.add_theme_stylebox_override("normal", make_style(inactive_color))


func make_style(bg_color: Color) -> StyleBoxFlat:
	var sb = StyleBoxFlat.new()
	sb.bg_color = bg_color
	return sb
