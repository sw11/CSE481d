package main 
{
	import org.flixel.*;
	import utility.*;
	import levels.Helper;
	
	/**
	 * ...
	 * @author Sam Wilsonn
	 */
	public class MainState extends FlxState
	{
		override public function create(): void {
			FlxG.bgColor = StaticVars.WHITE;
			add(Helper.airBackground());
			add(instr("Trash It", 100, 80));
			add(instr("Press [Enter] to start", 400, 20));
			var albino:FlxText = new FlxText(130, 550, FlxG.width, "www.albinoblacksheep.com");
			albino.setFormat(null, 13, StaticVars.BLACK, "center");
			add(albino);
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