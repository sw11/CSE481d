package a_basic_theme
{
	import org.flixel.*;
	import main.*;
	import utility.StaticVars;
	
	/**
	 * ...
	 * @author Sam Wilsonn
	 */
	public class AState extends FlxState
	{
		[Embed(source = '../../img/lock.png')] private var lock:Class;
		
		private var level1:FlxText;
		private var level2:FlxText;
		private var level3:FlxText;
		private var level4:FlxText;
		private var level5:FlxText;
		private var level6:FlxText;
		
		private var currText:FlxText;
		private var unlockLevel:int;
		
		private static var _1:int = 1;
		private static var _2:int = 2;
		private static var _3:int = 3;
		private static var _4:int = 4;
		private static var _5:int = 5;
		private static var _6:int = 6;
		
		
		
		
		//private static var RED:int = 0xFFFF0000;
		private var currState:int;
		private var yPos:int;
		
		public function AState(level:int): void {
			super();
			yPos = 60;
			currState = 1;
			unlockLevel = level;
		}
		
		override public function create(): void {
			
			
			
			
			var levelInstr1:FlxText;
			levelInstr1 = new FlxText(0, yPos += 40, FlxG.width, "Arrow up down to select the level");
			levelInstr1.setFormat(null, 16, StaticVars.BLACK, "center");
			add(levelInstr1);
			
			level1 = createText(yPos += 40, "Level 1");
			currText = level1;
			currText.color = StaticVars.RED;
			add(currText);
			
			level2 = createText(yPos += 40, "Level 2")
			add(level2);
			
			if (unlockLevel < 2) {
				addLock();
			}
			
			level3 = createText(yPos += 40, "Level 3")
			add(level3);
			
			if (unlockLevel < 3) {
				addLock();
			}
			
			level4 = createText(yPos += 40, "Level 4")
			add(level4);
			
			if (unlockLevel < 4) {
				addLock();
			}
			
			level5 = createText(yPos += 40, "Level 5")
			add(level5);
			
			if (unlockLevel < 5) {
				addLock();
			}
			
			level6 = createText(yPos += 40, "Level 6")
			add(level6);
			
			if (unlockLevel < 6) {
				addLock();
			}
			
			add(instr("Press ENTER to start"));
			
			add(instr("Control:\nArrow left right to move the bucket\nEsc to exit"));
			
		}
		
		private function addLock():void {
			var locks:FlxSprite = new FlxSprite(370, yPos - 5);
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
				startLevel();
				//LostState.changeState(currState*3 + 1);
			}
			if (FlxG.keys.justPressed("UP")) {
				currState = (--currState == 0) ? unlockLevel : currState;
				changeColor();
			} else if (FlxG.keys.justPressed("DOWN")) {
				currState = (++currState == unlockLevel + 1) ? 1 : currState;	
				changeColor();
			}
		}
		
		private function changeColor():void {
			currText.color = StaticVars.BLACK;
			switch(currState) {
				case 1:
					currText = level1;
					break;
				case 2:
					currText = level2;
					break;
				case 3:
					currText = level3;
					break;
				case 4:
					currText = level4;
					break;
				case 5:
					currText = level5;
					break;
				case 6:
					currText = level6;
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
		
		private function startLevel():void {
			switch (currState) {
					case 1:
						FlxG.switchState(new ALevel1());
						break;
					case 2:
						FlxG.switchState(new ALevel2());
						break;
					case 3:
						FlxG.switchState(new ALevel3());
						break;
					case 4:
						FlxG.switchState(new ALevel3());
						break;
					case 5:
						FlxG.switchState(new ALevel3());
						break;
					case 6:
						FlxG.switchState(new ALevel3());
						break;
				}
		}
	}

}