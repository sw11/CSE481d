package fall_object 
{
	import org.flixel.*;
	import utility.*;
	import advance.MultiBucket;
	import levels.Helper;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class FallObjs extends FlxSprite
	{	
		
		public static const RECYCLE:int = 1;
		public static const RECYCLE_AND_COMPOST:int = 2;
		public static const ALL_THREE:int = 3;
		
		private var currentObj:int;
		
		public function FallObjs(x:Number, y:Number, fallObj:int) 
		{
			super(x, y);
			var randClass:Class;
			
			switch (fallObj) {
				case RECYCLE:
					randClass = Objects.getRecycleObj();
					break;
				case RECYCLE_AND_COMPOST:
					randClass = Helper.randNum(2) == 0 ? Objects.getCompostObj(): Objects.getRecycleObj();
					break;
				case ALL_THREE:
					var rand:int = Helper.randNum(3);
					if (rand == 0) {
						randClass = Objects.getRecycleObj();
					} else if (rand == 1) {
						randClass = Objects.getCompostObj();
					} else {
						randClass = Objects.getTrashObj();
					}
					break;
			}
			
			/*
			if (isRecycle) {
				var num:int = Math.round(Math.random() * StaticVars.NUM_BUCKET);
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
			}*/
			loadGraphic(randClass, true, true, 75, 75);
			offset = new FlxPoint(0, StaticVars.objOffset);
			//velocity.y = 200; // move down velocity
		}
		
		public function getCurrentObj():int {
			return currentObj;
		}
	}

}