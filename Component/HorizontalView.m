//
//  HorizontalView.m
//  FrameWork
//
//  Created by liyuchang on 15-1-22.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import "HorizontalView.h"

@interface HorizontalView ()
@property (nonatomic,retain)NSString * tidentity;
@end

@implementation HorizontalView
@synthesize identity = _identity;
- (instancetype)initWithIdentity:(NSString *)idetity
{
    self = [super init];
    if (self) {
        self.identity = idetity;
    }
    return self;
}

-(void)setIdentity:(NSString *)identity
{
    self.tidentity = identity;
}

-(NSString *)getIdentity
{
    return self.tidentity;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}

-(void)reachIndex:(NSInteger)indt
{
    _index = indt;
}
@end
