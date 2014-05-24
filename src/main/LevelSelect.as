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
		private var yPos:int;
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
					var text:FlxText = Helper.addInstr("Lv" + (j + (i - 1) * 4), (j - 2) * 100 - 50, i * 100 + 50, StaticVars.BLACK, 20);
					//createText((j-2) * 100 - 50, i * 100 + 50, 30, "Lv" + (j + (i - 1) * 4));
					textArr.push(text);
					//trace(i + " " + j);
					add(text);
				}				
			}
			
			for (var k:int = State.levelArr.length - 1; k >= 0; k--) {
				maxLevel = k + 1;
				currLevel = k + 1;
				// trace(k); 
				if (State.levelArr[k][0]) {
					(textArr[k] as FlxText).color = StaticVars.RED;
					break;
				} else {
					(textArr[k] as FlxText).color = StaticVars.GREY;
					
				}
			}
			
			var enter:FlxText = Helper.addInstr("Press enter to play", 0, 600, StaticVars.RED, 15);
			//createText(0, 600, 15, "Press enter to play");
			add(enter);
			//selected = new FlxSprite(100, 100);
			//selected.makeGraphic(50, 50, 0x00000000);
			
			//selected.drawLine(100, 100, 400, 100, StaticVars.RED, 5);
			//selected.drawLine(100, 100, 100, 400, StaticVars.RED, 5);
			//selected.drawLine(200, 200, 400, 100, StaticVars.RED, 5);
			//selected.drawLine(200, 200, 100, 400, StaticVars.RED, 5);
			//add(selected);
			//getArray();
			// draw levels
			//var boxes:FlxSprite = new FlxSprite(100, 100);
			//boxes.loadGraphic(Objects.candy, false, false, 75, 75, false);
			
			//boxes.alpha = 0.5;
			//boxes.makeGraphic(50, 50, StaticVars.BLACK, false, "1");
			//addLock(100, 100);
			//add(boxes);
			/*
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
			
			
			if (currTheme == StaticVars.C_THEME) {
				var recycleInstr:FlxText = new FlxText(0, yPos += 60, FlxG.width, "1 for trash bin\n2 for recycle bin\n3 for compost bin");
				recycleInstr.setFormat(null, 16, StaticVars.BLACK, "center");
				add(recycleInstr);
			}
			
			if (currTheme == StaticVars.B_THEME) {
				var fogInstr:FlxText = new FlxText(0, yPos += 60, FlxG.width, "Space bar to fire ammo");
				fogInstr.setFormat(null, 16, StaticVars.BLACK, "center");
				add(fogInstr);
			}
			
			if (currTheme == StaticVars.A_THEME) {
				var shoot:FlxText = new FlxText(0, yPos += 60, FlxG.width, "Space bar to fire in Level 5");
				shoot.setFormat(null, 16, StaticVars.BLACK, "center");
				add(shoot);
			}*/
		}
		
		/*private function getArray():void {
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
		}*/
		
		private function addLock(x:int, y:int):void {
			var locks:FlxSprite = new FlxSprite(x, y);
			locks.loadGraphic(lock, true, true, 30, 30);
			add(locks);
		}
		
		private function addStar():void {
			var starIcon:FlxSprite = new FlxSprite(370, yPos - 3);
			starIcon.loadGraphic(star, true, true, 24, 24);
			add(starIcon);
		}
		
		/*private function createText(x:int, y:int, fontSize:int, theme:String, color:int):FlxText {
			var text:FlxText = new FlxText(x, y, FlxG.width, theme);
			text.setFormat(null, fontSize, StaticVars.BLACK, "center");// , null, 0xFF0000);
			return text;
		}*/
		
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
				State.levelArr[11][0] = true;
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