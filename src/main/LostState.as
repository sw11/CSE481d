package main 
{
	import org.flixel.*;
	import utility.StaticVars;
	import a_basic_theme.*;
	import b_recycle_theme.*;
	import c_fog_theme.*;
	import d_bomb_theme.*;
	
	/**
	 * ...
	 * @author Adrian
	 */
	public class LostState extends FlxState
	{
		public var thisStage : Number;
		
		public function LostState(level:Number): void {
			super();
			thisStage = level;
		}
		
		override public function create(): void {

			
			var instruction:FlxText;
			instruction = new FlxText(0, 100, FlxG.width, "Fail!\nENTER to restart level\nESC to main menu");
			instruction.setFormat(null, 20, StaticVars.BLACK, "center");
			add(instruction);
			
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				changeState(thisStage);
			} else if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new ThemeState());
			}
		}
		
		public static function changeState(stage:Number):void {
			switch (stage) {
					case 1:
						FlxG.switchState(new ALevel1());
						break;
					case 2:
						FlxG.switchState(new ALevel2());
						break;
					case 3:
						FlxG.switchState(new ALevel3());
						break;
					case 4:
						FlxG.switchState(new BLevel4());
						break;
					case 5:
						FlxG.switchState(new BLevel5());
						break;
					case 6:
						FlxG.switchState(new BLevel6());
						break;
					case 7:
						FlxG.switchState(new CLevel1());
						break;
					case 8:
						FlxG.switchState(new CLevel2());
						break;
					case 9:
						FlxG.switchState(new CLevel3());
						break;
					case 10:
						FlxG.switchState(new DLevel10());
						break;
					case 11:
						FlxG.switchState(new DLevel11());
						break;
					case 12:
						FlxG.switchState(new DLevel12());
						break;
					case 13:
						FlxG.switchState(new ThemeState());
						break;
				}
		}
	}

}