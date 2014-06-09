package main
{
	import org.flixel.*;
	import utility.*;
	[SWF(width = "510", height = "640", backgroundColor = "#ffffff")] 
	[Embed(source = "../../font/SourceSansPro-Bold.otf", fontFamily = "sourcesanspro", embedAsCFF="false")]
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			super(StaticVars.WIDTH, StaticVars.HEIGHT, MainState,1);
		}		
	}
}