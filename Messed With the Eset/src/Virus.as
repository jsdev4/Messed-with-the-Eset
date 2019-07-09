package 
{import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.Tween;
	import net.flashpunk.utils.Ease;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Juan
	 */
	public class Virus  extends Entity
	{
		[Embed(source = "virus_z.png")]
		private const VIRUS:Class;
		private var virus:Image;
		[Embed(source = "virus_zombie.png")]
		private const VIRUS_ANIM:Class;
		private var virus_anim:Spritemap;
		private var room_:int;
		public function Virus(px:Number = 0, py:Number = 0,room:int=0) 
		{
			virus_anim = new Spritemap(VIRUS_ANIM, 80, 132);
			virus_anim.add("walking", [0, 1, 2, 3, 4], 10, true);
			room_ = room;
			super(px, py, virus_anim);
			mask = new Pixelmask(VIRUS);
			type = "Virus";
			virus_anim.flipped = true;
		}
		override public function update():void
		{
			virus_anim.play("walking");
			var gWorldV:GameWorld = FP.world as GameWorld;
			if (gWorldV.level_() == 1&&room_==0)
			{
				
				if (virus_anim.flipped == true)
				{
					x -= 100 * FP.elapsed;
					if (this.x <= FP.screen.x + 2100)
					{
						virus_anim.flipped = false;
					}
				}
				if (virus_anim.flipped == false)
				{
					x += 100 * FP.elapsed;
					if (this.x >= FP.screen.x + 2900)
					{
						virus_anim.flipped = true;
					}
				}
				
			}
			if (gWorldV.level_() == 1&&room_==1)
			{
				
				if (virus_anim.flipped == true)
				{
					x -= 100 * FP.elapsed;
					if (this.x <= FP.screen.x + 3000)
					{
						virus_anim.flipped = false;
					}
				}
				if (virus_anim.flipped == false)
				{
					x += 100 * FP.elapsed;
					if (this.x >= FP.screen.x + 3700)
					{
						virus_anim.flipped = true;
					}
				}
				
			}
			if (gWorldV.level_() == 1&&room_==2)
			{
				
				if (virus_anim.flipped == true)
				{
					x -= 100 * FP.elapsed;
					if (this.x <= FP.screen.x + 3700)
					{
						virus_anim.flipped = false;
					}
				}
				if (virus_anim.flipped == false)
				{
					x += 100 * FP.elapsed;
					if (this.x >= FP.screen.x + 4700)
					{
						virus_anim.flipped = true;
					}
				}
				
			}
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.hit_by_zombie();		
			}
			super.update();
		}
	}
}