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
			add(instr("Press ENTER to continue", 400, 20));
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new LevelSelect());
			}
			/*
			if (FlxG.keys.justPressed("UP")) {
				currState = (--currState == 0) ? State.unlockTheme : currState;
				changeColor();
			} else if (FlxG.keys.justPressed("DOWN")) {
				currState = (++currState == State.unlockTheme + 1) ? 1 : currState;	
				changeColor();
			} else if (FlxG.keys.justPressed("U")) {
				State.unlockLevel = State.maxLevel;
				State.unlockTheme = State.maxTheme;
				unlock(State.maxLevel);
				FlxG.switchState(new ThemeState());
			} else if (FlxG.keys.justPressed("L")) {
				State.unlockLevel = 1;
				State.unlockTheme = 1;
				unlock(1);
				FlxG.switchState(new ThemeState());
			}*/
		}
		
		private function instr(text:String, yp:int, font:int):FlxText 
		{
			var instruction:FlxText = new FlxText(0, yp, FlxG.width, text);
			instruction.setFormat(null, font, StaticVars.BLACK, "center");
			return instruction;
		}
	}

}