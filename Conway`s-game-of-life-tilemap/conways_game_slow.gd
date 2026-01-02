extends Control



var img: Image
var tex: ImageTexture

var time_sins_last_frame = 0
var simulation_speed_in_seconds := 0.5
@onready var rect: TextureRect = find_child("CanvasRect")

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

func Get_Breite(Pixel):
	var Breite = int(sqrt(CONWAYSVARIABEL.Pixel))
	return Breite
	
func Simulation():	
	for x in Get_Breite(CONWAYSVARIABEL.Pixel):
		for y in Get_Breite(CONWAYSVARIABEL.Pixel):
			img.get_pixel(x,y)

func _ready():
	img = Image.create(Get_Breite(CONWAYSVARIABEL.Pixel), Get_Breite(CONWAYSVARIABEL.Pixel), false, Image.FORMAT_RGBA8)
	img.fill(Color.BLACK)
	img.set_pixel(Get_Breite(CONWAYSVARIABEL.Pixel)/2 , Get_Breite(CONWAYSVARIABEL.Pixel) / 2, Color.WHITE)
	
	tex = ImageTexture.create_from_image(img)
	rect.texture = tex
	
	var color: Color  = img.get_pixel(1,0)
	print("Color", color)
	print("Check_color ", Check_collor(color))
	print("Check_top ", Check_top(1,0))


func _process(delta: float) -> void:

	time_sins_last_frame += delta
	if time_sins_last_frame < simulation_speed_in_seconds:
		return
	time_sins_last_frame = 0
	Simulation()
	print(Get_Breite(CONWAYSVARIABEL.Pixel))
