package modchart.modifiers;
import flixel.FlxSprite;
import ui.*;
import modchart.*;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.FlxG;
import math.Vector3;
import math.*;

class TransformModifier extends NoteModifier { // this'll be transformX in ModManager
    inline function lerp(a:Float,b:Float,c:Float){
        return a+(b-a)*c;
    }

	override function getName()
		return 'transformX';

    override function getOrder()
        return Modifier.ModifierOrder.LAST;

    override function getPos(time:Float, visualDiff:Float, timeDiff:Float, beat:Float, pos:Vector3, data:Int, player:Int, obj:FlxSprite)
    {
        pos.x += getValue(player) + getSubmodValue("transformX-a",player);
		pos.y += getSubmodValue("transformY", player) + getSubmodValue("transformY-a",player);
        pos.z += getSubmodValue('transformZ', player) + getSubmodValue("transformZ-a",player);

		pos.x += getSubmodValue('transform${data}X', player) + getSubmodValue('transform${data}X-a', player);
		pos.y += getSubmodValue('transform${data}Y', player) + getSubmodValue('transform${data}Y-a', player);
		pos.z += getSubmodValue('transform${data}Z', player) + getSubmodValue('transform${data}Z-a', player);

        return pos;
    }

    override function getSubmods(){
		var subMods:Array<String> = ["transformY", "transformZ", "transformX-a", "transformY-a", "transformZ-a"];

        var receptors = modMgr.receptors[0];
        for(recep in receptors){
			subMods.push('transform${recep.noteData}X');
			subMods.push('transform${recep.noteData}Y');
			subMods.push('transform${recep.noteData}Z');
			subMods.push('transform${recep.noteData}X-a');
			subMods.push('transform${recep.noteData}Y-a');
			subMods.push('transform${recep.noteData}Z-a');
        }
        return subMods;
    }
}