package easy_theme 
{
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
		
	}

}