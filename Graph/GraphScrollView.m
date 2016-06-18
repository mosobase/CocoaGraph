//
//  GraphScrollView.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-18.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "GraphScrollView.h"
#import "GraphView.h"

@implementation GraphScrollView

-(instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    self.horizontalScroller.alphaValue = 0;
    self.verticalScroller.alphaValue = 0;
  }
  return self;
}

- (void)scrollWheel: (NSEvent *)event
{
  [super scrollWheel: event];
  
  [(GraphView *)self.documentView draw];
  
  NSLog(@"%f", self.documentVisibleRect.origin.x);
}

@end
