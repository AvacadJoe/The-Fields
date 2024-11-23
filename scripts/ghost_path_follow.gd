extends PathFollow3D

@export var speed = 3.0
@onready var ghost_child = self.get_child(0)

func  _process(delta):
    if ghost_child.interactable == false:
        progress = progress +  delta*speed
