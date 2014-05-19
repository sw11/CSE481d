package main
{
	import org.flixel.*;
	import utility.*;
	[SWF(width="640", height="640", backgroundColor="#ffffff")] 
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			State.unlockTheme = 1;
			State.unlockLevel = 1;
			super(StaticVars.WIDTH, StaticVars.HEIGHT, ThemeState,1);
		}		
	}
}