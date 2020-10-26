extends RayCast2D

signal s_on_ground(flag)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	if is_colliding():
		emit_signal("s_on_ground", true)
	else:
		emit_signal("s_on_ground", false)

func _draw():
#	draw_circle(position - Vector2(position.x,0), 3.0, Color.white)
	draw_line(position, cast_to, Color.white, 3.0)
	pass
