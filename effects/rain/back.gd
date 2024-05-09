extends GPUParticles2D

func _ready():
	amount = int(randf_range(1, 4));
	one_shot = true;
	emitting = true;

func _process(delta):
	if not emitting:
		queue_free();
