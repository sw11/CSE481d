package beginner 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.StaticVars;
	import main.*;
	import fall_object.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class ALevel1 extends APlayState {	
		[Embed(source = '../../img/wooden_bucket.png')] private static var bucketImg:Class;
		
		public static const INSTRUCTION:String = "Catch everything!\nPress Enter to start.";
		
		private var bucket: Bucket;
		
		public function ALevel1():void {
			maxScore = StaticVars.a1MaxScore;
			level = 1;
			super(StaticVars.aTime);	
			instrStr = INSTRUCTION;
			passScore = maxScore * StaticVars.aPass;
			_fallObj = new FlxGroup();
			add(_fallObj);	
			StaticVars.logger.logLevelStart(level, null);
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
		}
		
		override public function update():void 
		{	
			isMaxScore = score >= maxScore;
			super.update();
			if (paused) {
				return pauseGroup.update();
			}
			
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			if (genRandom(StaticVars.a1Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				isStart = true;
			}
			

			if (_fallObj.countLiving() <= 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(1);
			}
		}
	}
}