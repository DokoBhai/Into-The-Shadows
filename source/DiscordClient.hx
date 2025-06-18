import cpp.RawPointer;
import flixel.FlxG;
import flixel.FlxState;
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types.DiscordEventHandlers;
import hxdiscord_rpc.Types.DiscordRichPresence;
import hxdiscord_rpc.Types.DiscordUser;
import sys.thread.Thread;

class DiscordClient extends FlxState
{
    var isInitialized:Bool = false;
    public static var presence = new DiscordRichPresence();

    override public function create():Void
    {
        super.create();

        var handlers = new DiscordEventHandlers();
        handlers.ready = cpp.Function.fromStaticFunction(onReady);
        handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
        handlers.errored = cpp.Function.fromStaticFunction(onError);

        var clientId = "1181613451290873917";

        Discord.Initialize(clientId, RawPointer.addressOf(handlers), true, null);
        isInitialized = true;

        Thread.create(function() {
            while(true) {
                if (isInitialized) {
                    Discord.RunCallbacks();
                }
                Sys.sleep(1);
            }
        });

        presence.state = "In The Menus";
        presence.details = "Into The Shadows";
        presence.largeImageKey = "icon"; // Make sure this matches your Discord app assets
        Discord.UpdatePresence(RawPointer.addressOf(presence));
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

        // Update Discord presence, passing pointer to presence
        Discord.UpdatePresence(RawPointer.addressOf(presence));
    }
}
