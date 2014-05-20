package advance 
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
	public class CLevel2 extends CPlayState {	
		
		public function CLevel2():void {
			maxScore = StaticVars.c2MaxScore;
			level = 2;
			super(StaticVars.cTime);	
			passScore = maxScore * StaticVars.cPass;
			instrStr = "Watch out the bombs!\nPress Enter to start.";
			bombScore = StaticVars.c2BombScore;
			_bombs = new FlxGroup();
			add(_bombs);
		}
	
		override public function update():void 
		{
			super.update();
			if (paused) {
				return pauseGroup.update();
			}
			
			FlxG.overlap(killBar, _bombs, overlapKillBarBomb);
			FlxG.overlap(bucket, _bombs, overlapBucketBomb);
			
			if (genRandom(StaticVars.c2Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				
				/*
				var num:int = randNum(StaticVars.NUM_BUCKET + 1);
				if (num == 1) {
					compostObject(StaticVars.fallSpeedMid);
				} else if (num == 2) {
					recycleObject(StaticVars.fallSpeedMid);
				} else if (num == 3){
					trashObject(StaticVars.fallSpeedMid);
				}*/
				if (randNum(StaticVars.c3BombRate) == 1) {
					//lane = genLane(lane);
					fallBomb(StaticVars.yOffset, randNum(StaticVars.fallSpeedFast) + StaticVars.speedOffset);
				} else {
					fallRecObj(StaticVars.fallSpeedMid);
				}
				isStart = true;
			}
			
			if (_fallObj.countLiving() <= 0 && _bombs.countLiving() <= 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(level);
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