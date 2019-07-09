package 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	public class FrontEnd extends Entity
	{
		[Embed(source = "FrontEnd.png")]
		private const FRONT:Class;
		private var frontend:Image;
		public function FrontEnd(px:Number = 0,py:Number=0 ) 
		{
			frontend = new Image(FRONT);
			super(px, py, frontend);
		}
		override public function update():void
		{
			super.update();
		}		
	}
}