@tool
extends MeshInstance3D

@export var update = false
@export var clear_vert_vis = false

@export var xSize = 20
@export var zSize = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	gen_terrain()


func gen_terrain() -> void:
	var terrain_mesh: ArrayMesh 
	var surf_tool: SurfaceTool = SurfaceTool.new()
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.1
	
	surf_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	# Sets the points
	for z in range(zSize + 1):
		for x in range(xSize + 1):
			var y = noise.get_noise_2d(x, z) * 2.5
			
			var uv = Vector2()
			uv.x = inverse_lerp(0, xSize, x)
			uv.y = inverse_lerp(0, zSize, z)
			
			surf_tool.set_uv(uv)
			surf_tool.add_vertex(Vector3(x, y, z))
			draw_sphere(Vector3(x, y, z))

	# Draws triangles
	var triangleNum: int = 0
	for z in zSize:
		for x in xSize:
			# First triangle of the quad
			surf_tool.add_index(triangleNum + 0)
			surf_tool.add_index(triangleNum + 1)
			surf_tool.add_index(xSize + 1 + triangleNum)
			
			# Second triangle of the quad
			surf_tool.add_index(xSize + 1 + triangleNum)
			surf_tool.add_index(triangleNum + 1)
			surf_tool.add_index(xSize + 2 + triangleNum)
			
			triangleNum += 1	
		triangleNum +=1
	
	surf_tool.generate_normals()
	terrain_mesh = surf_tool.commit()
	self.mesh = terrain_mesh
	
	
func draw_sphere(pos: Vector3) -> void:
	var point_mesh: MeshInstance3D = MeshInstance3D.new()
	add_child(point_mesh)
	
	point_mesh.position = pos
	
	var sphere = SphereMesh.new()
	sphere.radius = 0.1
	sphere.height = 0.2
	point_mesh.mesh = sphere
	


func _process(delta):
	if update:
		gen_terrain()
		update = false
		
	if clear_vert_vis:
		for i in get_children():
			i.free()
