package fall_object 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class AmmoCount extends FlxSprite
	{
		[Embed(source = '../../img/Ammo_small.png')] private static var ammo:Class;
		
		public function AmmoCount(x:Number, y:Number)  
		{
			super(x, y);
			loadGraphic(ammo, true, true, 18, 40);
		}		
	}

}