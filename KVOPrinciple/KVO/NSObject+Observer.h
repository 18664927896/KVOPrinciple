//
//  NSObject+Observer.h
//  SheJiMoShiDemo
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Observer)
//添加观察者
- (void)sg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

//移除观察者
- (void)sg_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
