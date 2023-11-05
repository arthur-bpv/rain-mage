extends Area2D

var SPEED = 10;

func _process(delta):
	position += transform.x * SPEED * delta;
	SPEED += 10;

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Area2D_body_entered(body):
	if body.name != "Player": queue_free();
