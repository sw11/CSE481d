package main 
{
	import org.flixel.*;
	import utility.*;
	import levels.Helper;
	/**
	 * ...
	 * @author Adrian
	 */
	public class FinishState extends FlxState
	{
		[Embed(source = '../../img/star.png')] private var star:Class;
		private var result:String;
		private var _health:int;
		private var level:int;
		private var isWin:Boolean;
		
		
		public function FinishState(result:String, health:int, level:int): void {
			super();
			this.result = result;
			isWin = result == "WIN";
			this._health = health;
			this.level = level;
		}
		
		override public function create(): void {
			//FlxG.bgColor = StaticVars.WHITE;
			addText(result, 100, 35);
			//trace(_health + " in finish state");
			if (_health > 0) {
				add(Helper.addInstr("Health left: " + _health, -30, 200, StaticVars.BLACK, 20));
			} 
			if (_health == 5 || (level == 1 && _health == 3) || (_health > 0 && (level == 7 || level == 8) )) {
				// add star
				var starIcon:FlxSprite = new FlxSprite(StaticVars.WIDTH/2 + 50, 200);
				starIcon.loadGraphic(star, true, true, 24, 24);
				add(starIcon);
			}
			
			// todo
			// add score summary points
			if (level == 12 && isWin) {
				addText("Congratulation! You have passed all levels", 400, 15);
			} else {
				var str:String;
				if (isWin) {
					str = "Press ENTER for the next level";
					// save data
					LevelSelect.save.data.array = State.levelArr.slice();
					LevelSelect.save.flush();
				} else {
					str = "Press ENTER to restart level";
				}
				addText(str, 400, 15);
			}
			addText("Press ESC for the main menu", 450, 15);
			
		}
		
		private function addText(str:String, yPos:int, fontSize:int):void {
			var text:FlxText;
			text = new FlxText(0, yPos, FlxG.width, str);
			text.setFormat(null, fontSize, StaticVars.BLACK, "center");
			add(text);
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				if (isWin) {
					LevelSelect.startLevel(level + 1);
				} else {
					LevelSelect.startLevel(level);
				}
			} else if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new LevelSelect());
			} 
		}
		
	}

}