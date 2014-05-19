package fall_object 
{
	import org.flixel.*;
	import utility.*;
	import c_fog_theme.MultiBucket;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class FallingObj extends FlxSprite
	{	
		
		private var currentObj:int;
		
		public function FallingObj(x:Number, y:Number, isRecycle:Boolean) 
		{
			super(x, y);
			var randClass:Class;
			
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
			}
			loadGraphic(randClass, true, true, 100, 100);
			offset = new FlxPoint(0, StaticVars.objOffset);
			//velocity.y = 200; // move down velocity
		}
		
		public function getCurrentObj():int {
			return currentObj;
		}
	}

}