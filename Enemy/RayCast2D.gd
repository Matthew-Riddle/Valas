extends RayCast2D

signal s_jump

var on_ground = true

func set_ground_flag(flag):
	on_ground = flag

func _ready():
	pass # Replace with function body.

var old = "right"
func on_dir_change(facing):
	if facing != old:
		cast_to.x = -cast_to.x
	old = facing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	if is_colliding():
		if owner.is_on_floor():
			emit_signal("s_jump")

func _draw():
#	draw_circle(position - Vector2(position.x,0), 3.0, Color.white)
	var temp = position
	temp.y = temp.y - 5
	draw_line(temp, cast_to, Color.white, 3.0)
	pass
