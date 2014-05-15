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
		public static const maxLevel:int = 6;
		public static const maxTheme:int = 4;
		public static var theme1:Array = new Array(false, false, false, false, false, false);
		public static var theme2:Array = new Array(false, false, false, false, false, false);
		public static var theme3:Array = new Array(false, false, false, false, false, false);
		public static var theme4:Array = new Array(false, false, false, false, false, false);
		
		public static function nextLevel():void {
			unlockLevel ++;
			if (unlockLevel > maxLevel) {
				unlockTheme = Math.min(maxTheme, ++unlockTheme);
				unlockLevel = 1;
			}
		}
	}

}