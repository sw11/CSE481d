package utility 
{
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class StaticVars 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 640;
		
		// play button
		public static const PLAY_W:int = 200;
		public static const PLAY_H:int = 100; 
		public static const PLAY_BTN_X:int = 220;
		public static const PLAY_BTN_y:int = 100;
		
		// setting button 
		public static const SETTING_W:int =  200;
		public static const SETTING_H:int =  100; 
		public static const SETTING_BTN_X:int = 220;
		public static const SETTING_BTN_y:int = 300;
		
		public static const WHITE:int = 0xffffff;
		public static const BLACK:int = 0x11111111;
		public static const RED:int = 0xFFFF0000;
		public static const INVISIBLE:int = 0x00FFFFFF;
		
		public static const SETTING_BUTTON_X:int = 15;
		public static const SETTING_BUTTON_Y:int = 15;
		public static const SETTING_SIZE_X:int = 100;
		public static const SETTING_SIZE_Y:int = 100;
		
		public static const A_THEME:int = 1;
		public static const B_THEME:int = 2;
		public static const C_THEME:int = 3;
		public static const D_THEME:int = 4;
		
		// lane x position
		public static const lane1:int = 130;
		public static const lane2:int = 230;
		public static const lane3:int = 330;
		public static const lane4:int = 430;
		public static const lane5:int = 530;
		public static const lanes:Array = new Array(lane1, lane2, lane3, lane4, lane5);
		
		// a basic theme:
		public static const aTime:int = 30000;
		public static const aPass:Number = 0.6;
		// level 1
		public static const a1MaxScore:int = 30;
		public static const a1Interval:int = 30;
		// level 2
		public static const a2MaxScore:int = 35;
		public static const a2Interval:int = 25;
		public static const a2BombRate:int = 10;
		// level 3
		public static const a3MaxScore:int = 40;
		public static const a3Interval:int = 20;
		public static const a3BombRate:int = 5;
		
		// b recycle theme:
		public static const bTime:int = 60000;
		public static const bPass:Number = 0.5;
		public static const NUM_BUCKET:int = 3;
		// level 1
		public static const b1MaxScore:int = 45;
		public static const b1Interval:int = 35;
		// level 2
		public static const b2MaxScore:int = 50;
		public static const b2Interval:int = 30;
		// level 3
		public static const b3MaxScore:int = 60;
		public static const b3Interval:int = 20;
		
		
		// d bomb theme
		public static const dTime:int = 60000;
		public static const dPass:Number = 0.6;
		// level 10
		public static const d10MaxScore:int = 70;
		public static const d10Interval:int = 35;
		// level 11
		public static const d11MaxScore:int = 60;
		public static const d11Interval:int = 25;
		// level 12
		public static const d12MaxScore:int = 50;
		public static const d12Interval:int = 15;
		
		public static var logger:Logger = new Logger("trash_it", 108, "83dcd169ecb97a898ee94c90441696cd", 1, 1);
	}
	
	

}