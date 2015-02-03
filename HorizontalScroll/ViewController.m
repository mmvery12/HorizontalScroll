//
//  ViewController.m
//  HorizontalScroll
//
//  Created by liyuchang on 15-1-28.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HorizontalScrollView *hori = [[HorizontalScrollView alloc] initHorizontalScrollViewWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 100)];
    hori.layer.borderColor = [UIColor redColor].CGColor;
    hori.layer.borderWidth = 1.f;
    hori.horizontalViewAtIndex = ^HorizontalView * (HorizontalScrollView *scroll,NSInteger index){
        static NSString *identity = @"identity";
        HorizontalView *view = [scroll deqreuseViewAtIndex:index identity:identity];
        if (!view) {
            view = [[HorizontalView alloc] initWithHorizontalScroll:scroll index:index Identity:identity];
            view.layer.borderColor = [UIColor greenColor].CGColor;
            view.layer.borderWidth = 2.f;
        }
        return view;
    };
    
    hori.horzontalCount = ^NSInteger (HorizontalScrollView *scroll){
        return 10;
    };
    
    hori.horizontalWidthAtIndex = ^CGFloat (HorizontalScrollView *scroll,NSInteger index){
        return 100;
    };
    [self.view addSubview:hori];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
