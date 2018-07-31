//
//  ViewController.m
//  KVOPrinciple
//
//  Created by admin on 2018/7/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
#import "NSObject+Observer.h"

@interface ViewController ()

@property (nonatomic, strong) TestModel *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.model = [[TestModel alloc] init];
    self.model.username = @"刚刚好";
    [self.model sg_addObserver:self forKeyPath:@"username" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.model.username = @"你好";
    NSLog(@"%@",self.model.username );
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSLog(@"改名成功：%@",change);
}




@end
