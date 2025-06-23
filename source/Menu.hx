import DiscordClient;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import helpers.CurtainOpenSubState;

class Menu extends FlxState {
    var buttons:Array<FlxText> = [];
    var selected:Int = 0;
    var bg:FlxSprite;

    override public function create() {
        super.create();

        #if discordSupported
        DiscordClient.changePresence("Let bro cook", "In The Menu's", "icon");
        #end

        bg = new FlxSprite(0, 0);
        bg.loadGraphic("assets/images/bg.png");
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.screenCenter();
        bg.scrollFactor.set(0, 0);
        add(bg);

        var labels = ["Play", "Options"];
        for (i in 0...labels.length) {
            var txt = new FlxText(0, 0, 300, labels[i]);
            txt.setFormat("assets/fonts/def.ttf", 24, FlxColor.WHITE, FlxTextAlign.CENTER);
            txt.width = Std.int(txt.textField.textWidth);
			txt.updateHitbox();
            txt.origin.set(txt.width / 2, txt.height / 2);
            txt.x = FlxG.width / 2;
            txt.y = 200 + (i * 60);
            add(txt);
            buttons.push(txt);
        }

        openSubState(new CurtainOpenSubState(0.5));
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        // Navigation by keyboard
        if (FlxG.keys.justPressed.W && selected > 0) selected--;
        if (FlxG.keys.justPressed.S && selected < buttons.length - 1) selected++;

        // Mouse hover selection
        for (i in 0...buttons.length) {
            if (FlxG.mouse.overlaps(buttons[i])) {
                selected = i;
                break;
            }
        }

        // Animate buttons scale & follow camera on selected button
        for (i in 0...buttons.length) {
            var btn = buttons[i];
            if (i == selected) {
                FlxG.camera.follow(btn);
                FlxG.camera.followLerp = 0.3;
                FlxTween.tween(btn.scale, { x: 1.2, y: 1.2 }, 0.2);
            } else {
                FlxTween.tween(btn.scale, { x: 1, y: 1 }, 0.2);
            }
        }

        // Enter key to switch states
        if (FlxG.keys.justPressed.ENTER) {
            switch (selected) {
                case 0:
                    FlxG.switchState(new PlayState());
                case 1:
                    FlxG.switchState(new OptionState());
            }
        }
    }
}
