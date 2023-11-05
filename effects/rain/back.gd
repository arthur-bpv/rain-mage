extends Particles2D

func _ready():
	amount = int(rand_range(0, 4));
	one_shot = true;
	emitting = true;
