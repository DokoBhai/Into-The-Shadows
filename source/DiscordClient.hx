#if discordSupported
import cpp.RawPointer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import helpers.CurtainOpenSubState;
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types.DiscordEventHandlers;
import hxdiscord_rpc.Types.DiscordRichPresence;
import hxdiscord_rpc.Types.DiscordUser;
import sys.thread.Thread;

class DiscordClient extends FlxState
{
    var isInitialized:Bool = false;
    public static var presence = new DiscordRichPresence();

    var loadingText:FlxText;
    var dots:Int = 0;
    var timeElapsed:Float = 0;

    override public function create():Void
    {
        super.create();

        // Create and display a loading text
        loadingText = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Loading");
        loadingText.setFormat(null, 16, 0xFFFFFF, "center");
        add(loadingText);

        // Discord RPC setup
        var handlers = new DiscordEventHandlers();
        handlers.ready = cpp.Function.fromStaticFunction(onReady);
        handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
        handlers.errored = cpp.Function.fromStaticFunction(onError);

        var clientId = "1181613451290873917";
        Discord.Initialize(clientId, RawPointer.addressOf(handlers), true, null);
        isInitialized = true;

        // Run callbacks in a background thread
        Thread.create(function() {
            while (true) {
                if (isInitialized) {
                    Discord.RunCallbacks();
                }
                Sys.sleep(1);
            }
        });

        presence.state = "In The Menus";
        presence.details = "Into The Shadows";
        presence.largeImageKey = "icon";
        Discord.UpdatePresence(RawPointer.addressOf(presence));
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Animate the loading text (adds dots like "Loading.")
        timeElapsed += elapsed;
        if (timeElapsed >= 0.5) {
            dots = (dots + 1) % 4;
            loadingText.text = "Loading" + repeat(".", dots);
            timeElapsed = 0;
        }
    }

    static function onReady(user:cpp.RawConstPointer<DiscordUser>):Void
    {
        trace("Discord RPC connected: " + user[0].username + "#" + user[0].discriminator);
        FlxG.switchState(new Menu());
    }

    static function onDisconnected(code:Int, message:cpp.ConstCharStar):Void
    {
        trace("Discord RPC disconnected: " + code + " " + message);
    }

    static function onError(code:Int, message:cpp.ConstCharStar):Void
    {
        trace("Discord RPC error: " + code + " " + message);
    }

    public static function changePresence(details:String, state:String, ?largeImage:String = "icon", ?smallImage:String = null):Void {
        presence.details = details;
        presence.state = state;
        presence.largeImageKey = largeImage;
        if (smallImage != null) presence.smallImageKey = smallImage;
        Discord.UpdatePresence(RawPointer.addressOf(presence));
    }
}

    function repeat(str:String, count:Int):String {
        var result = "";
        for (i in 0...count)
            result += str;
        return result;
    }

#end
