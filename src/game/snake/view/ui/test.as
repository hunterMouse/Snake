package game.snake.view.ui
{
	public class test
	{
		public function test()
		{
		}
		
		//ai移动
//		private function snakeAIMove(): void 
//		{
//			for (var index:int = 1; index < this.snakeArr.length; index++)
//			{
//				var snakeAI:Snake = this.snakeArr[index];
//				snakeAI.update();
//				var hitDis: Number = 90 / snakeAI.speedObj["rotation"] * snakeAI.speed + snakeAI.shetou.radius / 2;
//				var hitPos: Object = { x: 0, y: 0 };
//				hitPos["x"] = hitDis * Math.cos(snakeAI.shetou.rotation * Math.PI / 180) + snakeAI.shetou.x;
//				hitPos["y"] = hitDis * Math.sin(snakeAI.shetou.rotation * Math.PI / 180) + snakeAI.shetou.y;
//				var hiten: Boolean = false
//				//边界碰撞判断 判断蛇头是否快碰撞到
//				if (hitPos["x"] >= this.map.width - snakeAI.shetou.radius / 2
//					|| hitPos["x"] <= snakeAI.shetou.radius / 2
//					|| hitPos["y"] >= this.map.height - snakeAI.shetou.radius / 2
//					|| hitPos["y"] <= snakeAI.shetou.radius / 2)
//				{
//					snakeAI.reverseRotation();
//				}
//				
//				//判断是否撞倒玩家蛇
//				for (var i = 0; i < this.snakeSelf.bodyArr.length; i++)
//				{
//					var element:She = this.snakeSelf.bodyArr[i];
//					if (LuanMath.distance(hitPos["x"], hitPos["y"], element.x, element.y) <= element.radius)
//					{
//						snakeAI.reverseRotation();
//						hiten = true
//					}
//				}
//				
//				//判断AI之间是否自己碰撞
//				for (var i = 1; i < this.snakeArr.length; i++) 
//				{
//					if (hiten) break
//					var elementSnakeAI: Snake = this.snakeArr[i];
//					if (index == i) continue
//					for (var j = 0; j < elementSnakeAI.bodyArr.length; j++) 
//					{
//						var element:She = elementSnakeAI.bodyArr[j];
//						if (LuanMath.distance(hitPos["x"], hitPos["y"], element.x, element.y) <= element.width) 
//						{
//							snakeAI.reverseRotation()
//							hiten = true;
//						}
//					}
//				}
//			}
//		}
		
		
		
		
		//提前计算 蛇是否会相撞
		//					var arr:Array = LuanMath.getVbackSpeed(snake.rotation,snake.speed);
		//					var x:Number = arr[0];
		//					var y:Number = arr[1];
		//					var shetou1:Point = new Point(ballA.x+x,ballA.y+y);
		//					
		//					arr = LuanMath.getVbackSpeed(snakeKiller.rotation,snakeKiller.speed);
		//					x = arr[0];
		//					y = arr[1];
		//					var shetou2:Point = new Point(ballB.x+x,ballB.y+y);
		//					
		//					dist = LuanMath.distance(shetou1.x, shetou1.y, shetou2.x, shetou2.y);
		//					if (dist< radius)
		//					{
		//						//如果会相撞 
		//						if(snake==this.snakeSelf)
		//						{
		//							//是玩家 另一条蛇如果是头那么蛇转向
		//							if(snakeKiller.isAI && ballB.isHead)
		//							{
		//								snakeKiller.reverseRotation();
		//							}
		//						}
		//						else
		//						{
		//							if(snake.isAI)
		//							{
		//								//不是玩家 那么蛇提前转向 
		//								snake.reverseRotation();	
		//							}
		//						}
		//					}
		
	}
}