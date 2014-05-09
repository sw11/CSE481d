package a_basic_theme 
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
		private var _bombs: FlxGroup;
		private var remainingTimeDisplay:FlxText;
		private var preLane:int;
		
		private var maxScore:int;
		private var passScore:Number;
		private var maxObj:Number;
		private var fallObjSoFar:int;
	
		public function Level1():void {
			maxScore = StaticVars.a1MaxScore;
			super(maxScore, 30000);	
			
			passScore = maxScore * StaticVars.a1Pass;
			maxObj = maxScore * StaticVars.a1MaxObj;
			fallObjSoFar = 0;
			
			_fallObj = new FlxGroup();
			add(_fallObj);
			_bombs = new FlxGroup();
			add(_bombs);
			

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
			FlxG.overlap(bucket, _bombs, overlapBombBucket);
			
			
			//trace();
			if (Math.round(Math.random()*10) == 3) 
			{
				var lane:int =  FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int;
				while (lane == preLane) {
					lane =  FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int;
				}
				preLane = lane;
				if (Math.round(Math.random() * 3) == 2) 
				{
					var obj:Bomb = new Bomb(preLane, 0);
					_bombs.add(obj);
					//trace("add bomb");
				}
				else {
					// need to be auto
					failObject(preLane);
					//trace("add falling");
					fallObjSoFar ++;
				}
									
			}
			trace(maxObj + " " + fallObjSoFar);
			super.update();
			//trace(timer.secondsElapsed);
			if (timer.hasExpired || fallObjSoFar >= maxObj) {
				// time has run out, check if user has won	
				
				if (score >= passScore) {
					var state:WinState = new WinState(1);
					FlxG.switchState(state);
				} else {
					var lostState:PlayState = new Level1();
					FlxG.switchState(lostState);
				}
			}
			remainingTimeDisplay.text = "" + timer.secondsRemaining;
			checkScore();
		}
		
		private function failObject(prevLane:int):void {
			// x should be random
			var obj:FallingObj = new FallingObj(preLane, 0);
			_fallObj.add(obj);
		}
		
		private function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			this.score += 1;	
		}
		
		private function overlapBombBucket(but:Bucket, b:Bomb):void {
			b.kill();
			this.score -= 1;	
		}
	}

}