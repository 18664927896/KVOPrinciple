//
//  NSObject+Observer.m
//  SheJiMoShiDemo
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NSObject+Observer.h"
#import <objc/message.h>
@implementation NSObject (Observer)

- (void)sg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    //注册类
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"SGKVO%@",oldName];
    Class customClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
    objc_registerClassPair(customClass);
    //修改self
    object_setClass(self, customClass);
    //复写setxxx
    NSString *methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString];
    SEL sel = NSSelectorFromString(methodName);
    class_addMethod(customClass, sel, (IMP)setName, "v@:@");
    
    /*
    v：表示void，i：返回值类型int
    @：参数id(self)
    :：SEL(_cmd)
    @：id(newVlue)
     */

    //添加类方法
//    Class metaClass = objc_getMetaClass(newName.UTF8String);
//    class_addMethod(metaClass, sel, (IMP)setName, "v@:@");
    
    //关联观察者
    objc_setAssociatedObject(self, (__bridge const void*)@"obj", observer, OBJC_ASSOCIATION_ASSIGN);
}

//实现set方法
void setName(id self, SEL _cmd,NSString *newVlue ){
    NSLog(@"新值:%@",newVlue);
    //改变父类的属性
    struct objc_super superClass = {self,class_getSuperclass([self class])};
    objc_msgSendSuper(&superClass, _cmd, newVlue);
    //通知观察者 ，你的值发生改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSLog(@"%@",methodName);
    id observer = objc_getAssociatedObject(self, (__bridge const void*)@"obj");
    NSString *key = @"name";
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject: change:context:),key,self,@{key:newVlue});
}

//移除观察者
- (void)sg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
//    id observer = objc_getAssociatedObject(self, (__bridge const void*)@"obj");
    objc_removeAssociatedObjects(observer);
}
@end
