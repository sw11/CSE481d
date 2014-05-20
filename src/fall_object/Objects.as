package fall_object 
{
	import org.flixel.*;
	import advance.MultiBucket;
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
		
		
		
		[Embed(source = '../../img/AxeBlack.png')] private static var axeB:Class;
		[Embed(source = '../../img/ChairBlack.png')] private static var chairB:Class;
		[Embed(source = '../../img/HammerBlack.png')] private static var hammerB:Class;
		[Embed(source = '../../img/MagnetBlack.png')] private static var magnetB:Class;
		[Embed(source = '../../img/MicrowaveBlack.png')] private static var microwaveB:Class;
		[Embed(source = '../../img/PhoneBlack.png')] private static var phoneB:Class;
		[Embed(source = '../../img/SofaBlack.png')] private static var sofaB:Class;
		[Embed(source = '../../img/TableBlack.png')] private static var tableB:Class;
		[Embed(source = '../../img/TabletBlack.png')] private static var tabletB:Class;
		[Embed(source = '../../img/TVBlack.png')] private static var tvB:Class;
		
		private static var trashArr:Array = new Array(axeB, chairB, hammerB, magnetB, microwaveB, phoneB, sofaB, tableB, tabletB, tvB);
		public static function getTrashObj():Class {
			return FlxU.getRandom(trashArr, 0, 10) as Class;
		}
		
		[Embed(source = '../../img/Bottle.png')] private static var bottle:Class;
		[Embed(source = '../../img/Can.png')] private static var can:Class;
		[Embed(source = '../../img/Glass.png')] private static var glass:Class;
		[Embed(source = '../../img/Plastic.png')] private static var plastic:Class;
		
		private static var recycleArr:Array = new Array(bottle, can, glass, plastic);
		
		public static function getRecycleObj():Class {
			return  FlxU.getRandom(recycleArr, 0, 4) as Class;
		}
		
		[Embed(source = '../../img/Apple.png')] private static var apple:Class;
		[Embed(source = '../../img/Flower.png')] private static var flower:Class;
		[Embed(source = '../../img/Grass.png')] private static var grass:Class;
		[Embed(source = '../../img/Leaves.png')] private static var leaves:Class;
		[Embed(source = '../../img/Poo.png')] private static var poo:Class;
		[Embed(source = '../../img/Tree.png')] private static var tree:Class;
		
		private static var compostArr:Array = new Array(apple, flower, grass, leaves, poo, tree);
		public static function getCompostObj():Class {
			return  FlxU.getRandom(compostArr, 0, 6) as Class;
		}
	}
}