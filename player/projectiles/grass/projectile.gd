extends Area2D


func _process(delta):
	position += transform.x * 230 * delta;

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Area2D_body_entered(body):
	if body.name != "Player": queue_free();
