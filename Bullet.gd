extends RigidBody2D

onready var count = 0
onready var projectile_speed = 2000

func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	$Laser.play()
#	yield($Laser, "finished")
	

func _process(delta):
	count += 1
	if count >= 30000:
		self.queue_free()

func _physics_process(delta):
	linear_velocity.y += 109.8
	rotation = linear_velocity.angle()
	pass

func _on_Bullet_body_entered(body):
	if body.name != "Player" && !"Bullet" in body.name:
		print("body: ", body.name)
		$Bump.play()
#		yield($Bump, "finished")
		self.queue_free()
	
