package main 
{
	import org.flixel.*;
	import utility.StaticVars;
	import a_basic_theme.*;
	import b_recycle_theme.*;
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
			winnerText.setFormat(null, 16, StaticVars.BLACK, "center");
			add(winnerText);
			
			var instruction:FlxText;
			instruction = new FlxText(0, 100, FlxG.width, "Press ENTER to go to next level");
			instruction.setFormat(null, 16, StaticVars.BLACK, "center");
			add(instruction);
			
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				LostState.changeState(nextStage);
			}
		}
	}

}