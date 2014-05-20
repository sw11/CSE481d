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
	public class BLevel2 extends BPlayState {	
		
		public function BLevel2():void {
			maxScore = StaticVars.b2MaxScore;
			level = 2;
			super(StaticVars.bTime);
			bombScore = StaticVars.b2BombScore;
			passScore = maxScore * StaticVars.bPass;
			instrStr = "OMG, cannot see!\nPress Enter to start.";
		}
	
		override public function create(): void {
			bucket = new Bucket(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.b2FogYPos, fogImg);
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
			
			if (genRandom(StaticVars.b2Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = genLane(lane);
				if (oneOf(StaticVars.b2BombRate)) 
				{
					//var bombObj:Bomb = 
					fallBomb(StaticVars.yOffset, StaticVars.fallSpeedMid);
					//alphaArr.push(new Array(obj, 0, StaticVars.b2Alpha));		
				}
				else {
					var obj:FallingObj = fallObject(StaticVars.yOffset, StaticVars.fallSpeedSlow);
					alphaArr.push(new Array(obj, 0, StaticVars.b2Alpha));
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