package
{
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	public class GameWorld extends World
	{
		[Embed(source = "10. Gumbo Gringo.mp3")]
		private const MUSIC:Class;
		private var music:Sfx;
		
		[Embed(source = "buy2.mp3")]
		private const SELECT:Class;
		private var select:Sfx;
		protected var player:Player;
		protected var titleText:Text;
		protected var pressText:Text;
		protected var messageOnStart:Text;
		protected var messageClock:Text;
		protected var messageSerial:Text;
		protected var messageComputer:Text;
		protected var messageFinal:Text;
		protected var messageServer:Text;
		private var titleTweenIn:VarTween;
		private var titleTweenOut:VarTween;
		private var pressTweenIn:VarTween;
		private var pressTweenOut:VarTween;
		
		private var messageSIn:VarTween;
		private var messageSOut:VarTween;
		private var messageClocktweenIn:VarTween;
		private var messageClocktweenOut:VarTween;
		private var messageSertweenIn:VarTween;
		private var messageSertweenOut:VarTween;
		private var messageComptweenIn:VarTween;
		private var messageComptweenOut:VarTween;
		private var messageSVtweenIn:VarTween;
		private var messageSVtweenOut:VarTween;
		private var messageFtweenIn:VarTween;
		private var messageFtweenOut:VarTween;
		protected var status:String;
		private var back_:Background;
		private var back_01:Background01;
		private var ground:Ground;
		private var ground_01:Ground;
		private var left_wall:LeftWall;
		private var right_wall:RightWall;
		private var front_end:FrontEnd;
		private var computer:Computer;
		private var game_started:Boolean;
		private var life:Text;
		private var virus_:Virus;
		private var virus_01:Virus;
		private var virus_02:Virus;
		private var virus_03:Virus;
		private var virus_04:Virus;
		private var virus_05:Virus;
		private var med_kit:MedicalKit;
		private var serial_keys:Notepad;
		private var server:MainServer;
		private var level:int;
		private var game_finished:Boolean;
		public function GameWorld()
		{
			game_started = false;
			level = 0;
			music = new Sfx(MUSIC);
			select = new Sfx(SELECT);
			
			game_finished= false;
			this.titleText = new Text("Messed with the Eset");
			this.pressText = new Text("Press SPACE BAR to start\nPress SPACE to collect items");
			this.messageOnStart = new Text("what a strange day, from here looks like my computer has some issues\nshould i go to check what's happen it"); 
			this.messageClock = new Text("Hmm, this clock behaviour is strange");
			this.messageSerial = new Text("This serials may help that toasted pc. Press Space to collect");
			this.messageComputer = new Text ("it's plenty of virus, should I try to eliminate them\n but i'm scared to touch the pc");
			this.messageFinal = new Text("Finally I fix this mess!.Press SPACE");
			this.messageServer = new Text("I have to put this serials to make work this database, press SPACE");
			this.messageClock.scale = 0.8;
			this.messageClock.alpha = 0;
			this.titleText.color = 0xFFFFFF;
			this.titleText.scale = 2;
			this.pressText.color = 0xFFFFFF;
			this.pressText.alpha = 0;
			this.messageOnStart.scale = 0.6;
			this.messageOnStart.alpha = 0;
			this.messageSerial.scale = 0.7;
			this.messageSerial.alpha = 0;
			this.messageComputer.scale = 0.6;
			this.messageComputer.alpha = 0;
			this.messageFinal.scale = 0.7;
			this.messageFinal.alpha = 0;
			this.messageServer.scale = 0.7;
			this.messageServer.alpha = 0;
			this.titleText.x = (FP.screen.width - this.titleText.scaledWidth) / 2;
			this.pressText.x = (FP.screen.width - this.pressText.width) / 2;	
			this.titleText.y = -100;
			this.pressText.y = FP.screen.height * 0.75;
			this.messageOnStart.x = FP.screen.x + 144;
			this.messageOnStart.y = FP.screen.y + 180;
			this.messageClock.x = FP.screen.x + 650;
			this.messageClock.y = FP.screen.y + 180;
			this.messageSerial.x = FP.screen.x + 1220;
			this.messageSerial.y = FP.screen.y + 180;
			this.messageComputer.x = FP.screen.x + 2430;
			this.messageComputer.y = FP.screen.y + 160;
			this.messageServer.x = FP.screen.x + 4300;
			this.messageServer.y=FP.screen.y + 200;
			back_ = new Background(0, 0);
			ground = new Ground(0, FP.height - 27);
			left_wall = new LeftWall(0, 0);
			right_wall = new RightWall(2880, 0);
			front_end = new FrontEnd(0, 0);
			computer = new Computer(2577, 296);
			
			back_01 = new Background01(1920, 0);
			//
			titleTweenIn = new VarTween();
			titleTweenOut = new VarTween();
			pressTweenIn = new VarTween();
			pressTweenOut = new VarTween();
			messageSIn = new VarTween();
			messageSOut = new VarTween();
			messageClocktweenIn = new VarTween();
			messageClocktweenOut = new VarTween();
			messageSertweenIn = new VarTween();
			messageSertweenOut = new VarTween();
			messageComptweenIn = new VarTween();
			messageComptweenOut = new VarTween();
			messageSVtweenIn = new VarTween();
			messageSVtweenOut = new VarTween();
			messageFtweenIn = new VarTween();
			messageFtweenOut = new VarTween();
			this.status = "START";
			this.add(back_);
			this.back_01.visible = false;
			this.add(back_01);
			this.add(left_wall);
			this.add(right_wall);
			virus_ = new Virus(FP.screen.x + 2800, FP.screen.height - 159, 0);
			virus_01 = new Virus(FP.screen.x + 3200, FP.screen.height - 159, 1);
			virus_02 = new Virus(FP.screen.x + 3500, FP.screen.height - 159, 1);
			virus_03 = new Virus(FP.screen.x + 3650, FP.screen.height - 159, 1);
			virus_04 = new Virus(FP.screen.x + 4350, FP.screen.height - 159, 2);
			virus_05 = new Virus(FP.screen.x + 4600, FP.screen.height - 159,2);
			med_kit = new MedicalKit( FP.screen.x + 2200, FP.screen.height - 77);
			serial_keys = new Notepad(FP.screen.x + 1375, FP.screen.y + 280);
			server = new MainServer(FP.screen.x + 4400, FP.screen.height - 268);
			player = new Player(FP.screen.width/2, FP.screen.height / 2);
			this.add(virus_);
			this.virus_.visible = false;
			this.add(virus_01);
			this.virus_01.visible = false;
			this.add(virus_02);
			this.virus_02.visible = false;
			this.add(virus_03);
			this.virus_03.visible = false;
			this.add(virus_04);
			this.virus_04.visible = false;
			this.add(virus_05);
			this.virus_05.visible = false;
			this.add(med_kit);
			this.med_kit.visible = false;
			this.add(ground);
			this.add(computer);
			this.add(serial_keys);
			this.add(player);
			this.player.visible = false;
			this.add(server);
			this.add(front_end);
			this.addGraphic(titleText);
			this.addGraphic(pressText);
			this.addTween(titleTweenIn);
			this.addTween(pressTweenIn);
			this.addTween(titleTweenOut);
			this.addTween(pressTweenOut);
			this.life = new Text(player.get_life_status().toString());
			this.life.scale = 0.8;
			this.addGraphic(life);
			this.life.visible = false;
			this.addGraphic(messageOnStart);
			this.addGraphic(messageClock);
			
			this.addGraphic(messageSerial);
			this.addGraphic(messageComputer);
			this.addGraphic(messageFinal);
			this.addGraphic(messageServer);
			this.addTween(messageSIn);
			this.addTween(messageSOut);
			this.addTween(messageClocktweenIn);
			this.addTween(messageClocktweenOut);
			this.addTween(messageSertweenIn);
			this.addTween(messageSertweenOut);
			this.addTween(messageComptweenIn);
			this.addTween(messageComptweenOut);
			this.addTween(messageSVtweenIn);
			this.addTween(messageSVtweenOut);
			this.addTween(messageFtweenIn);
			this.addTween(messageFtweenOut);
		}
		override public function update():void
		{	
			switch (status)
			{
				case "START": 
				{
					titleTweenIn.tween(titleText, "y", FP.screen.height * 0.25, 3, Ease.backOut);
					pressTweenIn.tween(pressText, "alpha", 1, 3);
					
					this.status = "WAIT1";
					break;
				}
				case "TO": 
				{
					if (Input.check(Key.SPACE))
					{
						titleTweenOut.tween(titleText, "y", -100, 3, Ease.backIn);
						pressTweenOut.tween(pressText, "alpha", 0, 3);
						select.play(1, 0);
						this.status = "WAIT2";
						music.play();
					}
					break;
				}
				case "GAME": 
				{
					this.player.visible = true;
					game_started = true;
					this.life.visible = true;
					this.life.x = FP.world.camera.x+20;
					this.life.y = FP.world.camera.y+10;
					this.life.text = player.get_life_status().toString();
					FP.world.camera.x = player.x - FP.halfWidth;
					FP.world.camera.y = player.y - FP.halfHeight;
						if (this.player.x>325&&this.player.x<330)
						{
							messageSIn.tween(messageOnStart, "alpha", 1, 2);
						}
						if (this.player.x>330||this.player.x<325)
						{
							messageSOut.tween(messageOnStart, "alpha", 0, 1);
						}
						//--------------
						if(this.player.x>750&&this.player.x<755)
						{
						messageClocktweenIn.tween(messageClock, "alpha", 1, 2);
						}
						if(this.player.x>755||this.player.x<750)
						{
						messageClocktweenOut.tween(messageClock, "alpha", 0, 1);
						}
						//----------------------
						if (this.player.x>1300 && this.player.x < 1355)
						{
							messageSertweenIn.tween(messageSerial, "alpha", 1, 2);
						}
						if( this.player.x > 1355||this.player.x<1300)
						{
						messageSertweenOut.tween(messageSerial, "alpha", 0, 1);
						}
						//-----------------
						if (this.player.x > 2380&&this.player.x<2700)
						{
							messageComptweenIn.tween(messageComputer, "alpha", 1, 3);
						}
						if (this.player.x < 2380||this.player.x>2700)
						{
							messageComptweenOut.tween(messageComputer, "alpha", 0, 1);
						}
						//-----------------
						if (this.player.x > 4300 && this.player.x < 4600)
						{
							messageSVtweenIn.tween(messageServer, "alpha", 1, 3);
						}
						if (this.player.x< 4300 && this.player.x > 4600)
						{
							messageSVtweenOut.tween(messageServer, "alpha", 0, 3);
						}//----------------
						if (level == 0)
						{
							server.sv_sound.loop(0.7, 0);
						}
					if (level == 1)
					{
						
						this.messageComputer.visible = false;
						this.computer.visible = false;
						FP.world.remove(back_);
						this.med_kit.visible = true;
						this.back_01.visible = true;
						this.left_wall.x = 1920;
						this.right_wall.x = 4800;
						this.ground.x = 1920;
						this.front_end.x = 1920;
						this.virus_.visible = true;
						this.virus_01.visible = true;
						this.virus_02.visible = true;
						this.virus_03.visible = true;   
					}
					if (server.get_server_status() == 0)
					{
						server.serial.play(1, 0);
					}
					if (server.get_server_status() == 1)
					{
						FP.world.remove(virus_);
						FP.world.remove(virus_01);
						FP.world.remove(virus_02);
						FP.world.remove(virus_03);
						FP.world.remove(virus_04);
						FP.world.remove(virus_05);
						server.sv_sound.stop();
						game_finished = true;
						this.messageServer.visible = false;
						this.life.visible = false;
						if (game_finished == true)
						{
							messageFtweenIn.tween(messageFinal, "alpha", 1, 7); 
							this.status = "WIN";
						}
					}
					break;
				}
				case "SHOWMESSAGE":
					{
						this.messageFinal.x = this.player.x;
						this.messageFinal.y = this.player.y - 30;
						
						if (Input.check(Key.SPACE))
						{
							server.serial.stop();
							music.stop();
							FP.world = new GameWorld();
						}
						break;
					}
			}
			if (titleTweenIn.percent == 1 && pressTweenIn.percent == 1 && this.status == "WAIT1")
			{
				this.status = "TO";
			}
			if (titleTweenOut.percent == 1 && pressTweenOut.percent == 1 && this.status == "WAIT2")
			{
				this.player.visible = true;
				this.player.collidable = true;
				this.status = "GAME";
			}
			if (messageFtweenIn.percent == 0&& this.status == "WIN")
			{
				this.status = "SHOWMESSAGE";
			}
			super.update();
		}
		public function gameReboot():void
		{
		this.player.visible = false;
			this.player.collidable = false;
			//this.player.player_sprite.play("fly");
			
			this.status = "START";
		}
		public function get_game_started():Boolean
		{
			return game_started;
		}
		public function get_level():void
		{
			level=1;
		}
		public function level_():int
		{
			return level;
		}
	}
}