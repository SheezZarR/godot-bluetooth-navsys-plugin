// TODONE: Update to match your plugin's package name.
package org.godotengine.plugin.android.blens

import android.util.Log
import android.widget.Toast
import org.godotengine.godot.Godot
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.UsedByGodot

class GodotAndroidPlugin(godot: Godot): GodotPlugin(godot) {

    override fun getPluginName() = BuildConfig.GODOT_PLUGIN_NAME

    @UsedByGodot
    private fun helloWorld(msg: String) {
        runOnUiThread {
            Toast.makeText(activity, msg, Toast.LENGTH_LONG).show()
            Log.v(pluginName, msg)
        }
    }

    @UsedByGodot
    private fun Log(){

    }

    @UsedByGodot
    private fun getSomeValue(): Int {
        return 42
    }
}
