package;

import DiscordClient;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import openfl.text.TextFieldAutoSize;


class PlayState extends FlxState
{
	var player:FlxSprite;
	var bg:FlxSprite;
	//Map stuff
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	override public function create()
	{
		super.create();

		//map stuff
		map = new FlxOgmo3Loader(AssetPaths.into__ogmo, AssetPaths.room_001__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);
		trace('Background layer size: ' + walls.width + ', ' + walls.height);

		#if discordSupported
		DiscordClient.changePresence("Let bro cook", "Playing Platforms", "icon");
		#end
		// Make the ground
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, 150, FlxColor.GRAY, true);
		bg.updateHitbox();
		bg.immovable = true;
		bg.y = FlxG.height - bg.height;

		// Make the player
		player = new FlxSprite();
		player.frames = FlxAtlasFrames.fromSparrow(AssetPaths.mainChar__png, AssetPaths.mainChar__xml);
		player.animation.addByPrefix("idle", "shade_gif", 24, true);
		//player.screenCenter();
		player.animation.play("idle");
		player.acceleration.y = 400;
		player.drag.x = 800;
		player.maxVelocity.set(200, 400);
		player.scale.set(0.5,0.5);
<<<<<<< Updated upstream
<<<<<<< Updated upstream
		FlxG.camera.follow(player);
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
		player.updateHitbox();
		map.loadEntities(placeEntities, "entities");

		
		
		// Add sprites
		//add(bg)
		add(player);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
			FlxG.camera.follow(player);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.camera.follow(player, FlxCameraFollowStyle.LOCKON);

		if ( FlxG.keys.pressed.W && FlxG.collide(player, walls)) {
			player.velocity.y = -200;
		}

		if (FlxG.keys.pressed.A)
			player.velocity.x = -200;
		else if (FlxG.keys.pressed.D)
			player.velocity.x = 200;
		else
			player.velocity.x = 0;

		 // Wrap background position to create endless effect horizontally
	
		FlxG.collide(player, walls);
	
	}	
}