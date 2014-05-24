package fall_object 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class Ammos extends FlxSprite
	{
		[Embed(source = '../../img/Ammo.png')] private static var ammo:Class;
		
		public function Ammos(x:Number, y:Number)  
		{
			super(x, y);
			loadGraphic(ammo, true, true, 20, 45);
			velocity.y = -250; // move down velocity
		}		
	}

}