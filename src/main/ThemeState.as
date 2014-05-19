package main 
{
	import a_basic_theme.*;
	import b_recycle_theme.*;
	import c_fog_theme.*;
	import d_bomb_theme.*;
	import org.flixel.*;
	import utility.*;
	
	/**
	 * ...
	 * @author Sam Wilsonn
	 */
	public class ThemeState extends FlxState
	{
		[Embed(source = '../../img/lock.png')] private var lock:Class;
		
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
		
		//private static var RED:int = 0xFFFF0000;
		private var currState:int;
		private var currTheme:int;
		
		private var yPos:int;
		
		//private var unlockTheme:int;
		//private var unlockLevel:int;
		
		public function ThemeState(): void {
			
			super();
			yPos = 60;
			currState = 1;
			//unlockTheme = theme;
			//unlockLevel = level;
		}
		
		override public function create(): void {
			FlxG.bgColor = StaticVars.WHITE;
			
			add(instr("Arrow up down to select theme"));
			
			basic = createText(yPos += 40, "BEGINNER");
			currText = basic;
			currText.color = StaticVars.RED;
			currTheme = 1;
			add(currText);
			
			rec = createText(yPos += 40, "INTERMEDIATE")
			add(rec);
			
			if (State.unlockTheme < 2) {
				addLock();
			}
			
			fog = createText(yPos += 40, "ADVANCED")
			add(fog);
			
			if (State.unlockTheme < 3) {
				addLock();
			}
			
			bomb = createText(yPos += 40, "???")
			add(bomb);
			// todo: unlock this later
			//if (State.unlockTheme < 4) {
				addLock();
			//}
			
			add(instr("Press ENTER to start"));
		}
		
		private function addLock():void {
			var locks:FlxSprite = new FlxSprite(420, yPos - 5);
			locks.loadGraphic(lock, true, true, 30, 30);
			add(locks);
		}
		
		private function createText(y:int, theme:String):FlxText {
			var text:FlxText = new FlxText(0, y, FlxG.width, theme);
			text.setFormat(null, 20, StaticVars.BLACK, "center");
			return text;
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new LevelState(currTheme));
			}
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
			}
		}
		
		private function unlock(lvl:int):void {
			for (var i:int = 0; i < State.unlockLevels.length; i++) {
					State.unlockLevels[i] = lvl;
				}
				State.levelUpdate();
		}
		
		private function changeColor():void {
			currText.color = StaticVars.BLACK;
			switch(currState) {
				case 1:
					currText = basic;
					currTheme = 1;
					break;
				case 2:
					currText = rec;
					currTheme = 2;
					break;
				case 3:
					currText = fog;
					currTheme = 3;
					break;
				case 4:
					currText = bomb;
					currTheme = 4;
					break;
			}
			currText.color = StaticVars.RED;
		}
		
		private function instr(text:String):FlxText 
		{
			var instruction:FlxText = new FlxText(0, yPos += 40, FlxG.width, text);
			instruction.setFormat(null, 16, StaticVars.BLACK, "center");
			return instruction;
		}
	}

}