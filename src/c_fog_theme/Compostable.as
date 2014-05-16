package c_fog_theme 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Compostable extends FlxSprite
	{
		
		[Embed(source = '../../img/Apple.png')] private static var apple:Class;
		[Embed(source = '../../img/Flower.png')] private static var flower:Class;
		[Embed(source = '../../img/Grass.png')] private static var grass:Class;
		[Embed(source = '../../img/Leaves.png')] private static var leaves:Class;
		[Embed(source = '../../img/Poo.png')] private static var poo:Class;
		[Embed(source = '../../img/Tree.png')] private static var tree:Class;
		
		private static var objArr:Array = new Array(apple, flower, grass, leaves, poo, tree);
		
		public function Compostable (x:Number, y:Number) 
		{
			super(x, y);
			
			loadGraphic(getFallObjs(), false, false, 100, 100);
			velocity.y = 200; // move down velocity
		}
		
		
		public static function getFallObjs():Class {
			return FlxU.getRandom(objArr,0,5) as Class;
		}
		
	}

}