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
	public class BLevel4 extends BPlayState {	
		
		public function BLevel4():void {
			maxScore = StaticVars.b3MaxScore;
			level = 3;
			super(StaticVars.bTime);
			bombScore = StaticVars.b3BombScore;
			passScore = maxScore * StaticVars.bPass;
			
			ammo = StaticVars.b3AmmoNum;
			_ammos = new FlxGroup();
			add(_ammos);
			
			ammoText = new FlxText(0, 56, FlxG.width, "Ammo: " + ammo);
			ammoText.setFormat(null, 11, StaticVars.BLACK, "left");
			add(ammoText);
			
			instrStr = "At least I can see the bomb.\nShot it!\nPress Enter to start.";
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.b2FogYPos, fogImg);
			fog.alpha = 1;
			fog.velocity.y = StaticVars.fogSpeed;
			add(fog);
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
			
			if (genRandom(StaticVars.b3Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.b3BombRate)) 
				{
					//var bombObj:Bomb = 
					fallBomb(randNum(-StaticVars.yOffset) - StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
					//alphaArr.push(new Array(obj, 0, StaticVars.b2Alpha));		
				}
				else {
					var obj:FallingObj = fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
					alphaArr.push(new Array(obj, 0, StaticVars.b3Alpha));
				}	
				isStart = true;
			}
			
			if (++fogSpeedCount % StaticVars.fogRate == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
			}
			
			for (var i:int = alphaArr.length - 1; i >= 0 ; i--) {
				var fallObj:FallingObj = alphaArr[i][0] as FallingObj;
				if (fallObj == null || !fallObj.alive) {
					alphaArr.splice(i, 1);
				}
				if (fallObj.alpha >= 1) {
					continue;
				}
				if ((++alphaArr[i][1]) % StaticVars.fogRate == 0) {
					alphaArr[i][2] = -alphaArr[i][2];
				}
				fallObj.alpha -= alphaArr[i][2];
			}
		}
		

	}
}