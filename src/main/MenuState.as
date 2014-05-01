package main 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class MenuState extends FlxState
	{
		
		override public function create():void {
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Welcome to PONG");
			title.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press ENTER to Play");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			var controls:FlxText;
			controls = new FlxText(0, FlxG.height - 90, FlxG.width, "Player 1 controls: W, S");
			controls.setFormat( null, 8, 0xFFFFFFFF, "center");
			add(controls);
			
			var controls2:FlxText;
			controls2 = new FlxText(0, FlxG.height - 70, FlxG.width, "Player 2 controls: UP, DOWN");
			controls2.setFormat( null, 8, 0xFFFFFFFF, "center");
			add(controls2);
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new PlayState());
			}
		}
		
	}

}