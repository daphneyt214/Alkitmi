extends Button

@onready var window := get_window()
var dragging := false

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
			else:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		window.position += Vector2i(event.relative)

