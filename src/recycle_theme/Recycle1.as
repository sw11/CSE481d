package recycle_theme 
{
	import recycle_theme.MultiBucket;
	import main.PlayState;
	import org.flixel.*;
	import utility.StaticVars;
	import easy_theme.FallingObj;
	import easy_theme.Bomb;
	
	import main.WinState;
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Recycle1 extends PlayState
	{
		
		private var bucket: MultiBucket;
		
		private var _recycables: FlxGroup;
		private var _trash: FlxGroup;
		private var _compost: FlxGroup;
		private var remainingTimeDisplay:FlxText;
		private var preLane:int;
	
		public function Recycle1():void {
			super(50, 30000);	
			
			_recycables = new FlxGroup();
			add(_recycables);
			_trash = new FlxGroup();
			add(_trash);
			_compost = new FlxGroup();
			add(_compost);

		}
	
		override public function create(): void {
			super.create();
			bucket = new MultiBucket(130, 525);
			add(bucket);
			
			
			remainingTimeDisplay = new FlxText(0, 16, FlxG.width, ""+timer.secondsRemaining);
			remainingTimeDisplay.setFormat(null, 16, 0x11111111, "center");
			add(remainingTimeDisplay);
		}
		
		override public function update():void 
		{
			
			FlxG.overlap(bucket, _recycables, overlapRecycle);
			FlxG.overlap(bucket, _trash, overTrash);
			FlxG.overlap(bucket, _compost, overlapCompost);
			
			
			if (Math.round(Math.random()*10) == 3) 
			{
				var lane:int =  FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int;
				while (lane == preLane) {
					lane =  FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int;
				}
				preLane = lane;
				if (Math.round(Math.random() * 3) == 2) 
				{
					var obj:Compostable = new Compostable(preLane, 0);
					_compost.add(obj);
					trace("add compost");
				}
				else if (Math.round(Math.random() * 3) == 1) {
					// need to be auto
					failObject(preLane);
					trace("add recycle");
				} else {
					var trash:Trash = new Trash(preLane, 0);
					_trash.add(trash);
					trace("add trash");
				}
									
			}
			 super.update();
			//trace(timer.secondsElapsed);
			if (timer.hasExpired) {
				// time has run out, check if user has won	
				
				if (score >= max_score*StaticVars.pass) {
					var state:WinState = new WinState(2);
					FlxG.switchState(state);
				} else {
					var lostState:WinState = new WinState(0);
					FlxG.switchState(lostState);
				}
			}
			remainingTimeDisplay.text = "" + timer.secondsRemaining;
			checkScore();
		}
		
		private function failObject(prevLane:int):void {
			// x should be random
			var obj:Recycable = new Recycable(preLane, 0);
			_recycables.add(obj);
		}
		
		private function overlapRecycle(but:MultiBucket, obj:Recycable):void {
			obj.kill();
			if (but.getCurrentBucket() == MultiBucket.RECYCLE) {
				this.score += 1;	
			} else {
				this.score -= 1;
			}
		}
		
		private function overTrash(but:MultiBucket, b:Trash):void {
			b.kill();
			if (but.getCurrentBucket() == MultiBucket.TRASH) {
				this.score += 1;	
			} else {
				this.score -= 1;
			}
		}
		
		private function overlapCompost (but:MultiBucket, obj:Compostable):void {
			obj.kill();
			if (but.getCurrentBucket() == MultiBucket.COMPOST) {
				this.score += 1;
			} else {
				this.score -= 1;
			}
		}
	}

}