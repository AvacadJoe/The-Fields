extends Node3D

@onready var mesh_holder = $MeshInstance3D
var y_pos

func _ready():
    y_pos = mesh_holder.position.y


func update_mesh(in_mesh, scale, y_offset):
    mesh_holder.mesh = in_mesh
    mesh_holder.scale = Vector3(scale, scale, scale)
    mesh_holder.position.y = y_pos + y_offset
    pass
