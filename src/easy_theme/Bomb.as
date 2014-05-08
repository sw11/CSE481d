package easy_theme 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class Bomb extends FlxSprite
	{
		
		public function Bomb(x:Number, y:Number) 
		{
			super(x, y);
			makeGraphic(50, 50, 0x10597137); // size and color of the object
			velocity.y = 250; // move down velocity
		}
		
	}

}