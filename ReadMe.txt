项目结构解析：


项目中使用的开源框架：
 MBProgressHUD：⌛️指示器
 
	 基本使用方法：
	    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	    hud.labelText = @"正在加载，请稍后...";
	    hud.dimBackground = YES;
 
 AFNetworking：网络库，支持同步和异步两种方式