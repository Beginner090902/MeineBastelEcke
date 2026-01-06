extends Control
var Debug_Level = 1
var Ready = false

var img: Image
var tex: ImageTexture
var time_sins_last_frame = 0


func Update_img():
	Resize_img()



func Logging(label: String, value) -> void:
	if Debug_Level >=1:
		# value wird automatisch in String umgewandelt
		print("[LOG] %s: %s" % [label, str(value)])

func Check_collor(color):
	if color.r == 0 and color.g == 0 and color.b == 0:
		return 0
	if color.r == 1 and color.g == 1 and color.b == 1:
		return 1
		
func Check_top(x, y):
		if Check_collor(img.get_pixel(x ,y-1)) == 1:
			return 1
		else:
			return 0
			
func Check_Top_Left(x,y):
	if Check_collor(img.get_pixel(x-1,y-1)) == 1:
		return 1
	else:
		return 0

func Check_Top_Right(x, y):
	if Check_collor(img.get_pixel(x+1,y-1)) == 1:
		return 1
	else:
		return 0

func Check_Left(x,y):
	if Check_collor(img.get_pixel(x-1,y)) == 1:
		return 1
	else:
		return 0
	
func Check_right(x, y):
	if Check_collor(img.get_pixel(x+1,y)) == 1:
		return 1
	else:
		return 0
		
func Check_Bottum_Left(x,y):
	if Check_collor(img.get_pixel(x-1,y+1)) == 1:
		return 1
	else:
		return 0

func Check_Bottum(x,y):
	if Check_collor(img.get_pixel(x,y+1)) == 1:
		return 1
	else:
		return 0
		
func Check_Bottum_Right(x,y):
	if Check_collor(img.get_pixel(x+1,y+1)) == 1:
		return 1
	else:
		return 0


func _ready():
	Ready = true

		
func Resize_img() -> void:
	if not is_inside_tree():
		Logging("Scene ist noch nicht geladen", false)
		return
	var rect: TextureRect = find_child("TextureRect")
	if rect == null:
		Logging("rect ist null – TextureRect nicht gefunden!", true)
		return
	Logging("rect ist gültig", true)
	Logging("Start Resize_img", true)
	Logging("Gesamt Pixel", CONWAYSVARIABEL.Pixel)
	if CONWAYSVARIABEL.Pixel <= 3:
		Logging("Keine Pixel zum Zeichnen", CONWAYSVARIABEL.Pixel)
		return
	CONWAYSVARIABEL.Breite = int(sqrt(CONWAYSVARIABEL.Pixel))
	Logging("Berechnete Breite des Bildes", CONWAYSVARIABEL.Breite)
	img = Image.create(CONWAYSVARIABEL.Breite, CONWAYSVARIABEL.Breite, false, Image.FORMAT_RGBA8)
	img.fill(Color.BLACK)
	img.set_pixel(CONWAYSVARIABEL.Breite/2 , CONWAYSVARIABEL.Breite / 2, Color.WHITE)
	tex = ImageTexture.create_from_image(img)
	rect.texture = tex
	Logging("Ende Resize_img", true)	



func _process(delta: float) -> void:
	pass



func _on_start_stop_button_pressed() -> void:
	if CONWAYSVARIABEL.Simulation_Status == false:
		CONWAYSVARIABEL.Simulation_Status = true
	else :
		CONWAYSVARIABEL.Simulation_Status = false
	Logging("Simulation Status",CONWAYSVARIABEL.Simulation_Status)



func _on_simulation_speed_edit_text_submitted(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^[0-9]*$")
	if regex.search(new_text):
		CONWAYSVARIABEL.simulation_speed_in_seconds = int(new_text)
		Logging("Simulations Speed Changed to ", CONWAYSVARIABEL.simulation_speed_in_seconds)


func _on_pixelanzahldersimulation_text_submitted(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^[0-9]*$")
	if regex.search(new_text):
		CONWAYSVARIABEL.Pixel = int(new_text)
		Update_img()


func _on_bild_lerren_pressed() -> void:
	Logging("Bild lerren gedrückt ", true)


func _on_run_or_stepmode_toggled(toggled_on: bool) -> void:
	Logging("Step oder Run Modus", toggled_on)
