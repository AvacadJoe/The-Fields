extends MeshInstance3D

func _process(delta):
    visible = not GameManager.balloon_unlocked
