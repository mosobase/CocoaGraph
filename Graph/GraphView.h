//
//  GraphView.h
//  Graph
//
//  Created by Marcus Osobase on 2016-06-17.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, LineStyle) {
  LineStyleSmooth,
  LineStyleStraight
};

@interface GraphView : NSView

@property (nonatomic) NSArray *data;

@property (nonatomic) float dataSpacing;
@property (nonatomic) float lineCurveValue;
@property (nonatomic) LineStyle lineStyle;


- (void)draw;

@end
