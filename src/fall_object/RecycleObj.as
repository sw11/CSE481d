package fall_object 
{
	import org.flixel.*;
	import utility.*;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class RecycleObj extends FlxSprite
	{	
		public function RecycleObj(x:Number, y:Number) 
		{
			super(x, y);
			var randClass:Class = Objects.getFallObjs();// FlxU.getRandom(fallObjs, 0, 5) as Class;
			loadGraphic(randClass, true, true, 100, 100);
			offset = new FlxPoint(0, StaticVars.objOffset);
			//velocity.y = 200; // move down velocity
		}
	}

}