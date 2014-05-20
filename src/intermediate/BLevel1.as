package intermediate 
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
	public class BLevel1 extends BPlayState {	
		
		public function BLevel1():void {
			maxScore = StaticVars.b1MaxScore;
			level = 1;
			super(StaticVars.bTime);	
			bombScore = StaticVars.b1BombScore;
			passScore = maxScore * StaticVars.bPass;
			instrStr = "It's getting foggy!\nPress Enter to start.";
		}
	
		override public function create(): void {
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.b1FogYPos, fogImg);
			fog.alpha = 1;
			fog.velocity.y = StaticVars.fogSpeed;
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
			
			if (genRandom(StaticVars.b1Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.b1BombRate)) 
				{
					fallBomb(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				}
				else {
					fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
				}	
				isStart = true;
			}
			
			if (++fogSpeedCount % StaticVars.fogRate == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
			}
		}
	}
}