package easy_theme 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class FallingObj extends FlxSprite
	{
		
		public function FallingObj(x:Number, y:Number):void 
		{
			super(x, y);
			makeGraphic(50, 50, 0xFF597137); // size and color of the object
			velocity.y = 200; // move down velocity
		}
	}

}