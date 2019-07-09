package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Juan
	 */
	public class Ground extends Entity
	{
		[Embed(source = "ground.png")] private const GROUND:Class;
		private var ground:Image;
		public function Ground(px:Number = 0,py:Number=0) 
		{
			ground = new Image(GROUND);
			super(px, py, ground);
			mask = new Pixelmask(GROUND);
			type = "Ground";
		}
		override public function update():void
		{
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.y = this.y -tempPlayer.height;
			}
			super.update();
		}
	}
}