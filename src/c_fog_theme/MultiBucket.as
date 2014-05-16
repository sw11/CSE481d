package c_fog_theme
{
	import org.flixel.*;
	import utility.StaticVars;
	
	/**
	 * Class used for levels with multiple bucket types, 
	 * for recycling, compost and trash
	 * 
	 * @author Adrian
	 */
	public class MultiBucket extends FlxSprite
	{
		
		private var cycBucket : int;
		private var xCoord : int;
		private var yCoord : int;
		
		private static const _move_speed : int = 400;
		public static const TRASH : int = 0;
		public static const RECYCLE : int = 1;
		public static const COMPOST : int = 2;
		
		[Embed(source = '../../img/GarbageBin.png')] private var bucketImg:Class;
		[Embed(source = '../../img/RecycleBin.png')] private var recycleImg:Class;
		[Embed(source = '../../img/CompostBin.png')] private var compostImg:Class;
		
		public function MultiBucket (x:Number, y:Number) {
			super(x, y);
			xCoord = x;
			yCoord = y;
			loadGraphic(bucketImg, true, false, 100, 50);
			
			cycBucket = 0;
			
			addAnimation("add", [1, 0], 5, false);
			addAnimation("minus", [2, 0], 5, false);
			
		}	
		
		public function getCurrentBucket() : int {
			return (cycBucket + StaticVars.NUM_BUCKET) % StaticVars.NUM_BUCKET;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.LEFT && x > 130){
				velocity.x = -_move_speed ;
			} else if (FlxG.keys.RIGHT && x < 540) {
				velocity.x = _move_speed ;
			} else {
				velocity.x = 0;
			}
			
			if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("A")) {
				cycBucket++;
				switchBucket();
			} else if (FlxG.keys.justPressed("Z")) {
				cycBucket--;
				switchBucket();
			}
		}
		
		private function switchBucket():void {
			var num:int = cycBucket % StaticVars.NUM_BUCKET;
			//trace("buc is " + cycBucket + " num is " + num);
			if (num == 0) {
				loadGraphic(bucketImg, true, true, 100, 50);
				cycBucket = 0;
			} else if (num == 1 || num == -2) {
				loadGraphic(recycleImg, true, true, 100, 50);
			} else if (num == 2 || num == -1) {
				loadGraphic(compostImg, true, true, 100, 50);
			}
		}
	}

}