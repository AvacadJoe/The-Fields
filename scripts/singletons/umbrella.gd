extends MeshInstance3D

func _process(delta):
    self.visible = GameManager.umbrella_quest_completed
    pass
