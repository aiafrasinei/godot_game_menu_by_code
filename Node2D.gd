extends Node2D

var font
var logo_tex
var menu_tex
var pop
var fullsceen = false
var vsync = false
var ob
var screen_halfx
var screen_halfy

# Called when the node enters the scene tree for the first time.
func _ready():
	font = load("res://fonts/OpenSans_Condensed-Regular.ttf")
	logo_tex = load("res://texs/icon.svg")
	menu_tex = load("res://texs/back.png")
	
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2
	
	# background texture
	var back = TextureRect.new()
	back.set_position(Vector2(0, 0))
	back.set_size(Vector2(get_viewport().size.x, get_viewport().size.y))
	back.texture = menu_tex
	add_child(back)
	
	# tab container and panels
	var psize = 400
	var panel_main = Panel.new()
	panel_main.set_position(Vector2(20, 20))
	panel_main.set_size(Vector2(psize, psize))
	panel_main.name = "Main"
	
	var panel_settings = Panel.new()
	panel_settings.set_position(Vector2(20, 20))
	panel_settings.set_size(Vector2(psize, psize))
	panel_settings.name = "Settings"
	
	var panel_help = Panel.new()
	panel_help.set_position(Vector2(20, 20))
	panel_help.set_size(Vector2(psize, psize))
	panel_help.name = "Help"
	
	var tabcont = TabContainer.new()
	tabcont.set_position(Vector2(20, 20))
	tabcont.set_size(Vector2(psize, psize))
	tabcont.add_child(panel_main)
	tabcont.add_child(panel_settings)
	tabcont.add_child(panel_help)
	
	# main
	var vflowcont_main = HFlowContainer.new()
	vflowcont_main.set_position(Vector2(10, 10))
	
	var newgame_button = Button.new()
	newgame_button.set_position(Vector2(10, 10))
	newgame_button.text = "New game"
	newgame_button.connect("pressed", self._load_game)
	vflowcont_main.add_child(newgame_button)
	
	var credits_button = Button.new()
	credits_button.set_position(Vector2(10, 60))
	credits_button.text = "Credits"
	credits_button.connect("pressed", self._show_credits)
	
	vflowcont_main.add_child(credits_button)
	
	var exit_button = Button.new()
	exit_button.set_position(Vector2(10, 110))
	exit_button.text = "Exit"
	exit_button.connect("pressed", self._exit_game)
	vflowcont_main.add_child(exit_button)
	
	tabcont.get_tab_control(0).add_child(vflowcont_main)
	
	# settings
	var vflowcont_settings = HFlowContainer.new()
	vflowcont_settings.set_position(Vector2(10, 10))
	
	ob = OptionButton.new()
	ob.add_item("1280x720")
	ob.add_item("1600x920")
	ob.add_item("1920x1080")
	
	ob.connect("item_selected", self._handle_resolution_change)
	
	var fullscreen = CheckBox.new()
	fullscreen.connect("pressed", self._handle_fullscreen)
	fullscreen.text = "fullscreen"
	
	vflowcont_settings.add_child(ob)
	vflowcont_settings.add_child(fullscreen)
	
	tabcont.get_tab_control(1).add_child(vflowcont_settings)
	
	# help
	var vflowcont_help = HFlowContainer.new()
	vflowcont_help.set_position(Vector2(10, 10))
	
	
	var desc = Label.new()
	desc.set_position(Vector2(10, 10))
	desc.set_size(Vector2(200, 200))
	desc.text = "Welcome! \nMenu example by code \nEasy to use and extend \n\n"
	vflowcont_help.add_child(desc)
	
	pop = AcceptDialog.new()
	pop.title = "Credits"
	pop.dialog_text = "Game Menu by Code"
	pop.set_position(Vector2(screen_halfx, screen_halfy))
	add_child(pop)
	
	var desc_link = LinkButton.new()
	desc_link.text = "Check the github repo"
	desc_link.connect("pressed", self._open_desc_link)
	desc_link.modulate = Color(0.7, 0.7, 0.9)
	vflowcont_help.add_child(desc_link)
	
	tabcont.get_tab_control(2).add_child(vflowcont_help)
	
	add_child(tabcont)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _exit_game():
	get_tree().quit()
	pass
	
func _load_game():
	get_tree().change_scene_to_file("res://game.tscn")
pass

func _show_credits():
	pop.popup()
pass

func _open_desc_link():
	OS.shell_open("https://github.com/aiafrasinei/godot_game_menu_by_code")
pass

func _handle_resolution_change(selected):
	var selection = ob.get_item_text(selected)
	if selection == "1920x1080":
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		get_viewport().size = Vector2i(1920, 1080)
	elif selection == "1600x920":
		DisplayServer.window_set_size(Vector2i(1600, 920))
		get_viewport().size = Vector2i(1600, 920)
	elif selection == "1280x720":
		DisplayServer.window_set_size(Vector2i(1280, 720))
		get_viewport().size = Vector2i(1280, 720)
		
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2
pass

func _handle_fullscreen():
	fullsceen = !fullsceen
	if fullsceen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2
pass

