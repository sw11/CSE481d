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
	public class CLevel1 extends CPlayState {	
		
		public function CLevel1():void {
			maxScore = StaticVars.c1MaxScore;
			level = 1;
			super(StaticVars.cTime);	
			passScore = maxScore * StaticVars.cPass;
			instrStr = "Right stuff into the right bin!\n1, 2 or 3 to switch the bin.\nPress Enter to start.";
		}
	
		override public function update():void 
		{
			super.update();
			if (paused) {
				return pauseGroup.update();
			}
			
			if (genRandom(StaticVars.c1Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				fallRecObj(StaticVars.fallSpeedMid);
				/*
				var num:int = randNum(StaticVars.NUM_BUCKET);
				if (num == 1) 
				{
					compostObject(StaticVars.fallSpeedSlow);
				}
				else if (num == 2) {
					recycleObject(StaticVars.fallSpeedSlow);
				} else {
					trashObject(StaticVars.fallSpeedSlow);
				}*/		
				isStart = true;
			}
			
			if (_fallObj.countLiving() <= 0 && isStart) {
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