extends Node2D

var drawing = false
var raw_points = []
var templates = {}

@onready var line = $Line2D

func _ready():
	DisplayServer.window_set_title("Drawtest")
	load_templates("res://resources/shapes.json")

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			start_draw(event.position)
		else:
			end_draw()
	elif event is InputEventMouseMotion and drawing:
		add_point(event.position)

func start_draw(pos):
	drawing = true
	raw_points.clear()
	line.clear_points()
	add_point(pos)

func add_point(pos):
	if raw_points.is_empty() or raw_points[-1].distance_to(pos) > 6:
		raw_points.append(pos)
		line.add_point(pos)

func end_draw():
	drawing = false
	if raw_points.size() < 10:
		return
	var points = normalize(raw_points)
	var recognized = recognize_template(points)
	print("RECOGNIZED:", recognized)

func normalize(points):
	var min_p = points[0]
	var max_p = points[0]

	for p in points:
		min_p.x = min(min_p.x, p.x)
		min_p.y = min(min_p.y, p.y)
		max_p.x = max(max_p.x, p.x)
		max_p.y = max(max_p.y, p.y)

	var size = max(max_p.x - min_p.x, max_p.y - min_p.y)
	var out = []

	for p in points:
		out.append((p - min_p) / size)

	return out

func load_templates(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()

	var json = JSON.new()
	var err = json.parse(text)
	if err != OK:
		push_error("Failed to parse JSON")
		return

	templates = json.get_data()

func distance(a, b):
	var total = 0.0
	for i in range(min(a.size(), b.size())):
		var p1 = Vector2(a[i][0], a[i][1])
		var p2 = Vector2(b[i][0], b[i][1])
		total += p1.distance_to(p2)
	return total / min(a.size(), b.size())

func recognize_template(user_points):
	var best_shape = "UNKNOWN"
	var best_dist = 1e6

	for shape_name in templates.keys():
		for template in templates[shape_name]:
			var dist = distance(user_points, template)
			if dist < best_dist:
				best_dist = dist
				best_shape = shape_name

	return best_shape
