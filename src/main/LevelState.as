package main 
{
	import org.flixel.*;
	import utility.StaticVars;
	
	/**
	 * ...
	 * @author Sam Wilsonn
	 */
	public class LevelState extends FlxState
	{
		private var basic:FlxText;
		private var rec:FlxText;
		private var fog:FlxText;
		private var bomb:FlxText;
		
		private var currText:FlxText;
		private static var BASIC:int = 0;
		private static var REC:int = 1;
		private static var FOG:int = 2;
		private static var BOMB:int = 3;
		
		
		private static var RED:int = 0xFFFF0000;
		private var currState:int;
		private var yPos:int;
		
		public function LevelState(): void {
			super();
			yPos = 100;
			currState = 0;
		}
		
		override public function create(): void {
			var levelInstr1:FlxText;
			levelInstr1 = new FlxText(0, 16, FlxG.width, "Arrow up down to select theme");
			levelInstr1.setFormat(null, 16, StaticVars.BLACK, "center");
			add(levelInstr1);
			
			basic = createText(yPos += 40, "BASIC");
			currText = basic;
			currText.color = RED;
			add(currText);
			
			rec = createText(yPos += 40, "RECYCLE")
			add(rec);
			
			fog = createText(yPos += 40, "FOG")
			add(fog);
			
			bomb = createText(yPos += 40, "BOMB")
			add(bomb);
			
			var instruction:FlxText;
			instruction = new FlxText(0, yPos += 40, FlxG.width, "Press ENTER to start");
			instruction.setFormat(null, 16, StaticVars.BLACK, "center");
			add(instruction);
		}
		
		private function createText(y:int, theme:String):FlxText {
			var text:FlxText = new FlxText(0, y, FlxG.width, theme);
			text.setFormat(null, 20, StaticVars.BLACK, "center");
			return text;
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				trace(currState * 3 + 1);
				LostState.changeState(currState*3 + 1);
			}
			if (FlxG.keys.justPressed("UP")) {
				currState = (--currState == -1) ? 3 : currState;
				changeColor();
			} else if (FlxG.keys.justPressed("DOWN")) {
				currState = (++currState == 4) ? 0 : currState;	
				changeColor();
			}
		}
		
		private function changeColor():void {
			currText.color = StaticVars.BLACK;
			switch(currState) {
				case 0:
					currText = basic;
					break;
				case 1:
					currText = rec;
					break;
				case 2:
					currText = fog;
					break;
				case 3:
					currText = bomb;
					break;
			}
			currText.color = RED;
		}
	}

}