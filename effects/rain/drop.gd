extends Area2D

var speed = rand_range(80, 150)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Area2D_body_entered(body):
	queue_free();

func _process(delta):
	global_position.y += speed * delta
