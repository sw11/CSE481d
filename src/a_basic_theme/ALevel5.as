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
	public class ALevel5 extends PlayState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var _ammos:FlxGroup;
		private var bucket: Bucket;
		
		private var ammo:int;
		private var ammoText:FlxText;
		
		public function ALevel5():void {
			maxScore = StaticVars.a5MaxScore;
			super(StaticVars.aTime);	
			ammo = StaticVars.a5AmmoNum;
			passScore = maxScore * StaticVars.aPass;
			currectTheme = StaticVars.A_THEME;
			level = 5;
			_fallObj = new FlxGroup();
			add(_fallObj);
			_bombs = new FlxGroup();
			add(_bombs);
			_ammos = new FlxGroup();
			add(_ammos);
			
			ammoText = new FlxText(0, 56, FlxG.width, "Ammo: " + ammo);
			ammoText.setFormat(null, 11, StaticVars.BLACK, "left");
			add(ammoText);
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
			FlxG.overlap(_ammos, _bombs, overlapAmmoBomb);
			

			if (genRandom(StaticVars.a5Interval)  && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.a5BombRate) && _bombs.countLiving() < 5) 
				{
					fallBomb(randNum(-StaticVars.yOffset) - StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
				}
				else {
					fallObject(StaticVars.yOffset, StaticVars.fallSpeedMid);
				}		
				isStart = true;
			}
			
			if (FlxG.keys.justPressed("SPACE") && ammo > 0) {
				fireAmmo(bucket.x + 35);
				ammoText.text = "Ammo: " + ammo;
			} else if (FlxG.keys.justPressed("SPACE")) {
				ammoText.color = StaticVars.RED;
			}
			
			super.update();
			
			if (_fallObj.countLiving() == 0 && _bombs.countLiving() == 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(5);
			}
		}
		
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			b.kill();
			this.score -= StaticVars.a5BombScore;	
		}
		
		private function fireAmmo(xPos:int):void {
			ammo -= 1;
			_ammos.add(new Ammos(xPos, 550));
		}
		
		private function overlapAmmoBomb(ammoObj:Ammos, bomb:Bomb):void {
			ammoObj.kill();
			bomb.kill();
			// todo add explosion
		}
	}
}