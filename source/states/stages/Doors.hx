package states.stages;

class Doors extends BaseStage
{
    var bg:FlxSprite;
    override function create()
        {
            bg = new FlxSprite(350, 350).loadGraphic(Paths.image("bg/bglove"));
            bg.scale.x = 3.0;
            bg.scale.y = 3.0;
            add(bg);
        }
}