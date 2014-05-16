package main
{
	import org.flixel.*;
	import a_basic_theme.*;
	import b_recycle_theme.*;
	import c_fog_theme.*;
	import d_bomb_theme.*;
	import main.*;
	import utility.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class LevelState extends FlxState
	{
		[Embed(source = '../../img/lock.png')] private var lock:Class;
		[Embed(source = '../../img/star.png')] private var star:Class;
		
		private var level1:FlxText;
		private var level2:FlxText;
		private var level3:FlxText;
		private var level4:FlxText;
		private var level5:FlxText;
		private var level6:FlxText;
		
		private var currText:FlxText;
		//private var unlockLevel:int;
		
		private static var _1:int = 1;
		private static var _2:int = 2;
		private static var _3:int = 3;
		private static var _4:int = 4;
		private static var _5:int = 5;
		private static var _6:int = 6;
		
		private var isBonus:Boolean;
		
		private var currState:int;
		private var currTheme:int;
		private var yPos:int;
		private var themeArr:Array;
		
		public function LevelState(theme:int): void {
			super();
			yPos = 60;
			currState = 1;
			currTheme = theme;
			getArray();
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
			
			if (themeArr[0][1] as Boolean) {
				addStar();
			}
			level2 = createText(yPos += 40, "Level 2")
			add(level2);
			
			if (!themeArr[1][0] as Boolean) {
				addLock();
			} else if (themeArr[1][1] as Boolean) {
				addStar();
			}
			
			level3 = createText(yPos += 40, "Level 3")
			add(level3);
			
			if (!themeArr[2][0] as Boolean) {
				addLock();
			} else if (themeArr[2][1] as Boolean) {
				addStar();
			}
			
			level4 = createText(yPos += 40, "Level 4")
			add(level4);
			
			if (!themeArr[3][0] as Boolean) {
				addLock();
			} else if (themeArr[3][1] as Boolean) {
				addStar();
			}
			
			level5 = createText(yPos += 40, "Level 5")
			add(level5);
			
			if (!themeArr[4][0] as Boolean) {
				addLock();
			} else if (themeArr[4][1] as Boolean) {
				addStar();
			}
			
			var i:int = 0;
			for (i = 0; i < themeArr.length - 1; i++) {
				//for (var j:int = 0; j < themeArr[i].length; j++) {
				if (!themeArr[i][1]) {
					//addLock();
					break;
				}
			}
			// todo enable this
			//isBonus = i == themeArr.length - 1;
			
			level6 = createText(yPos += 40, isBonus ? "BONUS" : "???")
			add(level6);
			
			if (!isBonus) {
				addLock();
			} 
			// todo enable this once bonus is done
			//else {
			//	State.unlockLevels[currTheme - 1] = State.maxLevel + 1;
			//}
			if (themeArr[5][1] as Boolean) {
				addStar();
			}
			
			add(instr("Press ENTER to start"));
			
			add(instr("Control:\nArrow left right to move the bucket\nEsc to exit"));
			
			if (currTheme == StaticVars.B_THEME) {
				var recycleInstr:FlxText = new FlxText(0, yPos += 60, FlxG.width, "A or Z to toggle the bucket");
				recycleInstr.setFormat(null, 16, StaticVars.BLACK, "center");
				add(recycleInstr);
			}
			
			if (currTheme == StaticVars.A_THEME) {
				var shoot:FlxText = new FlxText(0, yPos += 60, FlxG.width, "Space bar to fire in Level 5 and 6");
				shoot.setFormat(null, 16, StaticVars.BLACK, "center");
				add(shoot);
			}
		}
		
		private function getArray():void {
			switch (currTheme) {
				case 1:
					themeArr = State.theme1;
					break;
				case 2:
					themeArr = State.theme2;
					break;
				case 3:
					themeArr = State.theme3;
					break;
				case 4:
					themeArr = State.theme4;
					break;
			}
		}
		
		private function addLock():void {
			var locks:FlxSprite = new FlxSprite(370, yPos - 5);
			locks.loadGraphic(lock, true, true, 30, 30);
			add(locks);
		}
		
		private function addStar():void {
			var starIcon:FlxSprite = new FlxSprite(370, yPos - 3);
			starIcon.loadGraphic(star, true, true, 24, 24);
			add(starIcon);
		}
		
		private function createText(y:int, theme:String):FlxText {
			var text:FlxText = new FlxText(0, y, FlxG.width, theme);
			text.setFormat(null, 20, StaticVars.BLACK, "center");
			return text;
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				startTheme();
			} else if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new ThemeState());
			} else if (FlxG.keys.justPressed("UP")) {
				currState = (--currState == 0) ? State.unlockLevels[currTheme - 1] : currState;
				changeColor();
			} else if (FlxG.keys.justPressed("DOWN")) {
				currState = (++currState == State.unlockLevels[currTheme - 1] + 1) ? 1 : currState;	
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
		
		private function startTheme():void {
			switch (currTheme) {
				case 1:
					aTheme();
					break;
				case 2:
					bTheme();
					break;
				case 3:
					cTheme();
					break;
				case 4:
					dTheme();
					break;			
				}
		}
		
		private function aTheme():void {
			switch(currState) {
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
						FlxG.switchState(new ALevel4()); 
						break;
					case 5:
						FlxG.switchState(new ALevel5()); 
						break;
					case 6:
						FlxG.switchState(new ALevel6()); 
						break;
			}
		}
		
		private function bTheme():void {
			switch(currState) {
					case 1:
						FlxG.switchState(new BLevel1());
						break;
					case 2:
						FlxG.switchState(new BLevel2());
						break;
					case 3:
						FlxG.switchState(new BLevel3());
						break;
					case 4:
						FlxG.switchState(new BLevel4()); 
						break;
					case 5:
						FlxG.switchState(new BLevel5()); // TODO
						break;
					case 6:
						FlxG.switchState(new BLevel1()); // TODO
						break;
			}
		}
		
		private function cTheme():void {
			switch(currState) {
					case 1:
						FlxG.switchState(new CLevel1());
						break;
					case 2:
						FlxG.switchState(new CLevel2());
						break;
					case 3:
						FlxG.switchState(new CLevel3());
						break;
					case 4:
						FlxG.switchState(new CLevel3()); // TODO
						break;
					case 5:
						FlxG.switchState(new CLevel3()); // TODO
						break;
					case 6:
						FlxG.switchState(new CLevel3()); // TODO
						break;
			}
		}
		
		private function dTheme():void {
			switch(currState) {
					case 1:
						FlxG.switchState(new DLevel10());
						break;
					case 2:
						FlxG.switchState(new DLevel11());
						break;
					case 3:
						FlxG.switchState(new DLevel12());
						break;
					case 4:
						FlxG.switchState(new DLevel12()); // TODO
						break;
					case 5:
						FlxG.switchState(new DLevel12()); // TODO
						break;
					case 6:
						FlxG.switchState(new DLevel12()); // TODO
						break;
			}
		}
	}

}