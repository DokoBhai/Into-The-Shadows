package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		#if discordSupported
		addChild(new FlxGame(320, 240, DiscordClient));
		#end

		addChild(new FlxGame(320, 240, Menu));
	}
}
