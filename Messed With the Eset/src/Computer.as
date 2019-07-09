package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
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
	public class Computer extends Entity
	{
		
		[Embed(source = "computer_final_img.png")]
		private const COMP_IMG:Class;
		private var comp_img:Image;
		[Embed(source = "computer_final.png")]
		private const COMP:Class;
		private var comp:Spritemap;
		private var time_to_delete:Number;
		private var playerGraphiclist:Graphiclist;
		private var explosionEmitter:Emitter;
		private var emitting:Boolean;
		
		public function Computer(px:Number=0,py:Number=0) 
		{
			explosionEmitter = new Emitter(new BitmapData(12,12),12,12);
			explosionEmitter.newType("explode",[0]);
			explosionEmitter.setAlpha("explode",0.9,0);
			explosionEmitter.setMotion("explode", 0, 100, 2, 360, -80, -0.5, Ease.backOut);
			explosionEmitter.relative = true;		
			emitting = false;
			comp = new Spritemap(COMP, 111, 94);
			comp.add("stanced", [0, 1, 2, 3], 10, true);
			playerGraphiclist = new Graphiclist(comp, explosionEmitter);
			super(px, py, playerGraphiclist);
			comp_img = new Image(COMP_IMG);
			mask = new Pixelmask(COMP_IMG);
		}
		override public function update():void
		{
			comp.play("stanced");
			var collidable:Entity = this.collide("Player", this.x, this.y);
			
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				if(Input.check(Key.SPACE))
				{	
					if (Input.check(Key.SPACE))
					{
					explosionEmitter.setColor("explode", 0xd8c7cc, 0x0c51e0);
					for (var i:uint = 0; i < 50; i++)
					explosionEmitter.emit("explode",comp.x +comp.width / 2, comp.y +comp.height / 2);
					emitting = true;
					
					
					tempPlayer.die();
					
					}	
					if (emitting == true && explosionEmitter.particleCount == 0)
				{
					FP.world.recycle(this);
				}
				}
			}
			super.update();
		}
	}
}