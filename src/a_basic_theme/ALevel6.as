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
	public class ALevel6 extends BonusState { 
	 	[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var _ammos:FlxGroup;
		private var bucket: Bucket;
		private var ammoText:FlxText;
		
		public function ALevel6():void {
			maxScore = StaticVars.a6MaxScore;
			super(StaticVars.a6Time);	
			this.ammo = StaticVars.a6AmmoNum;
			passScore = maxScore * StaticVars.aPass;
			currectTheme = StaticVars.A_THEME;
			level = 6;
			//bombScore = StaticVars.a6BombScore;
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
			FlxG.overlap(bucket, _bombs, overlapBombBucket);
			FlxG.overlap(_ammos, _bombs, overlapAmmoBomb);
			

			if (genRandom(StaticVars.a6Interval))//  && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				//if (oneOf(StaticVars.a5BombRate) && _bombs.countLiving() < 5) 
				//{
					fallBomb(StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
				//}
				//else {
				//	fallObject(StaticVars.yOffset, StaticVars.fallSpeedMid);
				//}		
				//isStart = true;
			}
			//trace(_bombs.length);
			if (oneOf(50) && _bombs.length > 0) {
				var moveBomb:Bomb = _bombs.members[randNum(_bombs.length - 1)] as Bomb;
				if (moveBomb.y < 400) {
					//trace("move " + moveBomb.y);
					if (oneOf(2)){
						moveBomb.x = Math.max(130, moveBomb.x - 100);
					} else {
						moveBomb.x = Math.min(540, moveBomb.x + 100);
					}
				}
			}
			
			if (FlxG.keys.justPressed("SPACE") && this.ammo > 0) {
				fireAmmo(bucket.x + 35);
				ammoText.color = StaticVars.BLACK;
			} else if (FlxG.keys.justPressed("SPACE")) {
				ammoText.color = StaticVars.RED;
			}
			ammoText.text = "Ammo: " + this.ammo;
			super.update();
			
			if (timer.hasExpired) {
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(6);
			}
		}

		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.isKill()) {
				b.kill();
				miss++;
				this.score -= StaticVars.a6BombScore;	
			}
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