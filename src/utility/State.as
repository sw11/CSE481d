package utility 
{
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class State 
	{
		
		public static var unlockTheme:int;
		public static var unlockLevel:int;
		public static const maxLevel:int = 5;
		public static const maxTheme:int = 4;
		public static var unlockLevels:Array = new Array(1, 1, 1, 1);
		
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
		
		//public static var level1:Array = new Array(false, false, false, false, false, false);
		
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
	}

}