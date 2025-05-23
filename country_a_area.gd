extends Area2D

@export var country_name: String = "England"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("%s clicked!" % country_name)

		# Show the country info panel
		var panel = get_tree().root.get_node("WorldMap/UI/CountryInfoPanel")
		panel.show_country(country_name)

		# Focus the camera on this country
		var camera = get_tree().root.get_node("WorldMap/MainCamera")  # <-- Update the path if needed
		camera.focus_on(global_position)
