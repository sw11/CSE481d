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
	public class DLevel11 extends PlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		private var _bombs: FlxGroup;
		
		public function DLevel11():void {
			maxScore = StaticVars.d11MaxScore;
			super(StaticVars.dTime);	
			
			passScore = maxScore * StaticVars.dPass;
			currectTheme = "BOMB";
			level = 2;
			_bombs = new FlxGroup();
			add(_bombs);
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
			if (genRandom(StaticVars.d11Interval)) 
			{
				lane = genLane(lane);
				fallBomb(lane);			
			}
			super.update();
			
			if (timer.hasExpired) {
				// time has run out, check if user has won	
				endGame(11);
			}
		}
		
		private function fallBomb(lane:int):void {
			var obj:Bomb = new Bomb(lane, 0);
			_bombs.add(obj);
		}
		
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			b.kill();
			this.score -= 1;	
		}
	}
}