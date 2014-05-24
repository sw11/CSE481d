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
		[Embed(source = '../../img/fallObjs/Axe.png')] public static var axe:Class;
		[Embed(source = '../../img/fallObjs/Candy.png')] public static var candy:Class;
		[Embed(source = '../../img/fallObjs/Chair.png')] public static var chair:Class;
		[Embed(source = '../../img/fallObjs/Cup.png')] public static var cup:Class;
		[Embed(source = '../../img/fallObjs/Fish.png')] public static var fish:Class;
		[Embed(source = '../../img/fallObjs/Hammer.png')] public static var hammer:Class;
		[Embed(source = '../../img/fallObjs/Microwave.png')] public static var microwave:Class;
		[Embed(source = '../../img/fallObjs/Newspaper.png')] public static var newspaper:Class;
		[Embed(source = '../../img/fallObjs/Pants.png')] public static var pants:Class;
		[Embed(source = '../../img/fallObjs/Paper.png')] public static var paper:Class;
		[Embed(source = '../../img/fallObjs/Phone.png')] public static var phone:Class;
		[Embed(source = '../../img/fallObjs/Pizza.png')] public static var pizza:Class;
		[Embed(source = '../../img/fallObjs/Sofa.png')] public static var sofa:Class;
		[Embed(source = '../../img/fallObjs/Table.png')] public static var table:Class;
		[Embed(source = '../../img/fallObjs/TShirt.png')] public static var tShirt:Class;
		[Embed(source = '../../img/fallObjs/TV.png')] public static var tv:Class;
		//[Embed(source = '../../img/fallObjs/Zombie.png')] private static var zombie:Class;
		
		private static var objArr:Array = new Array(axe, candy, chair, cup, fish, hammer, microwave, pants, paper, phone, pizza, sofa, table, tShirt, tv);// , zombie);
		
		public static function getFallObjs():Class {
			return  FlxU.getRandom(objArr, 0, 15) as Class;
		}
		
		private static var foodArr:Array = new Array(candy, pizza);
		
		public static function getFoodObj():Class {
			return FlxU.getRandom(foodArr, 0, 2) as Class;
		}
		
		[Embed(source = '../../img/trash/AxeBlack.png')] private static var axeB:Class;
		[Embed(source = '../../img/trash/ChairBlack.png')] private static var chairB:Class;
		[Embed(source = '../../img/trash/HammerBlack.png')] private static var hammerB:Class;
		[Embed(source = '../../img/trash/MagnetBlack.png')] private static var magnetB:Class;
		[Embed(source = '../../img/trash/MicrowaveBlack.png')] private static var microwaveB:Class;
		[Embed(source = '../../img/trash/PhoneBlack.png')] private static var phoneB:Class;
		[Embed(source = '../../img/trash/SofaBlack.png')] private static var sofaB:Class;
		[Embed(source = '../../img/trash/TableBlack.png')] private static var tableB:Class;
		[Embed(source = '../../img/trash/TabletBlack.png')] private static var tabletB:Class;
		[Embed(source = '../../img/trash/TVBlack.png')] private static var tvB:Class;
		
		private static var trashArr:Array = new Array(axeB, chairB, hammerB, magnetB, microwaveB, phoneB, sofaB, tableB, tabletB, tvB);
		public static function getTrashObj():Class {
			return FlxU.getRandom(trashArr, 0, 10) as Class;
		}
		
		[Embed(source = '../../img/recycle/Bottle.png')] private static var bottle:Class;
		[Embed(source = '../../img/recycle/Can.png')] private static var can:Class;
		[Embed(source = '../../img/recycle/Glass.png')] private static var glass:Class;
		[Embed(source = '../../img/recycle/Plastic.png')] private static var plastic:Class;
		
		private static var recycleArr:Array = new Array(bottle, can, glass, plastic);
		
		public static function getRecycleObj():Class {
			return  FlxU.getRandom(recycleArr, 0, 4) as Class;
		}
		
		[Embed(source = '../../img/compost/Apple.png')] private static var apple:Class;
		[Embed(source = '../../img/compost/Flower.png')] private static var flower:Class;
		[Embed(source = '../../img/compost/Grass.png')] private static var grass:Class;
		[Embed(source = '../../img/compost/Leaves.png')] private static var leaves:Class;
		[Embed(source = '../../img/compost/Poo.png')] private static var poo:Class;
		[Embed(source = '../../img/compost/Tree.png')] private static var tree:Class;
		
		private static var compostArr:Array = new Array(apple, flower, grass, leaves, poo, tree);
		public static function getCompostObj():Class {
			return  FlxU.getRandom(compostArr, 0, 6) as Class;
		}
	}
}