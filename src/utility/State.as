package utility 
{
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class State 
	{
		
		//public static var unlockTheme:int;
		//public static var unlockLevel:int = 1;
		public static const maxLevel:int = 12;
		public static var bonusTime:int = 0;
		//public static const maxTheme:int = 3; // todo only 3 themes available now
		//public static const maxTheme:int = 4;
		//public static var unlockLevels:Array = new Array(1, 1, 1, 1);
		/*
		public static var theme1:Array = new Array(new Array(true, false), // level 1, unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), 
												new Array(false, false), 
												new Array(false, false));
		public static var theme2:Array = new Array(new Array(true, false), // level 1, unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), 
												new Array(false, false), 
												new Array(false, false));
		public static var theme3:Array = new Array(new Array(true, false), // level 1, unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), 
												new Array(false, false), 
												new Array(false, false));
		public static var theme4:Array = new Array(new Array(true, false), // level 1, unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), // unlock, star
												new Array(false, false), 
												new Array(false, false), 
												new Array(false, false));
			*/									
		public static var levelArr:Array = new Array(new Array(true, false), // level 1, unlock, star
												new Array(false, false), // 2
												new Array(false, false), // 3
												new Array(false, false), // 4
												new Array(false, false), // 5
												new Array(false, false), // 6
												new Array(false, false), // 7
												new Array(false, false), // 8
												new Array(false, false), // 9
												new Array(false, false), // 10
												new Array(false, false), // 11
												new Array(false, false)  // 12
												);
		
		//public static var level1:Array = new Array(false, false, false, false, false, false);
		
		public static function toNextLevel(lv:int):void {
			if (lv == maxLevel) {
				// done!
			} else {
				//trace("State to next level " + unlockLevel);
				levelArr[lv][0] = true;
				//trace("To next level " + levelArr[unlockLevel][0]);
				//trace("to next level unlock level " + lv);
			}
			//unlockLevel = Math.min(++unlockLevel, 15);
		}
		
		public static function star(lv:int):void {
			levelArr[lv - 1][1] = true;
			//trace(levelArr[lv - 1][0] + " " + levelArr[lv - 1][1]);
		}
		/*
		public static function nextLevel():void {
			unlockLevel ++;
			
			if (unlockLevel > maxLevel) {
				///trace(theme1[unlockLevel][0]);
				unlockTheme = Math.min(maxTheme, ++unlockTheme);
				unlockLevel = 1;
			} else {
				unlockLevels[unlockTheme - 1] = unlockLevel;
				var arr:Array = setLevel();
				arr[unlockLevel - 1][0] = true;
			}
		}
		
		private static function setLevel():Array {
			switch (unlockTheme) {
				case 1:
					return theme1;
					break;
				case 2:
					return theme2;
					break;
				case 3:
					return theme3;
					break;
				case 4:
					return theme4;
					break;
			}
			return null;
		}
		
		public static function levelUpdate(): void {
			themeUpdate(theme1, unlockLevels[0]);
			themeUpdate(theme2, unlockLevels[1]);
			themeUpdate(theme3, unlockLevels[2]);
			themeUpdate(theme4, unlockLevels[3]);
		}
		
		private static function themeUpdate(arr:Array, lvl:int): void {
			var i:int = 0;
			for (; i < lvl; i++) {
				arr[i][0] = true;
			}
			for (var j:int = i; j < arr.length; j++) {
				arr[j][0] = false;
				arr[j][1] = false;
			}
		}*/
	}

}