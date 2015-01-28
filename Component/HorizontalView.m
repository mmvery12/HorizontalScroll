//
//  HorizontalView.m
//  FrameWork
//
//  Created by liyuchang on 15-1-22.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import "HorizontalView.h"
#import "HorizontalScrollView.h"
@interface HorizontalView ()
@property (nonatomic,retain)NSString * tidentity;
@end

@implementation HorizontalView
@synthesize identity = _identity;
- (instancetype)initWithHorizontalScroll:(HorizontalScrollView *)horizontalScroll index:(NSInteger)index Identity:(NSString *)idetity
{
    self = [super init];
    if (self) {
        [self resize:horizontalScroll index:index];
        self.identity = idetity;
    }
    return self;
}

-(void)resize:(HorizontalScrollView *)horizontalScroll index:(NSInteger)index
{
    self.frame = [horizontalScroll viewRectAtIndex:index];
    _index = index;
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
@end
