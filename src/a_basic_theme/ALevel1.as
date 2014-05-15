package a_basic_theme 
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
	public class ALevel1 extends PlayState {	
		[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		public function ALevel1():void {
			maxScore = StaticVars.a1MaxScore;
			super(StaticVars.aTime);	
			
			passScore = maxScore * StaticVars.aPass;
			currectTheme = StaticVars.A_THEME;
			level = 1;
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
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			if (genRandom(StaticVars.a1Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				isStart = true;
			}
			super.update();

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