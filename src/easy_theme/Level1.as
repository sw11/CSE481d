package easy_theme 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.StaticVars;
	import main.PlayState;
	import main.Bucket;
	import main.WinState;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level1 extends PlayState {	
		
		private var bucket: Bucket;
		[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		private var _fallObj: FlxGroup;
		private var remainingTimeDisplay:FlxText;
		
	
		public function Level1():void {
			super(10, 30000);	
			_fallObj = new FlxGroup();
			add(_fallObj);
			timer = new FlxDelay(10000);
			timer.start();
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, 130, 525);
			add(bucket);
			
			
			remainingTimeDisplay = new FlxText(0, 16, FlxG.width, ""+timer.secondsRemaining);
			remainingTimeDisplay.setFormat(null, 16, 0x11111111, "center");
			add(remainingTimeDisplay);
		}
		
		override public function update():void 
		{
			
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			//trace();
			if (Math.round(Math.random()*100) == 3) 
			{
				// need to be auto
				failObject();					
			}
			 super.update();
			
			if (timer.hasExpired) {
				// time has run out, check if user has won	
				if (score == max_score) {
					var state:WinState = new WinState(1);
					FlxG.switchState(state);
				} else {
					
				}
			}
			remainingTimeDisplay.text = "" + timer.secondsRemaining;
		}
		
		private function failObject():void {
			// x should be random
			var obj:FallingObj = new FallingObj(FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int, 0);
			_fallObj.add(obj);
		}
		
		private function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			this.score += 1;	
		}
	}

}