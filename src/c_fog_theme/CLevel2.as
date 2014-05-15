package c_fog_theme 
{
	import org.flixel.*;
	import utility.StaticVars;
	import main.*;
	import fall_object.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class CLevel2 extends PlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		[Embed(source = '../../img/grey.png')] private var fogImg:Class;
		
		private var fog:FlxSprite;
		
		//private var _fallObj: FlxGroup;
		//private var _bombs: FlxGroup;
		
		//private var remainingTimeDisplay:FlxText;
		
		public function CLevel2():void {
			maxScore = StaticVars.a2MaxScore;
			super(StaticVars.aTime);	
			
			passScore = maxScore * StaticVars.aPass;
			currectTheme = StaticVars.C_THEME;
			level = 2;
			_fallObj = new FlxGroup();
			add(_fallObj);
			_bombs = new FlxGroup();
			add(_bombs);
			fog = new FlxSprite(130, 200, fogImg);
			fog.alpha = 1;
			add(fog);
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, 130, 525);
			add(bucket);
		}
		
		override public function update():void 
		{	
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			FlxG.overlap(bucket, _bombs, overlapBombBucket);
			if (genRandom(StaticVars.a2Interval)) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.a2BombRate)) 
				{
					//fallBomb();
				}
				else {
					//fallObject();
				}			
			}
			super.update();
			
			if (timer.hasExpired) {
				// time has run out, check if user has won	
				endGame(8);
			}
		}
		/*
		private function fallObject():void {
			var obj:FallingObj = new FallingObj(lane, 0);
			_fallObj.add(obj);
		}
		
		private function fallBomb():void {
			var obj:Bomb = new Bomb(lane, 0);
			_bombs.add(obj);
		}
		
		private function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			this.score += 1;	
		}*/
		
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			b.kill();
			this.score -= 1;	
		}
	}
}