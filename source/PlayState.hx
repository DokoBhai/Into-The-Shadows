package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.text.TextFieldAutoSize;



class PlayState extends FlxState
{
	var player:FlxSprite;
	var bg:FlxSprite;
	override public function create()
	{
		super.create();

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, 150, FlxColor.GRAY, true);
		bg.updateHitbox();
		bg.immovable = true;
		bg.y = FlxG.height - bg.height;

		player = new FlxSprite();
		player.loadGraphic(AssetPaths.sprite__png);
		player.screenCenter();
		player.updateHitbox();
		player.acceleration.y = 400;
		player.drag.x = 800;
		player.maxVelocity.set(200, 400);
		
		add(bg);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		
		if ( FlxG.keys.pressed.W && FlxG.collide(player, bg)) {
			player.velocity.y = -200;
		}

		if(FlxG.keys.pressed.D)
		{
			player.x += 10;
		}

		
		if(FlxG.keys.pressed.A)
		{
			player.x -= 10;
		}

		if(FlxG.mouse.overlaps(player))
		{
			if (FlxG.mouse.pressed)
			{
				player.x = FlxG.mouse.x - player.width /2;
				player.y = FlxG.mouse.y - player.height /2;
			}
		}
	
		FlxG.collide(player, bg);
	
	}

	
}