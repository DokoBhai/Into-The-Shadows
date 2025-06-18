package;

import DiscordClient;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
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

		DiscordClient.changePresence("Let bro cook", "Playing Platforms", "icon");

		// Make the ground
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, 150, FlxColor.GRAY, true);
		bg.updateHitbox();
		bg.immovable = true;
		bg.y = FlxG.height - bg.height;

		// Make the player
		player = new FlxSprite();
		player.frames = FlxAtlasFrames.fromSparrow(AssetPaths.mainChar__png, AssetPaths.mainChar__xml);
		player.animation.addByPrefix("idle", "idle", 24, true);
		player.screenCenter();
		player.animation.play("idle");
		player.acceleration.y = 400;
		player.drag.x = 800;
		player.maxVelocity.set(200, 400);
		player.scale.set(0.5,0.5);
		FlxG.camera.follow(player);
		player.updateHitbox();
		
		// Add sprites
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