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
/// NSArray containing data points reprsenting the y-coordinate of the graph
@property (nonatomic) NSArray *data;
/// Distance between graph points
@property (nonatomic) float dataSpacing;
/// Curviness of the lines, yes, curviness
@property (nonatomic) float lineCurveValue;
/// Indicate the style of the graph; connected by straight lines or curved lines
@property (nonatomic) LineStyle lineStyle;


@end
