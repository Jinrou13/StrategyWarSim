extends Area2D

@export var country_name: String = "England"  # Customize per country in Inspector

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("%s clicked!" % country_name)
		print("My position is:", global_position)

		# Show the country info panel
		var panel = get_tree().root.get_node("WorldMap/UI/CountryInfoPanel")
		panel.show_country(country_name)

		# Tell the camera to zoom + pan to this country
		var camera = get_tree().root.get_node("WorldMap/MainCamera")
		if camera:
			camera.focus_on(global_position)
		else:
			push_error("❌ Could not find camera node at 'WorldMap/MainCamera'")
