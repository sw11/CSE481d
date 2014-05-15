package main 
{
	import org.flixel.*;
	import utility.*;
	import a_basic_theme.*;
	import b_recycle_theme.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class EndState extends FlxState
	{
		[Embed(source = '../../img/star.png')] private var star:Class;
		//public var nextStage : Number;
		private var result:String;
		private var score:int;
		private var miss:int;
		private var bonus:int;
		private var perfect:Number;
		private var theme:int;
		private var level:int;
		private var yPos:int;
		
		
		public function EndState(result:String, score:int, miss:int, bonus:int, perfect:Number, theme:int, level:int): void {
			super();
			this.result = result;
			this.score = score;
			this.miss = miss;
			this.bonus = bonus
			this.perfect = perfect;
			this.theme = theme;
			this.level = level;
			yPos = 100;
		}
		
		override public function create(): void {
			/*var winnerText:FlxText;
			winnerText = new FlxText(0, yPos += 40, FlxG.width, result);
			winnerText.setFormat(null, 16, StaticVars.BLACK, "center");
			add(winnerText);*/
			addText(result);
			
			addText("Score: " + score);
			
			addText("Miss: " + miss);
			
			addText("Time bonus: " + bonus);
			
			var total:int = score + bonus;
			addText("Total score: " + total);
			//trace(perfect);
			if (total >= perfect) {
				var starIcon:FlxSprite = new FlxSprite(420, yPos - 4);
				starIcon.loadGraphic(star, true, true, 24, 24);
				add(starIcon);
				updateStar();
			}
			// todo
			// add score summary points
			addText("Press ENTER to continue");
			
		}
		
		private function addText(str:String):void {
			var text:FlxText;
			text = new FlxText(0, yPos += 40, FlxG.width, str);
			text.setFormat(null, 16, StaticVars.BLACK, "center");
			add(text);
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new LevelState(theme));
			}
		}
		
		private function updateStar():void {
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