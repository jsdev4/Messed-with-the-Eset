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

	public class Notepad extends Entity
	{
		[Embed(source = "notepad.png")]
		private const NOTE:Class;
		private var note:Image;
		[Embed(source = "notepad_spritesheet.png")]
		private const NOTE_ANIM:Class;
		private var note_anim:Spritemap; 
		[Embed(source = "MineArm.mp3")]
		private const COLLECT:Class;
		private var collect:Sfx;
		private var playerGraphiclist:Graphiclist;
		private var explosionEmitter:Emitter;
		private var emitting:Boolean;
		public function Notepad(px:Number=0,py:Number=0) 
		{
			collect = new Sfx(COLLECT);
			explosionEmitter = new Emitter(new BitmapData(12,12),12,12);
			explosionEmitter.newType("explode",[0]);
			explosionEmitter.setAlpha("explode",0.9,0);
			explosionEmitter.setMotion("explode", 0, 80, 1, 180, -50, -0.5, Ease.backOut);
			explosionEmitter.relative = true;				
			emitting = false;
			note_anim = new Spritemap(NOTE_ANIM, 50, 50);
			note_anim.add("stanced", [0, 1, 2, 3, 4, 5], 10, true);
			playerGraphiclist = new Graphiclist(note_anim, explosionEmitter);
			super(px, py, playerGraphiclist);
			mask = new Pixelmask(NOTE);
			type = "Notepad";
		}
		override public function update():void
		{
			note_anim.play("stanced");
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				if (Input.check(Key.SPACE))
				{	
					explosionEmitter.setColor("explode", 0x8eaeca, 0xba5b61);
					for (var i:uint = 0; i < 50; i++)
					explosionEmitter.emit("explode",note_anim.x +note_anim.width / 2, note_anim.y + note_anim.height / 2);
					emitting = true;
					tempPlayer.get_serial_notepad();
					collect.play();
				}
			}
			if (emitting == true && explosionEmitter.particleCount == 0)
				{
					FP.world.recycle(this);
				}
			super.update();
		}
		public function get_emitting():Boolean
		{
			return emitting;
		}
	}
}