extends Control
# Attach to the button/control used as the draggable titlebar.

var dragging: bool = false
var last_global_mouse_pos: Vector2 = Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	# Make sure the control actually receives input: mouse_filter must not be "Ignore".
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				# record the mouse position in global/screen space
				last_global_mouse_pos = Input.get_global_mouse_position()
				# optionally grab the mouse so we keep getting motion events even if cursor leaves control
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				# debug
				# print("drag start", last_global_mouse_pos)
			else:
				dragging = false
				# print("drag end")
	elif event is InputEventMouseMotion and dragging:
		var cur = Input.get_global_mouse_position()
		var delta = cur - last_global_mouse_pos
		last_global_mouse_pos = cur

		# current window pos (may be Vector2i) -> ensure Vector2
		var win_pos = DisplayServer.window_get_position()
		# convert if needed
		if typeof(win_pos) == TYPE_INT_VECTOR2:
			win_pos = Vector2(win_pos.x, win_pos.y)

		DisplayServer.window_set_position(win_pos + delta)
