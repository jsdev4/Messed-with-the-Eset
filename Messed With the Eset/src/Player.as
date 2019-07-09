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
	
	public class Player extends Entity
	{
		[Embed(source="player_sprite.png")]
		private const PLAYER_IMG:Class;
		[Embed(source = "player_sprites.png")]
		private const PLAYER_ANIM:Class;
		[Embed(source = "Fotstep_Carpet_Left_2.mp3")]
		private const LF:Class;
		private var lf:Sfx;
		
		public var player_sprite:Spritemap;
		private var gravity:Number;
		private var life:Number;
		private var awake:Boolean;
		private var serial:int;
		public function Player(px:Number = 0, py:Number = 0)
		{
			lf = new Sfx(LF);
			player_sprite= new Spritemap(PLAYER_ANIM,224, 234);
			gravity = 9.81;
			player_sprite.add("standby", [0, 1, 2, 3], 3, true);
			player_sprite.add("running", [4, 5, 6, 7, 8, 9, 10], 20, true);
			player_sprite.add("death", [12, 13, 14, 15], 30, false);
			awake = false;
			life = 100;
			serial = 0;
			super(px, py, player_sprite);
			awake = true;
			mask = new Pixelmask(PLAYER_IMG);
			type = "Player";
			player_sprite.play("standby");	
		}
		
		override public function update():void
		{
			y += gravity * FP.elapsed;
			var gWorld:GameWorld = FP.world as GameWorld;
			if (gWorld.get_game_started() == true&&awake==true)
			{
				FP.world.camera.y = player_sprite.y;
				if (Input.check(Key.RIGHT))
				{
					player_sprite.flipped = false;
					player_sprite.play("running");
					//lf.play(1, 0);
				
					if ((this.x + this.getWidth()) < FP.screen.width+4800)					
					{	x += 300 * FP.elapsed;
						FP.world.camera.x += 300 * FP.elapsed;
					}
					else
					{
						this.x = 4800 - this.getWidth();
					}
				}
				else if (Input.check(Key.LEFT))
				{	player_sprite.flipped = true;
					player_sprite.play("running");
					FP.world.camera.x -=300 * FP.elapsed;
					if (this.x > 0)			
					{
						x -= 300 * FP.elapsed;
					}
					else
					{
						this.x = 0;
					}
				}	
				if (Input.pressed(Key.RIGHT) || Input.pressed(Key.LEFT))
				{
						lf.loop(1, 0);
				}
				if (Input.released(Key.RIGHT)||Input.released(Key.LEFT))
				{
					player_sprite.play("standby");
					lf.stop();
				}
				if (player_sprite.currentAnim == "death" && player_sprite.complete)
				{
					gWorld.get_level();
					player_sprite.play("death");
				}
			}
			if (gWorld.get_game_started() == false)
			{
				if (Input.check(Key.RIGHT) || Input.check(Key.LEFT))
				{
					x += 0 * FP.elapsed;
				}
			}
			if (awake == false)
			{	player_sprite.play("death");
				if (Input.check(Key.RIGHT) || Input.check(Key.LEFT))
				{
					x += 0 * FP.elapsed;
				}
				if (player_sprite.currentAnim == "death" && player_sprite.complete)
				{
					FP.world = new GameWorld();
				}	
			}
			super.update();
		}
		
		public function getWidth():Number
		{
			return (player_sprite.width / player_sprite.columns);
		}
		
		public function getHeight():Number
		{
			return (player_sprite.height /player_sprite.rows);
		}
		public function getY():Number
		{
			return player_sprite.y;
		}
		public function die():void
		{
			player_sprite.play("death");
			lf.stop();
			life =0;
		}
		
		public function hit_by_zombie():void
		{
			life -= 1 * FP.elapsed;
			if (life <= 0)
			{
				awake = false;
			}	
		}
		public function get_life():void
		{
			life = 4;
		}
		public function get_life_status():int
		{
			return life;
		}
		public function get_serial_notepad():void
		{
			serial = 1;
		}
		public function get_serial_status():int
		{
			return serial;
		}
		
	
	}
}