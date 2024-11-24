extends Node3D

@onready var mesh_holder = $MeshInstance3D

func update_mesh(in_mesh, scale):
    mesh_holder.mesh = in_mesh
    mesh_holder.scale = Vector3(scale, scale, scale)
    pass
