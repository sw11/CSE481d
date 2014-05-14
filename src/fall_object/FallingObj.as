package fall_object 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class FallingObj extends FlxSprite
	{
		[Embed(source = '../../img/fallObjs/Axe.png')] private var axe:Class;
		[Embed(source = '../../img/fallObjs/Candy.png')] private var candy:Class;
		[Embed(source = '../../img/fallObjs/Chair.png')] private var chair:Class;
		[Embed(source = '../../img/fallObjs/Cup.png')] private var cup:Class;
		[Embed(source = '../../img/fallObjs/Fish.png')] private var fish:Class;
		[Embed(source = '../../img/fallObjs/Hammer.png')] private var hammer:Class;
		[Embed(source = '../../img/fallObjs/Microwave.png')] private var microwave:Class;
		[Embed(source = '../../img/fallObjs/Newspaper.png')] private var newspaper:Class;
		[Embed(source = '../../img/fallObjs/Pants.png')] private var pants:Class;
		[Embed(source = '../../img/fallObjs/Paper.png')] private var paper:Class;
		[Embed(source = '../../img/fallObjs/Phone.png')] private var phone:Class;
		[Embed(source = '../../img/fallObjs/Pizza.png')] private var pizza:Class;
		[Embed(source = '../../img/fallObjs/Sofa.png')] private var sofa:Class;
		[Embed(source = '../../img/fallObjs/Table.png')] private var table:Class;
		[Embed(source = '../../img/fallObjs/TShirt.png')] private var tShirt:Class;
		[Embed(source = '../../img/fallObjs/TV.png')] private var tv:Class;
		[Embed(source = '../../img/fallObjs/Zombie.png')] private var zombie:Class;
		
		
		
		public function FallingObj(x:Number, y:Number) 
		{
			super(x, y);
			//var fallObjs:Array = new Array(axe, candy, chair, cup, fish);
			var randClass:Class = Objects.getFallObjs();// FlxU.getRandom(fallObjs, 0, 5) as Class;
			loadGraphic(randClass, true, true, 100, 100);
			//makeGraphic(50, 50, 0xFF597137); // size and color of the object
			velocity.y = 200; // move down velocity
		}
		
		
	}

}