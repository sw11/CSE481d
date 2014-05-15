package b_recycle_theme 
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
	public class BLevel1 extends PlayState {	
		[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		[Embed(source = '../../img/fog_3.png')] private var fogImg:Class;
		
		private var bucket: Bucket;
		private var fog:FlxSprite;
		
		private var fogSpeedCount:int;
		
		
		public function BLevel1():void {
			maxScore = StaticVars.b1MaxScore;
			super(StaticVars.bTime);	
			
			passScore = maxScore * StaticVars.bPass;
			currectTheme = StaticVars.B_THEME;
			level = 1;
			_fallObj = new FlxGroup();
			add(_fallObj);	
			StaticVars.logger.logLevelStart(level, null);
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			fog = new FlxSprite(130, 50, fogImg);
			fog.alpha = 1;
			fog.velocity.y = -10;
			add(fog);
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
			
			if (++fogSpeedCount % 100 == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
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