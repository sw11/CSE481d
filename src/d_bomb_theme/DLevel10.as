package d_bomb_theme 
{
	import org.flixel.*;
	import utility.StaticVars;
	import main.*;
	import fall_object.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class DLevel10 extends DPlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		//private var _bombs: FlxGroup;
		
		//private var remainingTimeDisplay:FlxText;
		
		public function DLevel10():void {
			maxScore = StaticVars.d10MaxScore;
			super(StaticVars.dTime);	
			
			passScore = maxScore * StaticVars.dPass;
			currectTheme = StaticVars.D_THEME;
			level = 10;
			_bombs = new FlxGroup();
			add(_bombs);
			
			StaticVars.logger.logLevelStart(10, null);
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, 130, 525);
			add(bucket);
			
			score = maxScore;
		}
		
		override public function update():void 
		{	
			FlxG.overlap(bucket, _bombs, overlapBombBucket);
			if (genRandom(StaticVars.d10Interval)) 
			{
				lane = genLane(lane);
				//fallBomb();			
			}
			super.update();
			
			if (timer.hasExpired) {
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				// time has run out, check if user has won	
				endGame(10);
			}
		}
		
		/*private function fallBomb():void {
			var obj:Bomb = new Bomb(lane, 0);
			_bombs.add(obj);
		}*/
		/*
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.killed) {
				b.kill();
				this.score -= 1;
			}
		}*/
	}
}