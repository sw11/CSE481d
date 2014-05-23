package main
{
	import org.flixel.*;
	import utility.*;
	
	/**
	 * Class used for levels with multiple bucket types, 
	 * for recycling, compost and trash
	 * 
	 * @author Adrian
	 */
	public class Buckets extends FlxSprite
	{
		
		private var cycBucket : int;
		private var xCoord : int;
		private var yCoord : int;
		private var state:int;
		public var score:Number;
		//private static const _move_speed : int = 400;
		public static const TRASH : int = 0;
		public static const RECYCLE : int = 1;
		public static const COMPOST : int = 2;
		public static const NORMAL: int = 3;
		
		[Embed(source = '../../img/GarbageBin.png')] private static var bucketImg:Class;
		[Embed(source = '../../img/RecycleBin.png')] private static var recycleImg:Class;
		[Embed(source = '../../img/CompostBin.png')] private static var compostImg:Class;
		[Embed(source = '../../img/TrashCan1.png')] private static var bucket1Img:Class;
		[Embed(source = '../../img/wooden_bucket.png')] private static var bucket2Img:Class;
		
		public function Buckets (x:Number, y:Number, bucket:int) {
			super(x, y);
			xCoord = x;
			yCoord = y;
			state = bucket;
			//var graphic:Class = null;
			if (bucket == State.NORMAL) {
				//graphic = bucket2Img;
				loadGraphic(bucket2Img, true, false, 100, 50);
				addAnimation("green", [1, 0], 10, false);
				addAnimation("red", [2, 0], 3, false);
			} else if (bucket == State.FOG) {
				loadGraphic(bucket1Img, true, false, 100, 50);
				addAnimation("green", [1, 0], 10, false);
				addAnimation("red", [2, 0], 3, false);
			} else if (bucket == State.RECYCLE) {
				loadGraphic(bucketImg, true, false, 100, 50);
				cycBucket = 0;
				addAnimation("add", [1, 0], 10, false);
				addAnimation("minus", [2, 0], 10, false);
			}
			maxVelocity.x = 200;
			
		}	
		
		public function getCurrentBucket() : int {
			return (cycBucket + StaticVars.NUM_BUCKET) % StaticVars.NUM_BUCKET;
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.LEFT && x > 130){
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < 540) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}
			if (state != State.RECYCLE) {
				return;
			}
			
			if (FlxG.keys.justPressed("ONE")) {
				cycBucket = 0;
				switchBucket();
			} else if (FlxG.keys.justPressed("TWO")) {
				cycBucket = 1;
				switchBucket();
			} else if (FlxG.keys.justPressed("THREE")) {
				cycBucket = 2;
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