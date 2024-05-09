extends GPUParticles2D

func _ready():
	one_shot = true;
	emitting = true;

func _process(delta):
	if not emitting:
		queue_free();
