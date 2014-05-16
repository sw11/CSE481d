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
	public class BLevel1 extends BPlayState {	
		
		public function BLevel1():void {
			maxScore = StaticVars.b1MaxScore;
			level = 1;
			bombScore = StaticVars.b1BombScore;
			passScore = maxScore * StaticVars.bPass;
			super(StaticVars.bTime);	
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.b1FogYPos, fogImg);
			fog.alpha = 1;
			fog.velocity.y = StaticVars.fogSpeed;
			add(fog);
		}
		
		override public function update():void 
		{	
			isMaxScore = score >= maxScore;
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
			super.update();
			
			if (++fogSpeedCount % StaticVars.fogRate == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
			}
		}
	}
}