//
//  ViewController.m
//  YLCircleView
//
//  Created by 于学良 on 2017/11/27.
//  Copyright © 2017年 yxlGitHub. All rights reserved.
//

#import "ViewController.h"
#import "TickCircleView.h"
@interface ViewController (){
    TickCircleView *_tickView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    _tickView = [TickCircleView tickViewWithProColor:[UIColor whiteColor] trackColor:[UIColor whiteColor]];
    _tickView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 370/440.0* self.view.bounds.size.width);
    _tickView.progress = 0.8;
    [self.view addSubview:_tickView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
