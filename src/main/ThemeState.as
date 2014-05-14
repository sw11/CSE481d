package main 
{
	import a_basic_theme.*;
	import b_recycle_theme.*;
	import c_fog_theme.*;
	import d_bomb_theme.*;
	import org.flixel.*;
	import utility.StaticVars;
	
	/**
	 * ...
	 * @author Sam Wilsonn
	 */
	public class ThemeState extends FlxState
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
		
		private var recycleInstr:FlxText;
		
		private static var RED:int = 0xFFFF0000;
		private var currState:int;
		private var currTheme:String;
		
		private var yPos:int;
		
		public function ThemeState(): void {
			super();
			yPos = 60;
			currState = 0;
		}
		
		override public function create(): void {
			var levelInstr1:FlxText;
			levelInstr1 = new FlxText(0, yPos += 40, FlxG.width, "Arrow up down to select theme");
			levelInstr1.setFormat(null, 16, StaticVars.BLACK, "center");
			add(levelInstr1);
			
			basic = createText(yPos += 40, "BASIC");
			currText = basic;
			currText.color = StaticVars.RED;
			currTheme = "A";
			add(currText);
			
			rec = createText(yPos += 40, "RECYCLE")
			add(rec);
			
			fog = createText(yPos += 40, "FOG")
			add(fog);
			
			bomb = createText(yPos += 40, "BOMB")
			add(bomb);
			
			
			add(instr("Press ENTER to start"));
			
			add(instr("Control:\nArrow left right to move the bucket\nEsc to exit"));
			
			recycleInstr = new FlxText(0, yPos += 60, FlxG.width, "A or Z to toggle the bucket");
			recycleInstr.setFormat(null, 16, StaticVars.BLACK, "center");
			add(recycleInstr);
		}
		
		private function createText(y:int, theme:String):FlxText {
			var text:FlxText = new FlxText(0, y, FlxG.width, theme);
			text.setFormat(null, 20, StaticVars.BLACK, "center");
			return text;
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new LevelState(currTheme, 6));
				//getTheme();
			}
			if (FlxG.keys.justPressed("UP")) {
				currState = (--currState == -1) ? 3 : currState;
				changeColor();
			} else if (FlxG.keys.justPressed("DOWN")) {
				currState = (++currState == 4) ? 0 : currState;	
				changeColor();
			}
		}
		/*
		private function getTheme():void {
			
			switch (currTheme) {
				case "A":
					FlxG.switchState(new AState(currTheme, 6));
					break;
				case "B":
					FlxG.switchState(new BState(currTheme, 6));
					break;
				case "C":
					FlxG.switchState(new AState(6));
					break;
				case "D":
					FlxG.switchState(new AState(6));
					break;		
			}
		}*/
		
		private function changeColor():void {
			currText.color = StaticVars.BLACK;
			switch(currState) {
				case 0:
					currText = basic;
					currTheme = "A";
					break;
				case 1:
					currText = rec;
					currTheme = "B";
					break;
				case 2:
					currText = fog;
					currTheme = "C";
					break;
				case 3:
					currText = bomb;
					currTheme = "D";
					break;
			}
			
			currText.color = RED;
		}
		
		private function instr(text:String):FlxText 
		{
			var instruction:FlxText = new FlxText(0, yPos += 40, FlxG.width, text);
			instruction.setFormat(null, 16, StaticVars.BLACK, "center");
			return instruction;
		}
	}

}