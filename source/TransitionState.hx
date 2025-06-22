package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class TransitionState extends FlxSubState {
	public static var finishCallback:Void->Void;

	override public function create():Void {
		super.create();

		var curtainWidth:Int = Std.int(FlxG.width / 2);

		var leftCurtain = new FlxSprite(-curtainWidth, 0);
		leftCurtain.makeGraphic(curtainWidth, FlxG.height, FlxColor.BLACK);
		leftCurtain.scrollFactor.set(0, 0);
		add(leftCurtain);

		var rightCurtain = new FlxSprite(FlxG.width, 0);
		rightCurtain.makeGraphic(curtainWidth, FlxG.height, FlxColor.BLACK);
		rightCurtain.scrollFactor.set(0, 0);
		add(rightCurtain);

		// Animate curtains inward
		FlxTween.tween(leftCurtain, { x: 0 }, 0.5, { ease: FlxEase.quadInOut });
		FlxTween.tween(rightCurtain, { x: FlxG.width - curtainWidth }, 0.5, {
			ease: FlxEase.quadInOut,
			onComplete: function(_) {
				if (finishCallback != null) finishCallback();
				close();
			}
		});
	}
}
