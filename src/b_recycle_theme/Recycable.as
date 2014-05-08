package b_recycle_theme 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Recycable extends FlxSprite
	{
		
		public function Recycable (x:Number, y:Number) 
		{
			super(x, y);
			makeGraphic(50, 50, 0xFF3333FF); // size and color of the object
			velocity.y = 200; // move down velocity
		}
		
	}

}