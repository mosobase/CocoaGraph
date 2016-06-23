//
//  GraphScaleView.h
//  Graph
//
//  Created by Marcus Osobase on 2016-06-21.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GraphScaleView : NSView

- (void)updateVeriticalLabelsWithMaxY: (int)maxY;

@property (nonatomic) int numberOfScaleLines;
@end
