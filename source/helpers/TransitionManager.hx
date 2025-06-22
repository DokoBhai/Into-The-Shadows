package helpers;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class TransitionManager {
    // Internal flag to know when to open curtains
    private static var shouldOpenNext:Bool = false;

    // Call this to switch states with curtains transition
    public static function switchState(nextState:FlxState):Void {
        if(shouldOpenNext) {
            // Already transitioning, ignore new request
            return;
        }
        shouldOpenNext = true;
        if(FlxG.state != null)
            FlxG.state.openSubState(new CurtainClose(nextState));
        else
            FlxG.switchState(nextState); // fallback
    }

    // Call this inside your new state's create() method
    public static function openCurtainsIfNeeded():Void {
        if(shouldOpenNext) {
            if(FlxG.state != null)
                FlxG.state.openSubState(new CurtainOpen());
            shouldOpenNext = false;
        }
    }
}

class CurtainClose extends FlxSubState {
    var target:FlxState;
    public function new(nextState:FlxState) {
        super();
        target = nextState;
    }

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
                FlxG.switchState(target);
                close();
            }
        });
    }
}

class CurtainOpen extends FlxSubState {
    override public function create():Void {
        super.create();

        var curtainWidth:Int = Std.int(FlxG.width / 2);

        var left = new FlxSprite(0, 0);
        left.makeGraphic(curtainWidth, FlxG.height, FlxColor.BLACK);
        left.scrollFactor.set(0, 0);
        add(left);

        var right = new FlxSprite(FlxG.width - curtainWidth, 0);
        right.makeGraphic(curtainWidth, FlxG.height, FlxColor.BLACK);
        right.scrollFactor.set(0, 0);
        add(right);

        FlxTween.tween(left, { x: -curtainWidth }, 0.5, { ease: FlxEase.quadInOut });
        FlxTween.tween(right, { x: FlxG.width }, 0.5, {
            ease: FlxEase.quadInOut,
            onComplete: function(_) {
                close();
            }
        });
    }
}
