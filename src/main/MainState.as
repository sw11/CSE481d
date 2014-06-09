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
			add(instr("Shoot", 100, 80));
			add(instr("Feed", 200, 80));
			add(instr("Trash It", 300, 80));
			add(instr("Press [Enter] to start", 400, 20));
			var version:FlxText = new FlxText(130, 550, FlxG.width, "Updated 6/1/2014");
			version.setFormat("sourcesanspro", 13, StaticVars.BLACK, "center");
			add(version);
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
			instruction.setFormat("sourcesanspro", font, StaticVars.BLACK, "center");
			return instruction;
		}
	}

}