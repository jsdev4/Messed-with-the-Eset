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
	public class MedicalKit extends Entity
	{
		[Embed(source = "medical_kit.png")]
		private const MED:Class;
		private var med:Image;
		[Embed(source = "medical_kit_spritesheet.png")]
		private const MED_AMIN:Class;
		private var med_anim:Spritemap;
		[Embed(source = "MineArm.mp3")]
		private const COLLECT:Class;
		private var collect:Sfx;
		private var playerGraphiclist:Graphiclist;
		private var explosionEmitter:Emitter;
		private var emitting:Boolean;
		public function MedicalKit(px:Number = 0,py:Number=0) 
		{
			explosionEmitter = new Emitter(new BitmapData(12,12),12,12);
			explosionEmitter.newType("explode",[0]);
			explosionEmitter.setAlpha("explode",0.9,0);
			explosionEmitter.setMotion("explode", 0, 80, 1, 180, -50, -0.5, Ease.backOut);
			explosionEmitter.relative = true;		
			emitting = false;
			collect = new Sfx(COLLECT);
			med_anim = new Spritemap(MED_AMIN, 50, 50);
			med_anim.add("stanced", [01, 2, 3, 4, 5], 10, true);
			playerGraphiclist = new Graphiclist(med_anim, explosionEmitter);
			super(px, py, playerGraphiclist);
			mask = new Pixelmask(MED);
			type = "MedicalKit";
		}
		override public function update():void
		{
			var gWorldV:GameWorld = FP.world as GameWorld;
			if (gWorldV.level_() == 1)
			{
				med_anim.play("stanced");
			
				var collidable:Entity = this.collide("Player", this.x, this.y);
				if (collidable)
				{
					if (Input.check(Key.SPACE))
					{
					explosionEmitter.setColor("explode", 0xc6cdd8, 0x7e3b4e);
					for (var i:uint = 0; i < 50; i++)
					explosionEmitter.emit("explode", med_anim.x +med_anim.width / 2, med_anim.y + med_anim.height / 2);
					emitting = true;
					var tempPlayer:Player = collidable as Player;
					
					tempPlayer.get_life();
					collect.play();
					}
				}
					if (emitting == true && explosionEmitter.particleCount == 0)
				{
					FP.world.recycle(this);
				}
			}
			super.update();
		}
	}
}