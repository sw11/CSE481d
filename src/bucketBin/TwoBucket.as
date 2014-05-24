package bucketBin
{
	import org.flixel.*;
	import utility.StaticVars;
	
	/**
	 * Class used for levels with multiple bucket types, 
	 * for recycling, compost and trash
	 * 1 for Trash
	 * 2 for recycle
	 * 3 for compost
	 * @author Adrian
	 */
	public class TwoBucket extends FlxSprite
	{
		
		private var cycBucket : int;
		//private var xCoord : int;
		//private var yCoord : int;
		public var healthLeft:int;
		
		//private static const _move_speed : int = 400;
		public static const TRASH : int = 0;
		public static const RECYCLE : int = 1;
		//public static const COMPOST : int = 2;
		
		[Embed(source = '../../img/GarbageBin.png')] private var bucketImg:Class;
		[Embed(source = '../../img/RecycleBin.png')] private var recycleImg:Class;
		//[Embed(source = '../../img/CompostBin.png')] private var compostImg:Class;
		
		public function TwoBucket (x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			loadGraphic(recycleImg, true, false, 100, 50);
			maxVelocity.x = 200;
			
			addAnimation("add", [1, 0], 10, false);
			addAnimation("minus", [2, 0], 10, false);
			//cycBucket = 1;
			//switchBucket();
		}	
		
		public function getCurrentBucket() : int {
			return cycBucket;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.LEFT && x > StaticVars.BUCKET_LEFT){
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < StaticVars.BUCKET_RIGHT) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}
			
			if (FlxG.keys.justPressed("ONE")) {
				cycBucket = 0;
				loadGraphic(bucketImg, true, true, 100, 50);
			} else if (FlxG.keys.justPressed("TWO")) {
				cycBucket = 1;
				loadGraphic(recycleImg, true, true, 100, 50);
			} 
			//else if (FlxG.keys.justPressed("THREE")) {
			//	cycBucket = 2;
			//	switchBucket();
			//}
		}
		
		public function tutorialBucketSwitching(bucketNum:int):void {
			cycBucket = bucketNum;
			switchBucket();
		}
		
		private function switchBucket():void {
			//var num:int = cycBucket % StaticVars.TWO_BUCKETS;
			//trace("buc is " + cycBucket + " num is " + num);
			if (cycBucket == 0) {
				loadGraphic(bucketImg, true, true, 100, 50);
				//cycBucket = 0;
			} else if (cycBucket == 1) {
				loadGraphic(recycleImg, true, true, 100, 50);
			} 
			//else if (num == 2 || num == -1) {
			//	loadGraphic(compostImg, true, true, 100, 50);
			//}
		}
	}

}