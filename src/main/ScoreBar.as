package main 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class ScoreBar extends FlxSprite 
	{
	
		private var score : Number;
		
		public function ScoreBar() {
			
			super(15, 130);
			//width = 8;
			//height = 32;
			color = 0x99999999;
			//drawLine(x, y, x + 10, y + 10, 0x555555, 5);
			makeGraphic(100, 495, 0x55555555, false, null);
		}
		
		public function setScore(score:Number) : void{
			
		}
	}

}