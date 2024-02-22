package states;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;

class Bios extends MusicBeatState
{

    var border:FlxSprite;

    var characters:Array<String> = [
		'bandu',
		'seekerFEMBOY',
		'seeknormal'
	];

    var curSelected:Int = 0;
    var character:FlxSprite;
    var nameText:FlxText;
    var descText:FlxText;

	override function create()
        {
            #if desktop
            // Updating Discord Rich Presence
            DiscordClient.changePresence("Watching The Bios!", null);
            #end

            transIn = FlxTransitionableState.defaultTransIn;
            transOut = FlxTransitionableState.defaultTransOut;
    
            persistentUpdate = true;

            var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/bgwea'));
            bg.antialiasing = ClientPrefs.data.antialiasing;
            bg.scrollFactor.set(0, 0);
            bg.setGraphicSize(Std.int(bg.width * 1.175));
            bg.updateHitbox();
            bg.screenCenter();
            add(bg);

            var backdrop:FlxBackdrop = new FlxBackdrop(Paths.image('mainmenu/backdrop'));
            backdrop.scrollFactor.set();
            backdrop.velocity.set(-40, 0);
            backdrop.velocity.x = -120;
            backdrop.screenCenter();
            backdrop.alpha = 0.3;
            add(backdrop);

            var square:FlxSprite = new FlxSprite(FlxG.width - 500,0).loadGraphic(Paths.image('square'));
            square.screenCenter(Y);
            square.scale.x = 2.0;
            square.scale.y = 2.0;
            add(square);

            border = new FlxSprite(FlxG.width - 500,0).loadGraphic(Paths.image('border'));
            border.screenCenter(Y);
            border.scale.x = 2.0;
            border.scale.y = 2.0;
            add(border);

            character = new FlxSprite(100,100);
            character.frames = Paths.getSparrowAtlas('characters/' + characters[curSelected]);
            character.animation.addByPrefix('idle2', "IDLE", 24, true);
            character.animation.addByPrefix('idle', "idle", 24, true);
            character.animation.play('idle2');
            character.scale.x = 1.3;
            character.scale.y = 1.3;
            add(character);

            nameText = new FlxText(FlxG.width - 500, 100, 0, "", 50);
            nameText.setFormat(Paths.font("undertale2.otf"), 50, FlxColor.WHITE);
            add(nameText);

            descText = new FlxText(FlxG.width - 640, 250, 0, "", 30);
            descText.setFormat(Paths.font("undertale1.ttf"), 30, FlxColor.WHITE);
            add(descText); 

            changeSHIT();
        }
    function changeSHIT(huh:Int = 0)
        {  
            FlxG.sound.play(Paths.sound('scrollMenu'));

            curSelected += huh;

            character.frames = Paths.getSparrowAtlas('characters/' + characters[curSelected]);
            if (characters[curSelected] == "bandu")
                character.animation.play('idle2');
            else
                character.animation.play('idle');

            if (curSelected >= characters.length)
                curSelected = 0;
            if (curSelected < 0)
                curSelected = characters.length;
        }

    override function update(elapsed:Float)
        {
            if (controls.UI_UP_P)
				changeSHIT(-1);

			if (controls.UI_DOWN_P)
				changeSHIT(1);
            if (controls.BACK)
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    MusicBeatState.switchState(new MainMenuState());
                }
                
            switch (characters[curSelected])
            {
                case 'bandu':
                    FlxTween.color(border, 0.3, border.color, FlxColor.LIME);
                    character.x = 150;
                    character.y = 160;

                    nameText.x = FlxG.width - 500;
                    nameText.text = "BANDU";
                    descText.text = "'Veh', originally appearing \n in dnb golden apple is a character \n inspired by the character bambi from \n dave and bambi by \n MoldyGH";
                case 'seekerFEMBOY':
                    FlxTween.color(border, 0.3, border.color, FlxColor.MAGENTA);
                    character.x = 200;
                    character.y = 200;

                    nameText.x = FlxG.width - 600;
                    nameText.text = "NEKO SEEK";
                    descText.text = "neko seek \n appearing in the animation \n 'Soilders Vs Neko seek Part 1' \n by Quetru1109 He is a character inspired \n by the character seek from \n the game doors, he is like \n seek...... \n but neko....";
                case 'seeknormal':
                    FlxTween.color(border, 0.3, border.color, FlxColor.WHITE);
                    character.y = 150;

                    nameText.x = FlxG.width - 470;
                    nameText.text = "SEEK";
                    descText.text = "I need to explain?";
            }
        }
}

