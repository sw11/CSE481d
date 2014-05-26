package main 
{
	import org.flixel.*;
	import utility.*;
	
	/**
	 * ...
	 * @author Sam Wilsonn
	 */
	public class MainState extends FlxState
	{
		override public function create(): void {
			FlxG.bgColor = StaticVars.WHITE;
			
			add(instr("Trash It", 100, 80));
			add(instr("Press [Enter] to start", 400, 20));
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new LevelSelect());
			}
		}
		
		private function instr(text:String, yp:int, font:int):FlxText 
		{
			var instruction:FlxText = new FlxText(0, yp, FlxG.width, text);
			instruction.setFormat(null, font, StaticVars.BLACK, "center");
			return instruction;
		}
	}

}