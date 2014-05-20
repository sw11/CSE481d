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
	public class ALevel3 extends APlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		public static const INSTRUCTION:String = "Catch everything, but avoid the bombs!\nPress Enter to start.";
		
		private var bucket: Bucket;
		
		public function ALevel3():void {
			maxScore = StaticVars.a3MaxScore;
			level = 3;
			super(StaticVars.aTime);	
			bombScore = StaticVars.a3BombScore;
			passScore = maxScore * StaticVars.aPass;
			instrStr = INSTRUCTION;
			
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
			
			if (_fallObj.countLiving() == 0 && _bombs.countLiving() == 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(3);
			}
		}
		/*
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.killed) {
				b.kill();
				this.score -= StaticVars.a3BombScore;
			}
		}*/
	}
}