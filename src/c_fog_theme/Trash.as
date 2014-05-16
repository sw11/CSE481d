package c_fog_theme 
{
	
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Trash extends FlxSprite
	{
		
		[Embed(source = '../../img/AxeBlack.png')] private static var axe:Class;
		[Embed(source = '../../img/ChairBlack.png')] private static var chair:Class;
		[Embed(source = '../../img/HammerBlack.png')] private static var hammer:Class;
		[Embed(source = '../../img/MagnetBlack.png')] private static var magnet:Class;
		[Embed(source = '../../img/MicrowaveBlack.png')] private static var microwave:Class;
		[Embed(source = '../../img/PhoneBlack.png')] private static var phone:Class;
		[Embed(source = '../../img/SofaBlack.png')] private static var sofa:Class;
		[Embed(source = '../../img/TableBlack.png')] private static var table:Class;
		[Embed(source = '../../img/TabletBlack.png')] private static var tablet:Class;
		[Embed(source = '../../img/TVBlack.png')] private static var tv:Class;
		
		private static var objArr:Array = new Array(axe, chair, hammer, magnet, microwave, phone, sofa, table, tablet, tv);
		
		public function Trash (x:Number, y:Number) 
		{
			super(x, y);
			
			loadGraphic(getFallObjs(), false, false, 100, 100);
			velocity.y = 200; // move down velocity
		}
		
		
		public static function getFallObjs():Class {
			return FlxU.getRandom(objArr,0,9) as Class;
		}
		
	}

}