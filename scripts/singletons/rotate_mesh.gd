extends MeshInstance3D

@export var rotate_speed = .5

func _process(delta):
    self.rotate_y(rotate_speed*delta)
