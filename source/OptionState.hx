import TransitionState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import helpers.CurtainOpenSubState;


class OptionState extends FlxState{
    
    var notava:FlxText;

    override public function create()
	{

        super.create();

        notava = new FlxText(100, 100, 600, "NOT AVAILABLE YETT BRO \n Press escape to go back to menu");
        notava.setFormat("Play", 10, FlxColor.RED, FlxTextAlign.CENTER);
        notava.font = "assets/fonts/def.ttf";
        notava.screenCenter();
        add(notava);

        openSubState(new CurtainOpenSubState(0.5));

    }

    override public function update(elapsed:Float)
	{
		super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new Menu());
        }
    }
}