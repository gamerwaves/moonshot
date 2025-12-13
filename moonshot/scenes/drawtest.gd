extends Node2D

var drawing = false
var raw_points = []

@onready var line = $Line2D

func _ready():
	DisplayServer.window_set_title("Drawtest")

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
	recognize(points)

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

func point_segment_distance(p, a, b):
	var ab = b - a
	var t = clamp((p - a).dot(ab) / ab.length_squared(), 0.0, 1.0)
	var proj = a + ab * t
	return p.distance_to(proj)

func is_line(points):
	var a = points[0]
	var b = points[-1]
	var total = 0.0

	for p in points:
		total += point_segment_distance(p, a, b)

	return total / points.size() < 0.04

func line_angle(points):
	var dir = (points[-1] - points[0]).normalized()
	return abs(rad_to_deg(atan2(dir.y, dir.x)))

func is_horizontal(points):
	var angle = line_angle(points)
	return is_line(points) and (angle < 15 or angle > 165)

func is_vertical(points):
	var angle = line_angle(points)
	return is_line(points) and abs(angle - 90) < 15

func is_diagonal(points):
	var angle = line_angle(points)
	return is_line(points) and abs(angle - 45) < 15 or abs(angle - 135) < 15

func corner_count(points):
	var count = 0
	for i in range(1, points.size() - 1):
		var a = (points[i] - points[i - 1]).normalized()
		var b = (points[i + 1] - points[i]).normalized()
		if a.dot(b) < 0.7:
			count += 1
	return count

func is_closed(points):
	return points[0].distance_to(points[-1]) < 0.15

func triangle_orientation(points):
	var min_y = points[0].y
	var max_y = points[0].y
	for p in points:
		min_y = min(min_y, p.y)
		max_y = max(max_y, p.y)
	return min_y < 0.2 and max_y > 0.8

func is_triangle(points):
	if not is_closed(points):
		return false
	var c = corner_count(points)
	return c >= 3 and c <= 5

func is_triangle_up(points):
	if not is_triangle(points):
		return false
	var top = points[0]
	for p in points:
		if p.y < top.y:
			top = p
	return top.y < 0.25

func is_triangle_down(points):
	if not is_triangle(points):
		return false
	var bottom = points[0]
	for p in points:
		if p.y > bottom.y:
			bottom = p
	return bottom.y > 0.75

func recognize(points):
	if is_horizontal(points):
		print("HORIZONTAL LINE")
	elif is_vertical(points):
		print("VERTICAL LINE")
	elif is_diagonal(points):
		print("DIAGONAL LINE")
	elif is_triangle_up(points):
		print("TRIANGLE UP")
	elif is_triangle_down(points):
		print("TRIANGLE DOWN")
	else:
		print("UNKNOWN")
