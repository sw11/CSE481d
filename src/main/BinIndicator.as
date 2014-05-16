package main 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class BinIndicator extends FlxSprite {
		
		[Embed(source = '../../img/vertical_highlight.png')] private var bucketImg:Class;
		
		public function BinIndicator (x:Number, y:Number) {
			super(x, y);
			
			loadGraphic(bucketImg, true, false, 100, 150);
			
			addAnimation("garbage", [0], 0, false);
			addAnimation("recycle", [1], 0, false);
			addAnimation("compost", [2], 0, false);
		}	
	}
}