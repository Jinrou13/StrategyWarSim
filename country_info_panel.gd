extends Panel

@onready var label = $CountryNameLabel
@onready var close_button = $CloseButton

func _ready():
	print("Label:", label)
	print("Close Button:", close_button)

func show_country(country_name: String):
	label.text = country_name
	visible = true


	if close_button:
		close_button.pressed.connect(hide)
	else:
		push_error("CloseButton is missing!")


func _on_close_button_pressed():
	hide ()
	pass # Replace with function body.
