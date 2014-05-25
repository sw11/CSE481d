package fall_object 
{
	import org.flixel.*;
	import utility.*;
	import levels.Helper;
	import bucketBin.*;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class FallObjs extends FlxSprite
	{	
		
		public static const RECYCLE:int = 1;
		public static const TRASH_RECYCLE:int = 2;
		public static const ALL_THREE:int = 3;
		public static const TRASH:int = 4;
		public static const FOOD:int = 5;
		
		private var currentObj:int;
		
		public function FallObjs(x:Number, y:Number, fallObj:int) 
		{
			super(x, y);
			var randClass:Class;
			
			switch (fallObj) {
				case RECYCLE:
					randClass = Objects.getRecycleObj();
					break;
				case TRASH_RECYCLE:
					if (Helper.oneOf(StaticVars.TWO_BUCKETS)) {
						randClass = Objects.getTrashObj();
						currentObj = TwoBucket.TRASH;
					} else {
						randClass = Objects.getRecycleObj();
						currentObj = TwoBucket.RECYCLE;
					}
					break;
				case ALL_THREE:
					var rand:int = Helper.randNum(StaticVars.THREE_BUCKETS);
					if (rand == 0) {
						randClass = Objects.getRecycleObj();
						currentObj = ThreeBucket.RECYCLE;
					} else if (rand == 1) {
						randClass = Objects.getCompostObj();
						currentObj = ThreeBucket.COMPOST;
					} else {
						randClass = Objects.getTrashObj();
						currentObj = ThreeBucket.TRASH;
					}
					break;
				case TRASH:
					randClass = Objects.getTrashObj();
					break;
				case FOOD:
					randClass = Objects.getFoodObj();
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