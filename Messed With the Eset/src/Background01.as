package 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Juan
	 */
	public class Background01 extends Entity
	{
		[Embed(source = "background01.png")]
		private const BACK01:Class;
		private var back01:Image;
		public function Background01(px:Number=0,py:Number=0) 
		{
			back01 = new Image(BACK01);
			super(px, py, back01);
		}
		override public function update():void
		{
			super.update();
		}	
	}
}