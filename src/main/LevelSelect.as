package main
{
	import org.flixel.*;
	import beginner.*;
	import intermediate.*;
	import advance.*;
	import d_bomb_theme.*;
	import main.*;
	import utility.*;
	import levels.*;
	import fall_object.Objects;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class LevelSelect extends FlxState
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
		//private var yPos:int;
		private var themeArr:Array;
		
		private var maxLevel:int;
		private var currLevel:int;
		private var textArr:Array;
		private var selected:FlxSprite;
		
		override public function create(): void {
			FlxG.bgColor = StaticVars.WHITE;
			var levelInstr1:FlxText;
			levelInstr1 = Helper.addInstr("Level", 0, 50, StaticVars.BLACK, 30);
			
			//createText(0, 50, 30, "Level");
			//levelInstr1.setFormat(null, 50, StaticVars.BLACK, "center");
			add(levelInstr1);
			
			
			//trace("Inside level select");
			//var _1:FlxText;
			//_1 = createText(100, 100, 20, "Lvl");
			//add(_1);
			textArr = new Array();
			for (var i:int = 1; i <= 3; i++) {
				for (var j:int = 1; j <= 4; j++) {
					var text:FlxText = Helper.addInstr("Lv" + (j + (i - 1) * 4), (j - 2) * 100 - 50, i * 100 + 60, StaticVars.BLACK, 20);
					//createText((j-2) * 100 - 50, i * 100 + 50, 30, "Lv" + (j + (i - 1) * 4));
					textArr.push(text);
					//trace(i + " " + j);
					add(text);
				}				
			}
			
			var lastLv:Boolean = true;
			for (var k:int = State.levelArr.length - 1; k >= 0; k--) {
				
				
				var t:FlxText = textArr[k] as FlxText;
				// trace(k); 
				if (State.levelArr[k][0]) {
					if (lastLv) {
						maxLevel = k + 1;
						currLevel = k + 1;
						t.color = StaticVars.RED;
						lastLv = false;
					}
					//trace(k + " " + State.levelArr[k][1]);
					if (State.levelArr[k][1]) {
						addStar(t.x + StaticVars.WIDTH / 2 - 12, t.y + 27);
					}
				} else {
					t.color = StaticVars.GREY;
					addLock(t.x + StaticVars.WIDTH/2 - 15, t.y + 25);
				}
			}
			
			var enter:FlxText = Helper.addInstr("Press enter to play", 0, 600, StaticVars.RED, 15);
			//createText(0, 600, 15, "Press enter to play");
			add(enter);
		}
		
		
		private function addLock(x:int, y:int):void {
			var locks:FlxSprite = new FlxSprite(x, y);
			locks.loadGraphic(lock, true, true, 30, 30);
			add(locks);
		}
		
		private function addStar(xPos:int, yPos:int):void {
			var starIcon:FlxSprite = new FlxSprite(xPos, yPos);
			starIcon.loadGraphic(star, true, true, 24, 24);
			add(starIcon);
		}
		
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				startLevel(currLevel);
			} else if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new MainState());
			} else if (FlxG.keys.justPressed("LEFT")) {
				//trace("left " + currLevel);
				(textArr[currLevel-1] as FlxText).color = StaticVars.BLACK;
				currLevel = (--currLevel == 0) ? 1 : currLevel;
				(textArr[currLevel-1] as FlxText).color = StaticVars.RED;
				//changeColor();
			} else if (FlxG.keys.justPressed("RIGHT")) {
				(textArr[currLevel-1] as FlxText).color = StaticVars.BLACK;
				currLevel = (++currLevel > maxLevel) ? maxLevel : currLevel;
				(textArr[currLevel-1] as FlxText).color = StaticVars.RED;
				//changeColor();
			} else if (FlxG.keys.justPressed("UP")) {
				(textArr[currLevel-1] as FlxText).color = StaticVars.BLACK;
				currLevel = (currLevel <= 4) ? Math.max(1, currLevel) : currLevel - 4;
				(textArr[currLevel-1] as FlxText).color = StaticVars.RED;
			} else if (FlxG.keys.justPressed("DOWN")) {
				(textArr[currLevel - 1] as FlxText).color = StaticVars.BLACK;
				if (currLevel + 4 <= maxLevel && currLevel <= 8) {
					currLevel += 4;
				}
				currLevel = Math.min(15, currLevel);
				//currLevel = (++currLevel > maxLevel) ? maxLevel : currLevel;	
				(textArr[currLevel-1] as FlxText).color = StaticVars.RED;
			} else if (FlxG.keys.justPressed("U")) {
				for (var i:int = 0; i < State.levelArr.length; i++) {
					State.levelArr[i][0] = true;
				}
				FlxG.switchState(new LevelSelect());
			}  
			//else if (FlxG.keys.justPressed("L")) {
			//	State.levelArr[11][0] = false;
			//	FlxG.switchState(new LevelSelect());
			//}
		}
		
		
		//private function instr(text:String):FlxText 
		//{
		//	var instruction:FlxText = new FlxText(0, yPos += 40, FlxG.width, text);
		//	instruction.setFormat(null, 16, StaticVars.BLACK, "center");
		//	return instruction;
		//}
		
		public static function startLevel(thisLevel:int):void {
			switch(thisLevel) {
				case 1:
					FlxG.switchState(new Level1());
					break;
				case 2:
					FlxG.switchState(new Level2());
					break;
				case 3:
					FlxG.switchState(new Level3());
					break;
				case 4:
					FlxG.switchState(new Level4());
					break;
				case 5:
					FlxG.switchState(new Level5());
					break;
				case 6:
					FlxG.switchState(new Level6());
					break;
				case 7:
					FlxG.switchState(new Level7());
					break;
				case 8:
					FlxG.switchState(new Level8());
					break;
				case 9:
					FlxG.switchState(new Level9());
					break;
				case 10:
					FlxG.switchState(new Level10());
					break;
				case 11:
					FlxG.switchState(new Level7());
					break;
				case 12:
					FlxG.switchState(new Level8());
					break;
			}
		}
		
		private function aTheme():void {
			switch(currState) {
					case 1:
						FlxG.switchState(new Level1());
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
						FlxG.switchState(new CLevel4()); // TODO
						break;
					case 5:
						FlxG.switchState(new CLevel5()); // TODO
						break;
					case 6:
						FlxG.switchState(new CLevel1()); // TODO
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