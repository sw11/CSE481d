package easy_theme 
{
	import org.flixel.*;
	
	import main.PlayState;
	import main.Bucket;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level1 extends PlayState {	
		
		private var bucket: Bucket;
		[Embed(source = '../../img/wooden_bucket.png')] private var bucketImg:Class;
		
		private var _fallObj: FlxGroup;
		
		public function Level1():void {
			super();	
			_fallObj = new FlxGroup();
			add(_fallObj);
		}
	
		override public function create(): void {
			super.create();
			bucket = new Bucket(bucketImg, 130, 525);
			add(bucket);
		}
		
		override public function update():void 
		{
			if(FlxG.keys.justPressed("SPACE"))
			{
				// need to be auto
				failObject();					
			}
			 super.update();
			
		}
		
		private function failObject():void {
			// x should be random
			var obj:FallingObj = new FallingObj(500, 0);
			_fallObj.add(obj);
		}
	}

}