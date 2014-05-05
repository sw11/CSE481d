package main 
{
	import org.flixel.*;
	import easy_theme.Level2;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
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
				FlxG.switchState(new PlayState());
				
				switch (nextStage) {
					case 2:
						FlxG.switchState(new Level2());
						break;
				}
			}
		}
	}

}