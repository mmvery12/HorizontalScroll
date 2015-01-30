//
//  HorizontalScrollView.m
//  FrameWork
//
//  Created by liyuchang on 15-1-22.
//  Copyright (c) 2015年 com.Vacn. All rights reserved.
//

#import "HorizontalScrollView.h"
#import <objc/runtime.h>
@interface HorizontalScrollView ()
{
    Class objIsa;
}
@property (nonatomic,assign)NSInteger nowVisibleTopViewIndex;
@property (nonatomic,DEF_STRONG)NSMutableArray * visibleViewsArray;
@property (nonatomic,DEF_STRONG)NSMutableArray * reuseViewsArray;
@property (nonatomic,DEF_STRONG)NSMutableArray * viewsDescriptionArray;
@end

@implementation HorizontalScrollView

- (id)initHorizontalScrollViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.8];
        _visibleViewsArray = [NSMutableArray array];
        _reuseViewsArray = [NSMutableArray array];
        _viewsDescriptionArray = [NSMutableArray array];
        self.delegate = self;
        self.scrollEnabled = YES;
        self.bounces = YES;
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES; 
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    NSInteger count = [self arriveCount];
    NSInteger first = 0;
    CGFloat lastOriginx = 0;
    for (int i = 0; i<count; i++) {
        CGFloat width = self.horizontalWidthAtIndex(self,i);
        [_viewsDescriptionArray addObject:@{@"origin.x":[NSNumber numberWithFloat:lastOriginx],@"size.width":[NSNumber numberWithFloat:width]}];
        lastOriginx+=width;
        CGFloat fa = [self originx:i]+[self sizewidth:i];
        if ([self originx:i]<=self.frame.size.width && fa>self.frame.size.width) {
            first = i;
        }
    }
    if (count>0)
    {
        [self adjustContentSize:count-1];
        for (int i=0; i<first+1; i++) {
            [self reachViews:i :NO];
        }
    }
}

-(void)setHoridelegate:(id<HorizontalDelegate>)horidelegate
{
    objIsa = object_getClass(horidelegate);
    _horidelegate = horidelegate;
}

-(NSInteger)arriveCount
{
    return self.horzontalCount(self);
}

-(void)adjustContentSize:(NSInteger)i
{
    CGFloat x = [[[_viewsDescriptionArray objectAtIndex:i] objectForKey:@"origin.x"] floatValue];
    CGFloat width = [[[_viewsDescriptionArray objectAtIndex:i] objectForKey:@"size.width"] floatValue];
    CGSize size = self.contentSize;
    size.width = x+width;
    size.height = self.frame.size.height;
    self.contentSize = size;
    if (size.width<self.frame.size.width) {
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, self.frame.size.width-size.width);
    }
}

-(void)reachViews:(NSInteger)i :(BOOL)isTop
{
    if (i<0 || i>self.viewsDescriptionArray.count-1)  return;
    @synchronized(self)
    {
        HorizontalView *view = self.horizontalViewAtIndex(self,i);
        if (_horidelegate && objIsa == object_getClass(_horidelegate) && [_horidelegate respondsToSelector:@selector(horizontalViewWillDisplay:index:)])
            [_horidelegate horizontalViewWillDisplay:view index:i];
        [self addSubview:view];
        if (isTop) {
            [_visibleViewsArray insertObject:view atIndex:0];
        }else
            [_visibleViewsArray addObject:view];
    }
}

-(CGFloat)originx:(NSInteger)i
{
    return [[[self.viewsDescriptionArray objectAtIndex:i] objectForKey:@"origin.x"] floatValue];
}

-(CGFloat)sizewidth:(NSInteger)i
{
    return [[[self.viewsDescriptionArray objectAtIndex:i] objectForKey:@"size.width"] floatValue];
}

-(CGRect)viewRectAtIndex:(NSInteger)index
{
    CGFloat originx = [self originx:index];
    CGFloat width = [[[self.viewsDescriptionArray objectAtIndex:index] objectForKey:@"size.width"] floatValue];
    CGFloat height = self.frame.size.height;
    return CGRectMake(originx, 0, width, height);
}

-(HorizontalView *)deqreuseViewAtIndex:(NSInteger)index identity:(NSString *)identity
{
    @synchronized(self)
    {
        HorizontalView *temp;
        for (HorizontalView * view in self.reuseViewsArray) {
            if ([identity isEqualToString:(NSString *)view.identity]) {
                temp = view;
                [temp resize:self index:index];
                [_reuseViewsArray removeObject:view];
                break;
            }
        }
        return temp;
    }
}

-(void)removeViews:(NSInteger)i
{
    if (i<0) return;
    if (i>self.viewsDescriptionArray.count-1) return;
    @synchronized(self)
    {
        HorizontalView *view = (id)[_visibleViewsArray objectAtIndex:i];
        [_reuseViewsArray addObject:view];
        [_visibleViewsArray removeObject:view];
        if (_horidelegate && objIsa == object_getClass(_horidelegate) && [_horidelegate respondsToSelector:@selector(horizontalViewWillDismiss:index:)])
            [_horidelegate horizontalViewWillDismiss:view index:i];
        [view removeFromSuperview];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat topx = [self offsetx];
    CGFloat botx = [self width]+topx;
    HorizontalView *top = (id)[self.visibleViewsArray firstObject];
    HorizontalView *bot = (id)[self.visibleViewsArray lastObject];
    NSInteger topIndex = top.index;
    NSInteger botIndex = bot.index;
    CGFloat xstacktop = [self originx:topIndex];
    CGFloat xstackbot = [self originx:botIndex];
    CGFloat wstacktop = [self sizewidth:topIndex];
    CGFloat wstackbot = [self sizewidth:botIndex];
    if (topx<xstacktop) {
        [self reachViews:topIndex-1 :YES];
    }
    if (topx>xstacktop+wstacktop) {
        [self removeViews:0];
    }
    if (botx>xstackbot+wstackbot) {
        [self reachViews:botIndex+1 :NO];
    }
    if (botx<xstackbot) {
        [self removeViews:self.visibleViewsArray.count-1];
    }
}

-(CGFloat)offsetx
{
    return self.contentOffset.x;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

- (void)dealloc
{
#if !__has_feature(objc_arc)
    [_visibleViewsArray release];_visibleViewsArray = nil;
    [_reuseViewsArray release];_reuseViewsArray = nil;
    [_viewsDescriptionArray release];_viewsDescriptionArray = nil;
    Block_release(_horizontalViewAtIndex);
    Block_release(_horzontalCount);
    Block_release(_horizontalWidthAtIndex);
    [super dealloc];
#endif
}

@end
