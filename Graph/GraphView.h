//
//  GraphView.h
//  Graph
//
//  Created by Marcus Osobase on 2016-06-17.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define Second 1
#define Minute 60
#define Hour (60 * Minute)

typedef NS_ENUM(NSUInteger, LineStyle) {
  LineStyleSmooth,
  LineStyleStraight
};

typedef NS_ENUM(NSUInteger, GraphDataInputType) {
  /// All graph data will be delivered in one payload
  GraphDataInputConstant,
  /// Graph data will be updated on a rolling basis
  GraphDataInputRolling
};

@interface GraphView : NSView
/// NSArray containing data points reprsenting the y-coordinate of the graph
@property (nonatomic) NSArray *data;
/// Distance between graph points
@property (nonatomic) CGFloat dataSpacing;
/// Curviness of the lines, yes, curviness
@property (nonatomic) float lineCurveValue;
/// Indicate the style of the graph; connected by straight lines or curved lines
@property (nonatomic) LineStyle lineStyle;
/// NSArray of CGColorRef values making up the stroke gradient
@property (nonatomic) NSArray *strokeGradientColors;
/// Indicates if graph data will be delivered in a single payload or by appending new values to data array
@property (nonatomic) GraphDataInputType graphDataInputType;

/// Frequency of rolling updates
@property (nonatomic) NSTimeInterval rollingUpdateFrequency;
/// Indicates how long graph history is retained
@property (nonatomic) NSTimeInterval rollingMaxHistoryInterval;

@end
