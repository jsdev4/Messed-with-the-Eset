package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;

	public class LeftWall extends Entity
	{
		[Embed(source="LeftWall.png")]
		private const LEFT_IMG:Class;
		private var lwall:Image;		
	
		public function LeftWall(px:Number = 0, py:Number = 0)
		{
			lwall = new Image(LEFT_IMG);
			mask = new Pixelmask(LEFT_IMG);
			type = "LeftWall";
			super(px, py,lwall);
		}
		
		override public function update():void
		{			
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.x = this.x + this.width;
				FP.world.camera.x += 300 * FP.elapsed;
			}
		}
	}
}