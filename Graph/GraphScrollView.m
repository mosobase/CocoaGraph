//
//  GraphScrollView.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-18.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "GraphScrollView.h"

@implementation GraphScrollView

-(instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    //    self.horizontalScroller.alphaValue = 0;
    self.verticalScroller.alphaValue = 0;
    
  }
  return self;
}

@end
