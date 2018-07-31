# KVOPrinciple
iOS-KVO原理解析：
第一步：通过run time注册一个新类，父类为当前类
第二步：把当前对象修改为新 注册的类；
第三步：重写要观察属性的set方法；
第四步：关联观察者；



#添加观察者
[self.model sg_addObserver:self forKeyPath:@"username" options:NSKeyValueObservingOptionNew context:nil];

#移除观察者
[self.model sg_removeObserver:self forKeyPath:@"username"];

#观察者回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSLog(@"监听：%@",change);
}
