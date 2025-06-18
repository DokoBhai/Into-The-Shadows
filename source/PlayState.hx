package;

import DiscordClient;
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

		DiscordClient.changePresence("Jumping around", "In PlayState", "icon");


		FlxG.debugger.drawDebug = true;

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, 150, FlxColor.GRAY, true);
		bg.updateHitbox();
		bg.immovable = true;
		bg.y = FlxG.height - bg.height;


		player = new FlxSprite();
		player.loadGraphic(AssetPaths.sprite__png);
		player.screenCenter();
		player.acceleration.y = 400;
		player.drag.x = 800;
		player.maxVelocity.set(200, 400);
		FlxG.camera.follow(player);
		player.updateHitbox();
		
		add(bg);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		
		if ( FlxG.keys.pressed.W && FlxG.collide(player, bg)) {
			player.velocity.y = -200;
		}

		if (FlxG.keys.pressed.A)
			player.velocity.x = -200;
		else if (FlxG.keys.pressed.D)
			player.velocity.x = 200;
		else
			player.velocity.x = 0;

		 // Wrap background position to create endless effect horizontally
	
		FlxG.collide(player, bg);
	
	}

	
}