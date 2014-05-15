package a_basic_theme 
{
	import org.flixel.*;
	import utility.StaticVars;
	import main.*;
	import fall_object.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class ALevel3 extends PlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		public function ALevel3():void {
			maxScore = StaticVars.a3MaxScore;
			super(StaticVars.aTime);	
			
			passScore = maxScore * StaticVars.aPass;
			currectTheme = StaticVars.A_THEME;
			level = 3;
			_fallObj = new FlxGroup();
			add(_fallObj);
			_bombs = new FlxGroup();
			add(_bombs);
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
			FlxG.overlap(bucket, _bombs, overlapBombBucket);
			
			if (genRandom(StaticVars.a3Interval)  && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.a3BombRate)) 
				{
					fallBomb(randNum(-StaticVars.yOffset) - StaticVars.yOffset, randNum(StaticVars.fallSpeedMid) + StaticVars.speedOffset);
				}
				else {
					fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				}		
				isStart = true;
			}
			super.update();
			
			if (_fallObj.countLiving() == 0 && _bombs.countLiving() == 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(3);
			}
		}
		
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			b.kill();
			this.score -= StaticVars.a3BombScore;	
		}
	}
}