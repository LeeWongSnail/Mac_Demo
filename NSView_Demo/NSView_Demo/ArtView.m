//
//  ArtView.m
//  NSView_Demo
//
//  Created by LeeWong on 2018/4/14.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ArtView.h"

@implementation ArtView
@synthesize tag = _tag;
- (instancetype)initWithFrame:(NSRect)frameRect
{
    if ([super initWithFrame:frameRect]) {
        //监听鼠标进入和离开
        [self addTrackingRect:NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height) owner:self userData:nil assumeInside:YES];
    }
    return self;
}


- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    self.wantsLayer = YES;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

- (void)setTag:(NSInteger)tag
{
    _tag = tag;
}

//Informs the view that its superview has changed (possibly to nil).
- (void)viewDidMoveToSuperview
{
    NSLog(@"%s",__func__);
}

//Informs the view that its superview is about to change to the specified superview (which may be nil).
- (void)viewWillMoveToSuperview:(NSView *)newSuperview
{
    NSLog(@"%s----%@----%tu",__func__,newSuperview,self.tag);
}

//Informs the view that it’s being added to the view hierarchy of the specified window object (which may be nil).
- (void)viewWillMoveToWindow:(NSWindow *)newWindow
{
    NSLog(@"%s----%@",__func__,newWindow);
}
//Informs the view that it has been added to a new view hierarchy.
- (void)viewDidMoveToWindow
{
    NSLog(@"%s",__func__);
}

- (void)willRemoveSubview:(NSView *)subview
{
    NSLog(@"%s----%@-----tag:%tu",__func__,subview,self.tag);
}

//Overridden by subclasses to return YES if the view should be sent a mouseDown: message for an initial mouse-down event, NO if not.
- (BOOL)acceptsFirstMouse:(NSEvent *)event
{
    NSLog(@"%s",__func__);
    return YES;
}

- (void)rightMouseUp:(NSEvent *)event
{
    NSLog(@"%s",__func__);
}

- (void)rightMouseDown:(NSEvent *)event{
    NSLog(@"%s",__func__);
}

- (void)rightMouseDragged:(NSEvent *)event
{
    NSLog(@"%s",__func__);
}

//监听鼠标的进入 离开
- (void)mouseExited:(NSEvent *)event
{
    NSLog(@"%s----%@",__func__,event);
}

- (void)mouseEntered:(NSEvent *)event
{
    NSLog(@"%s----%@",__func__,event);
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
