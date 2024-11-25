extends MeshInstance3D

var balloon_found = false
@onready var subballoon = %SubBalloon #located in items node

func _process(delta):
    visible = not GameManager.balloon_unlocked
    if GameManager.balloon_unlocked and not balloon_found:
        balloon_found = true
        subballoon.view_item()
        
