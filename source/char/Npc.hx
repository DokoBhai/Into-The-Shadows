package char;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Npc extends FlxSprite {
    public function new(x:Float, y:Float) {
        super(x, y);

        makeGraphic(16, 32, FlxColor.YELLOW);

        acceleration.y = 400; // gravity strength
        maxVelocity.y = 300;  // terminal fall speed
    }

    public function followPlayer(target:FlxSprite, speed:Float = 40):Void {
        var dx = target.x - this.x;
        var dy = target.y - this.y;
        
        var dist = Math.sqrt(dx * dx + dy * dy);

        if (dist > 1) {
            velocity.x = (dx / dist) * speed;
            velocity.y = (dy / dist) * speed;
        } else {
        }
    }

}
