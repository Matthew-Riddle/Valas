extends Position2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	update()

func _draw():
	draw_circle(get_tree().get_root().get_node("World").get_global_mouse_position(), 3.0, Color.white)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
