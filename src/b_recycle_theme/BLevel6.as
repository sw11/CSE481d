package b_recycle_theme 
{
	import main.PlayState;
	import org.flixel.*;
	import utility.StaticVars;

	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class BLevel6 extends PlayState
	{
		private var bucket: MultiBucket;
		
		private var _recycables: FlxGroup;
		private var _trash: FlxGroup;
		private var _compost: FlxGroup;
		
		public function BLevel6():void {
			maxScore = StaticVars.b3MaxScore;
			super(StaticVars.bTime);	
			
			passScore = maxScore * StaticVars.bPass;
			currectTheme = "RECYCLE";
			level = 3;
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
		}
		
		override public function update():void 
		{
			FlxG.overlap(bucket, _recycables, overlapRecycle);
			FlxG.overlap(bucket, _trash, overTrash);
			FlxG.overlap(bucket, _compost, overlapCompost);
			
			if (genRandom(StaticVars.b3Interval)) 
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
			}
			super.update();
			
			if (timer.hasExpired) {
				// time has run out, check if user has won	
				endGame(6);
			}
		}
		
		private function recycleObject():void {
			var obj:Recycable = new Recycable(lane, 0);
			_recycables.add(obj);
		}
		
		private function overlapRecycle(but:MultiBucket, obj:Recycable):void {
			obj.kill();
			if (but.getCurrentBucket() == MultiBucket.RECYCLE) {
				this.score += 1;	
			} else {
				this.score -= 2;
			}
		}
		
		private function overTrash(but:MultiBucket, b:Trash):void {
			b.kill();
			if (but.getCurrentBucket() == MultiBucket.TRASH) {
				this.score += 1;	
			} else {
				this.score -= 2;
			}
		}
		
		private function overlapCompost (but:MultiBucket, obj:Compostable):void {
			obj.kill();
			if (but.getCurrentBucket() == MultiBucket.COMPOST) {
				this.score += 1;
			} else {
				this.score -= 2;
			}
		}
		
		private function compostObject():void 
		{
			var obj:Compostable = new Compostable(lane, 0);
			_compost.add(obj);
		}
		
		private function trashObject():void 
		{
			var trash:Trash = new Trash(lane, 0);
			_trash.add(trash);
		}
	}

}