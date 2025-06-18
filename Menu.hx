import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.text.TextFieldAutoSize;

class Menu extends FlxState{

	// Defining variables
	var Playb:FlxText;
	var optionb:FlxText;
	var sel:Float = 1;

	override public function create()
	{
		super.create();
		Playb = new FlxText(100, 100, 600, "Play");
		Playb.setFormat("Play", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		Playb.screenCenter(X);
		add(Playb);

		optionb = new FlxText(100, 100, 600, "Options");
		optionb.setFormat("Options", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		optionb.screenCenter(X);
		optionb.y += 100;
		add(optionb);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.W)
		{
			if (sel == 2)
			{
				sel -= 1;
			}
		}

		if (FlxG.keys.justPressed.S)
		{
			if (sel == 1)
			{
				sel += 1;
			}
		}

		if (sel == 1)
		{
			FlxG.camera.follow(Playb);
			FlxG.camera.followLerp = 0.1;
		}

		if (sel == 2)
		{
			FlxG.camera.follow(optionb);
			FlxG.camera.followLerp = 0.1;
		}
	}

}