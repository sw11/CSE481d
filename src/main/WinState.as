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
	public class WinState extends FlxState
	{
		public var nextStage : Number;
		
		public function WinState(level:Number): void {
			super();
			nextStage = level + 1;
		}
		
		override public function create(): void {
			var winnerText:FlxText;
			winnerText = new FlxText(0, 16, FlxG.width, "Winner");
			winnerText.setFormat(null, 16, 0x11111111, "center");
			add(winnerText);
			
			var instruction:FlxText;
			instruction = new FlxText(0, 100, FlxG.width, "Press ENTER to go to next level");
			instruction.setFormat(null, 16, 0x11111111, "center");
			add(instruction);
			
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				LostState.changeState(nextStage);
				/*switch (nextStage) {
					case 2:
						FlxG.switchState(new ALevel2());
						break;
					case 3:
						FlxG.switchState(new ALevel3());
						break;
					case 4:
						FlxG.switchState(new Recycle1());
						break;
				}*/
			}
		}
	}

}