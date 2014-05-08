package b_recycle_theme 
{
	
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Trash extends FlxSprite
	{
		
		public function Trash(x:Number, y:Number) 
		{
			super(x, y);
			makeGraphic(50, 50, 0xFF000033); // size and color of the object
			velocity.y = 200; // move down velocity
		}
		
	}

}