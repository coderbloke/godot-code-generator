@tool
class_name CodeGeneratorAutomation extends Resource

#var target_file_count: int = 0:
#	set(value):
#		target_file_count = value
#		target_files.resize(value)
#	get:
#		target_file_count = target_files.size()
#		return target_file_count
var target_files: PackedStringArray = []

#var trigger_resource_count: int = 0:
#	set(value):
#		trigger_resource_count = value
#		trigger_resources.resize(value)
#	get:
#		trigger_resource_count = trigger_resources.size()
#		return trigger_resource_count
var trigger_resources: Array[Resource] = []

@export var generator_specification: CodeGeneratorSpecification
@export_dir var backup_directory: String

func _get_property_list():
	var properties = []
	properties.append({
		"name": "target_file_count",
		"class_name": "Target Files,target_file_,add_button_text=Add target file or wildcard",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_ARRAY,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": ""
	})
	for i in target_files.size():
		properties.append({
			"name": "target_file_%s/path" % i,
			"class_name": "",
			"type": TYPE_STRING,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_FILE,
			"hint_string": ""
		})
	properties.append({
		"name": "trigger_resource_count",
		"type": TYPE_INT,
		"class_name": "Trigger Resources,trigger_resource_,add_button_text=Add trigger resource",
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_ARRAY,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": ""
	})
	for i in trigger_resources.size():
		properties.append({
			"name": "trigger_resource_%s/resource" % i,
			"type": TYPE_OBJECT,
			"class_name": "Resource",
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_NONE,
			"hint_string": ""
		})
	return properties

func _set(property: StringName, value: Variant):
	if property == "target_file_count" and value != target_files.size():
		target_files.resize(value)
		property_list_changed.emit()
	elif property.begins_with("target_file_"):
		var property_path := property.split("/")
		if property_path[1] == "path":
			var i := property_path[0].trim_suffix("target_file_").to_int()
			target_files[i] = value
	elif property == "trigger_resource_count" and value != trigger_resources.size():
		trigger_resources.resize(value)
		property_list_changed.emit()
	elif property.begins_with("trigger_resource_"):
		var property_path := property.split("/")
		if property_path[1] == "resource":
			var i := property_path[0].trim_suffix("trigger_resource_").to_int()
			trigger_resources[i] = value

func _get(property: StringName) -> Variant:
	if property == "target_file_count":
		return target_files.size()
	elif property.begins_with("target_file_"):
		var property_path := property.split("/")
		if property_path[1] == "path":
			var i := property_path[0].trim_suffix("target_file_").to_int()
			return target_files[i]
	elif property == "trigger_resource_count":
		return trigger_resources.size()
	elif property.begins_with("trigger_resource_"):
		var property_path := property.split("/")
		if property_path[1] == "resource":
			var i := property_path[0].trim_suffix("trigger_resource_").to_int()
			return trigger_resources[i]
	return null

func add_target_file(target_file: String):
	print("[add_target_file]")

func _hide_script_from_inspector():
	return true
