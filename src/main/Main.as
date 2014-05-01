package main
{
	import org.flixel.*;
	import utility.StaticVars
	[SWF(width="640", height="640", backgroundColor="#ffffff")] 
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			super(StaticVars.WIDTH, StaticVars.HEIGHT, MenuState,1);
		}		
	}
}