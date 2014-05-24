package fall_object 
{
	import org.flixel.*;
	import utility.*;
	import advance.MultiBucket;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class FallingObj extends FlxSprite
	{	
		
		public static const RECYCLE:int = 1;
		public static const RECYCLE_AND_COMPOST:int = 2;
		public static const ALL_THREE:int = 3;
		
		private var currentObj:int;
		
		public function FallingObj(x:Number, y:Number, isRecycle:Boolean) 
		{
			super(x, y);
			var randClass:Class;
			
			if (isRecycle) {
				var num:int = Math.round(Math.random() * StaticVars.THREE_BUCKETS);
				if (num == 1) {
					currentObj = MultiBucket.RECYCLE;
					randClass = Objects.getRecycleObj();
				} else if (num == 2) {
					currentObj = MultiBucket.COMPOST;
					randClass = Objects.getCompostObj();
				} else {
					currentObj = MultiBucket.TRASH;
					randClass = Objects.getTrashObj();
				} 
			} else {
				randClass = Objects.getFallObjs();// FlxU.getRandom(fallObjs, 0, 5) as Class;
			}
			loadGraphic(randClass, true, true, 75, 75);
			offset = new FlxPoint(0, StaticVars.objOffset);
			//velocity.y = 200; // move down velocity
		}
		
		public function getCurrentObj():int {
			return currentObj;
		}
	}

}