package main
{
	import org.flixel.*;
	import utility.*;
	[SWF(width = "510", height = "640", backgroundColor = "#ffffff")] 
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			super(StaticVars.WIDTH, StaticVars.HEIGHT, MainState, 1);
			new EmbedFont();
		}		
	}
}