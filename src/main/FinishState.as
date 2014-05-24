package main 
{
	import org.flixel.*;
	import utility.*;
	import beginner.*;
	import intermediate.*;
	import advance.*;
	import levels.Helper;
	/**
	 * ...
	 * @author Adrian
	 */
	public class FinishState extends FlxState
	{
		[Embed(source = '../../img/star.png')] private var star:Class;
		//public var nextStage : Number;
		private var result:String;
		private var _health:int;
		private var level:int;
		//private var yPos:int;
		
		
		public function FinishState(result:String, health:int, level:int): void {
			super();
			this.result = result;
			
			this._health = health;
			this.level = level;
			//yPos = 100;
		}
		
		override public function create(): void {
			/*var winnerText:FlxText;
			winnerText = new FlxText(0, yPos += 40, FlxG.width, result);
			winnerText.setFormat(null, 16, StaticVars.BLACK, "center");
			add(winnerText);*/
			addText(result, 100, 35);
			//trace(_health + " in finish state");
			if (_health > 0) {
				add(Helper.addInstr("Health left: " + _health, -30, 200, StaticVars.BLACK, 20));
				
				
				//addText("Health left: " + _health, 200, 20);
			} 
			if (_health == 5) {
				// add star
				//trace("add star");
				//State.star(level);
				var starIcon:FlxSprite = new FlxSprite(StaticVars.WIDTH/2 + 50, 200);
				starIcon.loadGraphic(star, true, true, 24, 24);
				add(starIcon);
			}
			
			
			//addText("Miss: " + miss);
			
			//addText("Time bonus: " + bonus);
			
			//var total:int = score + bonus;
			//addText("Total score: " + total);
			//trace(perfect);
			
			/*if (total >= perfect) {
				var starIcon:FlxSprite = new FlxSprite(420, yPos - 4);
				starIcon.loadGraphic(star, true, true, 24, 24);
				add(starIcon);
				updateStar();
			}*/
			// todo
			// add score summary points
			if (State.unlockLevel == 12) {
				
			} else {
				addText("Press ENTER to next level", 400, 15);
			}
			addText("Press ESC back to main menu", 450, 15);
			
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
				// todo to next level
				LevelSelect.startLevel(level + 1);
				//FlxG.switchState(new LevelSelect());
			} else if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new LevelSelect());
			} 
		}
		
		private function updateStar():void {
			var theme:int = 1;
			switch(theme) {
				case 1:
					State.theme1[level - 1][1] = true;
					break;
				case 2:
					State.theme2[level - 1][1] = true;
					break;
				case 3:
					State.theme3[level - 1][1] = true;
					break;
				case 4:
					State.theme4[level - 1][1] = true;
					break;
			}
		}
	}

}