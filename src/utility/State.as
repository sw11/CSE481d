package utility 
{
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class State 
	{
		
		
		public static const maxLevel:int = 12;
		public static var bonusTime:int = 0;
		
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
		
	}

}