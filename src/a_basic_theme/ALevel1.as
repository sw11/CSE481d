package a_basic_theme 
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
	public class ALevel1 extends PlayState {	
		[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var bucket: Bucket;
		
		private var _fallObj: FlxGroup;
		
		//private var remainingTimeDisplay:FlxText;
		
		public function ALevel1():void {
			maxScore = StaticVars.a1MaxScore;
			super(StaticVars.aTime);	
			
			passScore = maxScore * StaticVars.aPass;
			currectTheme = "BASIC";
			
			_fallObj = new FlxGroup();
			add(_fallObj);	
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, 130, 525);
			add(bucket);
			
			//remainingTimeDisplay = new FlxText(0, 16, FlxG.width, ""+timer.secondsRemaining);
			//remainingTimeDisplay.setFormat(null, 16, 0x11111111, "center");
			//add(remainingTimeDisplay);
		}
		
		override public function update():void 
		{	
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			if (genRandom(StaticVars.a1Interval)) 
			{
				lane = genLane(lane);
				fallObject(lane);
			}
			super.update();
			
			if (timer.hasExpired) {
				// time has run out, check if user has won	
				endGame(1);
			}
			//remainingTimeDisplay.text = "" + timer.secondsRemaining;
			//checkScore();
		}
		
		private function fallObject(prevLane:int):void {
			// x should be random
			var obj:FallingObj = new FallingObj(prevLane, 0);
			_fallObj.add(obj);
		}
		
		private function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			this.score += 1;	
		}
	}
}