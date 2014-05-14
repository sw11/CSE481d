package fall_object 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class Objects 
	{
		[Embed(source = '../../img/fallObjs/Axe.png')] private static var axe:Class;
		[Embed(source = '../../img/fallObjs/Candy.png')] private static var candy:Class;
		[Embed(source = '../../img/fallObjs/Chair.png')] private static var chair:Class;
		[Embed(source = '../../img/fallObjs/Cup.png')] private static var cup:Class;
		[Embed(source = '../../img/fallObjs/Fish.png')] private static var fish:Class;
		[Embed(source = '../../img/fallObjs/Hammer.png')] private static var hammer:Class;
		[Embed(source = '../../img/fallObjs/Microwave.png')] private static var microwave:Class;
		[Embed(source = '../../img/fallObjs/Newspaper.png')] private static var newspaper:Class;
		[Embed(source = '../../img/fallObjs/Pants.png')] private static var pants:Class;
		[Embed(source = '../../img/fallObjs/Paper.png')] private static var paper:Class;
		[Embed(source = '../../img/fallObjs/Phone.png')] private static var phone:Class;
		[Embed(source = '../../img/fallObjs/Pizza.png')] private static var pizza:Class;
		[Embed(source = '../../img/fallObjs/Sofa.png')] private static var sofa:Class;
		[Embed(source = '../../img/fallObjs/Table.png')] private static var table:Class;
		[Embed(source = '../../img/fallObjs/TShirt.png')] private static var tShirt:Class;
		[Embed(source = '../../img/fallObjs/TV.png')] private static var tv:Class;
		[Embed(source = '../../img/fallObjs/Zombie.png')] private static var zombie:Class;
		
		private static var objArr:Array = new Array(axe, candy, chair, cup, fish, hammer, microwave, pants, paper, phone, pizza, sofa, table, tShirt, tv, zombie);
		
		public static function getFallObjs():Class {
			return  FlxU.getRandom(objArr, 0, 16) as Class;
		}
	}
}