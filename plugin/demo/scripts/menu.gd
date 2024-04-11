extends Node2D

# TODONE: Update to match your plugin's name
var _plugin_name = "GodotAndroidBLENavPlugin"
var _android_plugin

func _ready():
	if Engine.has_singleton(_plugin_name):
		_android_plugin = Engine.get_singleton(_plugin_name)
	else:
		printerr("Couldn't find plugin " + _plugin_name)

func process_desktop():
	var some_value = 42
	print("Hello!" + str(some_value))

func _on_Button_pressed():
	if not _android_plugin:
		print_debug("Not in Android Environment")
		process_desktop()
		return
		
	# TODO: Update to match your plugin's API
	var some_value: int = _android_plugin.getSomeValue()
	var toToast: String = "Omai gawd hiiii!! :33333" + str(some_value)
	_android_plugin.helloWorld(toToast)
	
	
