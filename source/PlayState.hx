package;

import DiscordClient;
import char.Npc;
import debug.FpsCounterSubState;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import helpers.CurtainOpenSubState;
import openfl.text.TextFieldAutoSize;



class PlayState extends FlxState
{
	var player:FlxSprite;
	var bg:FlxSprite;
	//Map stuff
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var inx:Int;
	var iny:Int;
	var b:char.Npc;
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
		player.setSize(0, 0);
		player.scale.set(0.5,0.5);

		b = new Npc(200, 100);
		
		FlxG.camera.follow(player);
		player.updateHitbox();
		map.loadEntities(placeEntities, "entities");

		
		
		// Add sprites
		add(player);
		add(b);


		openSubState(new FpsCounterSubState());

		openSubState(new CurtainOpenSubState(0.5));
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
			{player.velocity.x = -200;
			player.flipX = true;}
		else if (FlxG.keys.pressed.D)
			{player.velocity.x = 200;
			player.flipX = false;}
		else
			player.velocity.x = 0;

		if (FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new Menu());
        }

		// NPC code
		var isOnGround = FlxG.collide(b, walls);

		if (isOnGround) {
			b.followPlayer(player, 70);
		}

		var yDistance = player.y - b.y;

		if (Math.abs(yDistance) > 100 && isOnGround) {
				b.velocity.y = -200;
		}

		// Collide stuff
		FlxG.collide(player, walls);
		FlxG.collide(b, walls);
		FlxG.collide(player, b);

	
	}	
}