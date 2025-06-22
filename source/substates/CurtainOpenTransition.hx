package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class CurtainOpenTransition extends FlxSubState {
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

		// Tween them OUT
		FlxTween.tween(left, { x: -curtainWidth }, 0.5, { ease: FlxEase.quadInOut });
		FlxTween.tween(right, { x: FlxG.width }, 0.5, {
			ease: FlxEase.quadInOut,
			onComplete: function(_) {
				close();
			}
		});
	}
}
