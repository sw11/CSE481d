package beginner 
{
	import org.flixel.*;
	import utility.StaticVars;
	import main.*;
	import fall_object.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class ALevel4 extends APlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		public function ALevel4():void {
			maxScore = StaticVars.a4MaxScore;
			level = 4;
			super(StaticVars.aTime);	
			bombScore = StaticVars.a4BombScore;
			passScore = maxScore * StaticVars.aPass;
			instrStr = "Bombs, Bombs, Bombs!\nPress Enter to start.";
			
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
			super.update();
			if (paused) {
				return pauseGroup.update();
			}
			
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			FlxG.overlap(bucket, _bombs, overlapBombBucket);
			
			if (genRandom(StaticVars.a4Interval)  && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.a4BombRate) && _bombs.countLiving() < 5) 
				{
					fallBomb(randNum(-StaticVars.yOffset) - StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
				}
				else {
					fallObject(StaticVars.yOffset, StaticVars.fallSpeedMid);
				}		
				isStart = true;
			}
			
			if (_fallObj.countLiving() == 0 && _bombs.countLiving() == 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(4);
			}
		}
		/*
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.isKill()) {
				b.kill();
				this.score -= StaticVars.a4BombScore;
			}
		}*/
	}
}