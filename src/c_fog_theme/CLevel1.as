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
			currectTheme = StaticVars.C_THEME;
			instrStr = "Right stuff into the right bin!\n1, 2 or 3 to switch the bin.\nPress Enter to start.";
		}
	/*
		override public function create(): void {
			super.create();
			//bucket = new MultiBucket(130, 525);
			//add(bucket);
		}
		*/
		override public function update():void 
		{
			isMaxScore = score >= maxScore;
			
			super.update();
			if (paused) {
				return pauseGroup.update();
			}
			
			if (genRandom(StaticVars.c1Interval)  && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				var num:int = randNum(StaticVars.NUM_BUCKET);
				if (num == 1) 
				{
					compostObject();
					//trace("add compost");
				}
				else if (num == 2) {
					recycleObject();
					//trace("add recycle");
				} else {
					trashObject();
					//trace("add trash");
				}		
				isStart = true;
			}
			super.update();
			
			if (_recycables.countLiving() <= 0 && _trash.countLiving() <= 0 && _compost.countLiving() <= 0 && isStart) {
				bonus = Math.max(0, timer.secondsRemaining);
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				endGame(level);
			}
			/*
			if (timer.hasExpired) {
				//log info about score and miss count	
				var data:Object = {"finalScore":score, "misses":miss};
				StaticVars.logger.logLevelEnd(data);
				// time has run out, check if user has won	
				endGame(4);
			}*/
			
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