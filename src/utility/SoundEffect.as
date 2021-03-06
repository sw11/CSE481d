package utility 
{
	/**
	 * ...
	 * @author Sam
	 */
	public class SoundEffect 
	{
		[Embed(source = '../../sound/tank_fire.mp3')] public static var tankShoot:Class;
		[Embed(source = '../../sound/wind.mp3')] public static var wind:Class;
		[Embed(source = '../../sound/miss.mp3')] public static var miss:Class;
		[Embed(source = '../../sound/score.mp3')] public static var score:Class;
		[Embed(source = '../../sound/bomb.mp3')] public static var bomb:Class;
		[Embed(source = '../../sound/reload.mp3')] public static var reload:Class;
		[Embed(source = '../../sound/drop.mp3')] public static var drop:Class;
	}

}