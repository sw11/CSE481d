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
	public class ALevel2 extends APlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		public function ALevel2():void {
			maxScore = StaticVars.a2MaxScore;
			super(StaticVars.aTime);	
			bombScore = 1;
			passScore = maxScore * StaticVars.aPass;
			///currectTheme = StaticVars.A_THEME;
			level = 2;
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
			
			if (genRandom(StaticVars.a2Interval) && !isMaxScore && !timer.hasExpired)
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.a2BombRate)) 
				{
					fallBomb(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				}
				else {
					fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				}	
				isStart = true;
			}
			super.update();
			//trace(_fallObj.countLiving() + " " +  _bombs.countLiving());
			if (_fallObj.countLiving() <= 0 && _bombs.countLiving() <= 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(2);
			}
		}
		/*
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.killed) {
				b.kill();
				but.play("red", false);
				this.score -= 1;
			}
		}
		*/
		
	}
}