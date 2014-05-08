package recycle_theme 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Compostable extends FlxSprite
	{
		
		public function Compostable(x:Number, y:Number) 
		{
			super(x, y);
			makeGraphic(50, 50, 0xFF009933); // size and color of the object
			
			velocity.y = 200; // move down velocity
		}
		
	}

}