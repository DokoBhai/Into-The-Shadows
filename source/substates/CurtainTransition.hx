package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class CurtainTransition extends FlxSubState {
    public static var finishCallback:Void->Void;

    override public function create():Void {
        super.create();

        var curtainWidth:Int = Std.int(FlxG.width / 2);

        var left = new FlxSprite(-curtainWidth, 0);
        left.makeGraphic(curtainWidth, FlxG.height, FlxColor.BLACK);
        left.scrollFactor.set(0, 0);
        add(left);

        var right = new FlxSprite(FlxG.width, 0);
        right.makeGraphic(curtainWidth, FlxG.height, FlxColor.BLACK);
        right.scrollFactor.set(0, 0);
        add(right);

        FlxTween.tween(left, { x: 0 }, 0.5, { ease: FlxEase.quadInOut });
        FlxTween.tween(right, { x: FlxG.width - curtainWidth }, 0.5, {
            ease: FlxEase.quadInOut,
            onComplete: function(_) {
                if (finishCallback != null) finishCallback();
                close(); // Close this substate after transition
            }
        });
    }
}
