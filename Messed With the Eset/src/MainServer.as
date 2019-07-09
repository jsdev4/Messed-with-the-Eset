package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Juan
	 */
	public class MainServer extends Entity
	{
		[Embed(source = "main_server_.png")]
		private const SV:Class;
		private var sv:Image;
		[Embed(source = "main_server_sprites.png")]
		private const SV_ANIM:Class;
		private var sv_anim:Spritemap;
		private var status:int;
		[Embed(source = "Control Room Sounds-23202-Free-Loops.com.mp3")]
		private const SV_SOUND:Class;
		public var sv_sound:Sfx;
			[Embed(source = "TeamDrop.mp3")]
		private const SERIAL:Class;
		public var serial:Sfx;
		public function MainServer(px:Number=0,py:Number=0) 
		{
			sv_sound = new Sfx(SV_SOUND);
			serial = new Sfx(SERIAL);
			status = 0;
			sv_sound.volume = 1;
			sv_anim = new Spritemap(SV_ANIM, 228, 241);
			sv_anim.add("on_fail", [0, 1], 15, true);
			sv_anim.add("working", [2, 3], 15, true);
			super(px, py, sv_anim);
			mask = new Pixelmask(SV);
			type = "MainServer";
		}
		override public function update():void
		{
			
			
			var gWorldS:GameWorld = FP.world as GameWorld;
			if (gWorldS.level_() == 1)
			{
				
				if (status == 0)
				{
				sv_anim.play("on_fail");
				
				}
				if (status == 1)
				{
					
					sv_anim.play("working");
				}
				
				
			}
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				if (Input.check(Key.SPACE))
				{
					status = 1;	
					
				}	
			}	
			super.update();
		}
		public function get_server_status():int
		{
			return status;
		}
		public function modify_server_status():void
		{
			status = 1;
		}	
	}
}