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
		
		
		
		public function Level1():void {
			super();
			bucket = new Bucket(bucketImg, 130, 525);
			add(bucket);
		}
	
		/*override public function update():void 
		{
			 super.update();
			 if (FlxG.keys.RIGHT && !depressed) {
				bucket.moveRight(); 
				
			} else if (FlxG.keys.LEFT && ! depressed) {
				bucket.moveLeft();
			} else if (!FlxG.keys.LEFT && !FlxG.keys.RIGHT) {
				depressed = false;
			}
		}*/
	}

}