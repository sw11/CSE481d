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
	public class BLevel5 extends BPlayState {	
		
		public function BLevel5():void {
			maxScore = StaticVars.b5MaxScore;
			level = 5;
			super(StaticVars.b5Time);
			bombScore = StaticVars.b5BombScore;
			passScore = maxScore * StaticVars.bPass;
			
			ammo = StaticVars.b5AmmoNum;
			_ammos = new FlxGroup();
			add(_ammos);
			
			ammoText = new FlxText(0, 56, FlxG.width, "Ammo: " + ammo);
			ammoText.setFormat(null, 11, StaticVars.BLACK, "left");
			add(ammoText);
			
			instrStr = "Everything is disappear!\nPress Enter to start.";
		}
	
		override public function create(): void {
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.b5FogYPos, fogImg);
			fog.alpha = 1;
			fog.velocity.y = StaticVars.b5FogSpeed;
			add(fog);
			
			super.create();
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
			FlxG.overlap(_ammos, _bombs, overlapAmmoBomb);
			
			if (FlxG.keys.justPressed("SPACE") && ammo > 0) {
				fireAmmo(bucket.x + 35);
				ammoText.text = "Ammo: " + ammo;
			} else if (FlxG.keys.justPressed("SPACE")) {
				ammoText.color = StaticVars.RED;
			}
			
			if (genRandom(StaticVars.b5Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.b5BombRate)) 
				{
					var bombObj:Bomb = fallBomb(StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
					bombArr.push(new Array(bombObj, 0, StaticVars.b5Alpha));		
				}
				else {
					var obj:FallingObj = fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
					alphaArr.push(new Array(obj, 0, StaticVars.b5Alpha));
				}	
				isStart = true;
			}
			
			if (++fogSpeedCount % StaticVars.b5FogMove == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
			}
			
			for (var i:int = alphaArr.length - 1; i >= 0 ; i--) {
				var fallObj:FallingObj = alphaArr[i][0] as FallingObj;
				if (fallObj == null || !fallObj.alive) {
					alphaArr.splice(i, 1);
				}
				if (fallObj.alpha <= 0) {
					continue;
				}
				//if ((++alphaArr[i][1]) % StaticVars.b4FogRate == 0) {
				//	alphaArr[i][2] = -alphaArr[i][2];
				//}
				fallObj.alpha -= alphaArr[i][2];
			}
			
			for (var j:int = bombArr.length - 1; j >= 0 ; j--) {
				var bObj:Bomb = bombArr[j][0] as Bomb;
				if (bObj == null || !bObj.alive) {
					bombArr.splice(j, 1);
					continue;
				}
				if (bObj.alpha <= 0) {
					continue;
				}
				//if ((++bombArr[j][1]) % StaticVars.fogRate == 0) {
				//	bombArr[j][2] = -bombArr[j][2];
				//}
				bObj.alpha -= bombArr[j][2];
			}
		}
	}
}