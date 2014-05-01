package main 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Bucket extends FlxSprite
	{
		
		public function Bucket (graphic:Class, x:Number, y:Number) {
			super(x, y);
			loadGraphic(graphic, true, true, 100, 100);
		}	
		
	}

}