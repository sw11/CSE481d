package c_fog_theme 
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
	public class CLevel5 extends CPlayState {	
		
		public function CLevel5():void {
			maxScore = StaticVars.c5MaxScore;
			level = 5;
			super(StaticVars.cTime);	
			passScore = maxScore * StaticVars.cPass;
			instrStr = "Watch out the bombs!\nPress Enter to start.";
			bombScore = StaticVars.c5BombScore;
			
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.b2FogYPos, fogImg);
			fog.alpha = 1;
			fog.velocity.y = StaticVars.fogSpeed;
			add(fog);
			_bombs = new FlxGroup();
			add(_bombs);
			/*
			ammo = StaticVars.b5AmmoNum;
			_ammos = new FlxGroup();
			add(_ammos);
			
			ammoText = new FlxText(0, 56, FlxG.width, "Ammo: " + ammo);
			ammoText.setFormat(null, 11, StaticVars.BLACK, "left");
			add(ammoText);*/
		}
	
		override public function update():void 
		{
			super.update();
			if (paused) {
				return pauseGroup.update();
			}
			
			FlxG.overlap(killBar, _bombs, overlapKillBarBomb);
			FlxG.overlap(bucket, _bombs, overlapBucketBomb);
			//FlxG.overlap(_ammos, _bombs, overlapAmmoBomb);
			
			if (genRandom(StaticVars.c5Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (randNum(StaticVars.c5BombRate) == 1) {
					var bombObj:Bomb = fallBomb(StaticVars.yOffset, randNum(StaticVars.fallSpeedSuper) + StaticVars.speedOffset);
					bombArr.push(new Array(bombObj, 0, StaticVars.c5Alpha));	
				} else {
					var obj:FallingObj = fallRecObj(StaticVars.fallSpeedMid);
					fallArr.push(new Array(obj, 0, StaticVars.c5Alpha));
				}
				
				/*
				var num:int = randNum(StaticVars.NUM_BUCKET);
				if (num == 1) {
					compostObject(StaticVars.fallSpeedMid);
				} else if (num == 2) {
					recycleObject(StaticVars.fallSpeedMid);
				} else {
					trashObject(StaticVars.fallSpeedMid);
				} */
				//if (randNum(StaticVars.c3BombRate) == 1) {
				//	lane = genLane(lane);
				//	fallBomb(StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
				//}
				isStart = true;
			}
			
			/*if (FlxG.keys.justPressed("SPACE") && ammo > 0) {
				fireAmmo(bucket.x + 35);
				ammoText.text = "Ammo: " + ammo;
			} else if (FlxG.keys.justPressed("SPACE")) {
				ammoText.color = StaticVars.RED;
			}	*/
			
			if (_fallObj.countLiving() <= 0 && _bombs.countLiving() <= 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(level);
			}
			
			if (++fogSpeedCount % StaticVars.fogRate == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
			}
			
			for (var i:int = fallArr.length - 1; i >= 0 ; i--) {
				var fallObj:FallingObj = fallArr[i][0] as FallingObj;
				if (fallObj == null || !fallObj.alive) {
					fallArr.splice(i, 1);
					continue;
				}
				if (fallArr.alpha >= 1) {
					continue;
				}
				if ((++fallArr[i][1]) % StaticVars.c5FogRate == 0) {
					fallArr[i][2] = -fallArr[i][2];
				}
				fallObj.alpha -= fallArr[i][2];
			}
			
			for (var j:int = bombArr.length - 1; j >= 0 ; j--) {
				var bObj:Bomb = bombArr[j][0] as Bomb;
				if (bObj == null || !bObj.alive) {
					bombArr.splice(j, 1);
					continue;
				}
				//if (bObj.alpha >= 1) {
				//	continue;
				//}
				if ((++bombArr[j][1]) % StaticVars.fogRate == 0) {
					bombArr[j][2] = -bombArr[j][2];
				}
				bObj.alpha -= bombArr[j][2];
			}
			
			if (bucket.getCurrentBucket() == MultiBucket.RECYCLE) {
				binIndicator.play("recycle", false);
			} else if (bucket.getCurrentBucket() == MultiBucket.COMPOST) {
				binIndicator.play("compost", false);
			} else {
				binIndicator.play("garbage", false);
			}
		}
		
	}
}