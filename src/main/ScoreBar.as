package main 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class ScoreBar extends FlxSprite 
	{
		private var max_height : Number;
		private var score_height : Number;
	
		private var score : Number;
		
		public function ScoreBar() {
			max_height = 495;
			
			
			super(15, 495);
			//width = 8;
			//height = 32;
			color = 0x99999999;
			//drawLine(x, y, x + 10, y + 10, 0x555555, 5);
			makeGraphic(100, 495, 0x55555555, false, null);
			score = 0;
			drawScoreBar();
		}
		
		private function drawScoreBar() : void {
			score_height = max_height - (max_height - score * 10);
			this.y = max_height - score_height;
			this.height = score_height;
			//makeGraphic(100, score_height, 0x55555555, false, null);
		}
		
		public function setScore(score:Number) : void{
			this.score = score;
			drawScoreBar();
		}
	}
}