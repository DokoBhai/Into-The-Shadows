// CurtainOpenSubState.hx
package helpers;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class CurtainOpenSubState extends FlxSubState {
	var leftCurtain:FlxSprite;
	var rightCurtain:FlxSprite;
	var duration:Float;

	public function new(duration:Float = 0.5) {
		super();
		this.duration = duration;
	}

	override function create() {
		super.create();

		var halfW = Std.int(FlxG.width / 2);
		var height = FlxG.height;

		leftCurtain = new FlxSprite(0, 0);
		leftCurtain.makeGraphic(halfW, height, FlxColor.BLACK);
		leftCurtain.scrollFactor.set();
		add(leftCurtain);

		rightCurtain = new FlxSprite(halfW, 0);
		rightCurtain.makeGraphic(halfW, height, FlxColor.BLACK);
		rightCurtain.scrollFactor.set();
		add(rightCurtain);

		FlxTween.tween(leftCurtain, { x: -halfW }, duration, { ease: FlxEase.quadInOut });
		FlxTween.tween(rightCurtain, { x: FlxG.width }, duration, {
			ease: FlxEase.quadInOut,
			onComplete: function(_) close()
		});
	}
} 
