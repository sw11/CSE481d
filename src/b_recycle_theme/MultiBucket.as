package b_recycle_theme
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
		
		public static const TRASH : int = 0;
		public static const RECYCLE : int = 1;
		public static const COMPOST : int = 2;
		
		[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		[Embed(source = '../../img/recycle.png')] private var recycleImg:Class;
		[Embed(source = '../../img/compost.png')] private var compostImg:Class;
		
		public function MultiBucket (x:Number, y:Number) {
			super(x, y);
			xCoord = x;
			yCoord = y;
			loadGraphic(bucketImg, true, true, 100, 100);
			
			cycBucket = 0;
		}	
		
		public function getCurrentBucket() : int {
			return (cycBucket + StaticVars.NUM_BUCKET) % StaticVars.NUM_BUCKET;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.justPressed("RIGHT")) {
				if (x < 440) {
					x = xCoord + 100;
					xCoord = xCoord + 100;
					
				}
			} else if (FlxG.keys.justPressed("LEFT")) {
				if (x > 130) {				
					x = xCoord - 100;
					xCoord = xCoord - 100;
					
				}
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
				loadGraphic(bucketImg, true, true, 100, 100);
				cycBucket = 0;
			} else if (num == 1 || num == -2) {
				loadGraphic(recycleImg, true, true, 100, 100);
			} else if (num == 2 || num == -1) {
				loadGraphic(compostImg, true, true, 100, 100);
			}
		}
	}

}