package c_fog_theme 
{
	import org.flixel.*;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Recycable extends FlxSprite
	{
		[Embed(source = '../../img/Bottle.png')] private static var bottle:Class;
		[Embed(source = '../../img/Can.png')] private static var can:Class;
		[Embed(source = '../../img/Glass.png')] private static var glass:Class;
		[Embed(source = '../../img/Plastic.png')] private static var plastic:Class;
		
		private static var objArr:Array = new Array(bottle, can, glass, plastic);
		
		public function Recycable (x:Number, y:Number) 
		{
			super(x, y);
			
			loadGraphic(getFallObjs(), false, false, 100, 100);
			velocity.y = 200; // move down velocity
		}
		
		
		public static function getFallObjs():Class {
			return FlxU.getRandom(objArr,0,3) as Class;
		}
	}

}