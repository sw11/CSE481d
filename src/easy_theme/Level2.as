package easy_theme 
{
	import main.PlayState;
	import org.flixel.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Level2 extends PlayState
	{
		
		public function Level2() 
		{
			var winnerText:FlxText;
			winnerText = new FlxText(0, 16, FlxG.width, "Level 2");
			winnerText.setFormat(null, 16, 0x11111111, "center");
			add(winnerText);
		}
		
	}

}