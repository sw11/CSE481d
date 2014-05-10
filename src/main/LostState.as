package main 
{
	import org.flixel.*;
	import a_basic_theme.*;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import b_recycle_theme.Recycle1;
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
			instruction = new FlxText(0, 16, FlxG.width, "Press ENTER to restart level");
			instruction.setFormat(null, 16, 0x11111111, "center");
			add(instruction);
			
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				changeState(thisStage);
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
						FlxG.switchState(new Recycle1());
						break;
				}
		}
	}

}