extends ParallaxLayer

const CLOUD_SPEED = -20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.motion_offset.x += CLOUD_SPEED * delta
