//
//  GraphClipView.m
//  Graph
//
//  Created by Marcus Osobase on 2016-07-21.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "GraphClipView.h"
#import "GraphView.h"

@interface GraphClipView()
@property (nonatomic) IBOutlet GraphView *graphView;
@end

@implementation GraphClipView

-(instancetype)initWithCoder:(NSCoder *)coder
{
  if (!(self = [super initWithCoder:coder])) return nil;
  [self postsBoundsChangedNotifications];
  [self registerForNotifications];
  return self;
}

- (void)registerForNotifications
{
  [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(boundsDidChange) name:NSViewBoundsDidChangeNotification object:nil];
}

- (void)boundsDidChange
{
  [self.graphView.layer setNeedsDisplay];
}

@end
