//
//  ViewController.m
//  NSView_Demo
//
//  Created by LeeWong on 2018/4/14.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ArtView.h"

@implementation ViewController

- (void)_addSomeViews
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:blueView];
    
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 100, 100)];
    redView.backgroundColor = [NSColor redColor];
    [self.view addSubview:redView];
    
    ArtView *greenView = [[ArtView alloc] initWithFrame:NSMakeRect(10, 10, 200, 100)];
    greenView.backgroundColor = [NSColor greenColor];
    //    NSWindowAbove ,NSWindowBelow ,NSWindowOut
    [self.view addSubview:greenView positioned:NSWindowOut relativeTo:blueView];
    
    NSArray *subviews = self.view.subviews;
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    NSLog(@"nextResponder %@",[redView nextResponder]);
    
}


- (void)_removeSomeViews
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:blueView];
    
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 100, 100)];
    redView.backgroundColor = [NSColor redColor];
    [self.view addSubview:redView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [redView removeFromSuperview];
        [redView removeFromSuperviewWithoutNeedingDisplay];
    });
}


- (void)_replaceView
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:blueView];
    
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 100, 100)];
    redView.backgroundColor = [NSColor redColor];
    [self.view addSubview:redView];
    
    ArtView *greenView = [[ArtView alloc] initWithFrame:NSMakeRect(10, 10, 200, 100)];
    greenView.backgroundColor = [NSColor greenColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view replaceSubview:redView with:greenView];
    });
    
}

//Returns YES if the view is a subview of a given view or if it’s identical to that view; otherwise, it returns NO.

- (void)_descendantView
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:blueView];
    //是否为self.view的子控件
    if ([blueView isDescendantOf:self.view]) {
        NSLog(@"blueview is a subview of myview");
    }
}


//The view’s closest opaque ancestor, which might be the view itself.
- (void)_findOpaqueView
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor clearColor];
    [self.view addSubview:blueView];
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(0, 0, 30, 30)];
    redView.backgroundColor = [NSColor redColor];
    [blueView addSubview:redView];
    
    NSView *opaqueView = [redView opaqueAncestor];
    NSLog(@"%@",opaqueView);
    
}


/**
 找出两个view的共用父view
 */
- (void)_sharedViews
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:blueView];
    
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 10, 10)];
    redView.backgroundColor = [NSColor redColor];
    [blueView addSubview:redView];
    
    ArtView *greenView = [[ArtView alloc] initWithFrame:NSMakeRect(10, 10, 10, 10)];
    greenView.backgroundColor = [NSColor greenColor];
    [blueView addSubview:greenView];
    
    NSLog(@"%@\n%@",[greenView ancestorSharedWithView:redView],blueView);
}


//调整subviews的顺序
NSComparisonResult viewCompareByTag(NSView *firstView, NSView *secondView, void *context) {
    return ([firstView tag] > [secondView tag]) ? NSOrderedDescending : NSOrderedAscending;
};
- (void)_sortSubviews
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    blueView.tag = 1000001;
    [self.view addSubview:blueView];
    
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 10, 10)];
    redView.backgroundColor = [NSColor redColor];
    redView.tag = 1000002;
    [self.view addSubview:redView];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof NSView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    
    NSLog(@"---------------------------------------------------");
    
    [self.view sortSubviewsUsingFunction:&viewCompareByTag context:nil];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof NSView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
}

//观察moveToSuperView 方法的调用
- (void)_viewOrWindowMoveToSuperView
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    blueView.tag = 1000001;
    [self.view addSubview:blueView];
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 10, 10)];
    redView.backgroundColor = [NSColor redColor];
    redView.tag = 1000002;
    [self.view addSubview:redView];
}


//removesubview
- (void)_removeSubView
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.backgroundColor = [NSColor blueColor];
    blueView.tag = 1000001;
    [self.view addSubview:blueView];
    
    ArtView *redView = [[ArtView alloc] initWithFrame:NSMakeRect(20, 20, 10, 10)];
    redView.backgroundColor = [NSColor redColor];
    redView.tag = 1000002;
    [blueView addSubview:redView];
    
    [redView removeFromSuperview];
}

//frameRotation 单位是° 正值逆时针 负值顺时针
- (void)_frameRotation
{
    ArtView *blueView = [[ArtView alloc]  initWithFrame:NSMakeRect(0, 0, 50, 50)];
    blueView.frameRotation = 45;
    blueView.backgroundColor = [NSColor blueColor];
    [self.view addSubview:blueView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self _frameRotation];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
    NSLog(@"%s",__func__);
}


@end
