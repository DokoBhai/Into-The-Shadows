import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.text.TextFieldAutoSize;

class Menu extends FlxState{

	// Defining variables
	var Playb:FlxText;
	var optionb:FlxText;
	var no:FlxText;
	var sel:Float = 1;

	override public function create()
	{
		super.create();
		Playb = new FlxText(100, 100, 600, "Play");
		Playb.setFormat("Play", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		Playb.font = "assets/fonts/def.ttf";
		Playb.screenCenter(X);
		add(Playb);

		optionb = new FlxText(100, 100, 600, "Options");
		optionb.setFormat("Options", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		optionb.font = "assets/fonts/def.ttf";
		optionb.screenCenter(X);
		optionb.y += 100;
		add(optionb);

		no = new FlxText(100, 100, 600, "Options");
		no.setFormat("THIS IS NOT AVAILABLE YET", FlxG.width, FlxColor.RED, FlxTextAlign.CENTER);
		no.screenCenter(X);
		no.visible = false;
		add(no);
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

		// Play button

		if (sel == 1)
		{
			FlxG.camera.follow(Playb);
			FlxG.camera.followLerp = 0.3;
		}

		if (sel == 1 && FlxG.keys.justPressed.ENTER)
		{	
			var originalWidth = Playb.width;
			FlxTween.tween(Playb, { width: originalWidth }, 0.1, {
            type: FlxTweenType.PINGPONG
			});

			FlxG.switchState(new PlayState());
			
		}

		

		// Options button

		if (sel == 2)
		{
			FlxG.camera.follow(optionb);
			FlxG.camera.followLerp = 0.3;
		}
		if (sel == 2 && FlxG.keys.justPressed.ENTER) {
			var originalWidth = optionb.width;
			FlxTween.tween(optionb, { width: originalWidth }, 0.1, {
            type: FlxTweenType.PINGPONG
        });
		}
	}

}